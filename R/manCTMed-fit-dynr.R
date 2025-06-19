#' Fit the Model using the dynr Package
#'
#' The function fits the model using the [dynr] package.
#'
#' @inheritParams Template
#'
#' @examples
#' \dontrun{
#' set.seed(42)
#' library(dynr)
#' sim <- GenData(taskid = 1)
#' data <- RandomMeasurement(sim)
#' fit <- FitDynr(data, taskid = 1)
#' summary(fit)
#' }
#' @family Model Fitting Functions
#' @keywords manCTMed fit
#' @import dynr
#' @importFrom stats coef
#' @export
FitDynr <- function(data,
                    taskid) {
  param <- params[taskid, ]
  if (param$dynamics == 0) {
    phi <- model$phi_zero
    sigma <- model$sigma_zero
  }
  if (param$dynamics == 1) {
    phi <- model$phi_pos
    sigma <- model$sigma_pos
  }
  if (param$dynamics == -1) {
    phi <- model$phi_neg
    sigma <- model$sigma_neg
  }
  dynr_data <- dynr::dynr.data(
    dataframe = data,
    id = "id",
    time = "time",
    observed = c("x", "m", "y")
  )
  dynr_initial <- dynr::prep.initial(
    values.inistate = model$mu0,
    params.inistate = c(
      "mu0_1",
      "mu0_2",
      "mu0_3"
    ),
    values.inicov = model$sigma0,
    params.inicov = matrix(
      data = c(
        "sigma0_11", "sigma0_12", "sigma0_13",
        "sigma0_12", "sigma0_22", "sigma0_23",
        "sigma0_13", "sigma0_23", "sigma0_33"
      ),
      nrow = model$p
    )
  )
  dynr_measurement <- dynr::prep.measurement(
    values.load = model$lambda,
    params.load = matrix(
      data = "fixed",
      nrow = model$k,
      ncol = model$k
    ),
    state.names = c("eta_x", "eta_m", "eta_y"),
    obs.names = c("x", "m", "y")
  )
  dynr_dynamics <- dynr::prep.formulaDynamics(
    formula = list(
      eta_x ~ phi_11 * eta_x + phi_12 * eta_m + phi_13 * eta_y,
      eta_m ~ phi_21 * eta_x + phi_22 * eta_m + phi_23 * eta_y,
      eta_y ~ phi_31 * eta_x + phi_32 * eta_m + phi_33 * eta_y
    ),
    startval = c(
      phi_11 = phi[1, 1],
      phi_12 = phi[1, 2],
      phi_13 = phi[1, 3],
      phi_21 = phi[2, 1],
      phi_22 = phi[2, 2],
      phi_23 = phi[2, 3],
      phi_31 = phi[3, 1],
      phi_32 = phi[3, 2],
      phi_33 = phi[3, 3]
    ),
    isContinuousTime = TRUE
  )
  dynr_noise <- dynr::prep.noise(
    values.latent = sigma,
    params.latent = matrix(
      data = c(
        "sigma_11", "sigma_12", "sigma_13",
        "sigma_12", "sigma_22", "sigma_23",
        "sigma_13", "sigma_23", "sigma_33"
      ),
      nrow = model$p
    ),
    values.observed = model$theta,
    params.observed = matrix(
      data = c(
        "theta_11", "fixed", "fixed",
        "fixed", "theta_22", "fixed",
        "fixed", "fixed", "theta_33"
      ),
      nrow = model$k
    )
  )
  outfile <- tempfile(
    paste0(
      "src-",
      paste0(
        sample(
          x = c(
            letters,
            LETTERS,
            0:9
          ),
          size = 8,
          replace = TRUE
        ),
        collapse = ""
      ),
      format(
        Sys.time(),
        "%Y-%m-%d-%H-%M-%OS3"
      )
    )
  )
  on.exit(
    unlink(
      paste0(
        outfile,
        c(
          ".c",
          ".s",
          ".so"
        )
      )
    )
  )
  dynr_model <- dynr::dynr.model(
    data = dynr_data,
    initial = dynr_initial,
    measurement = dynr_measurement,
    dynamics = dynr_dynamics,
    noise = dynr_noise,
    outfile = paste0(
      outfile,
      ".c"
    )
  )
  lb <- ub <- rep(NA, times = length(dynr_model$xstart))
  names(ub) <- names(lb) <- names(dynr_model$xstart)
  lb[
    c(
      "sigma0_11",
      "sigma0_22",
      "sigma0_33"
    )
  ] <- .Machine$double.xmin
  lb[
    c(
      "phi_11",
      "phi_21",
      "phi_31",
      "phi_12",
      "phi_22",
      "phi_32",
      "phi_13",
      "phi_23",
      "phi_33"
    )
  ] <- -4
  ub[
    c(
      "phi_11",
      "phi_21",
      "phi_31",
      "phi_12",
      "phi_22",
      "phi_32",
      "phi_13",
      "phi_23",
      "phi_33"
    )
  ] <- 4
  ub[
    c(
      "phi_11",
      "phi_22",
      "phi_33"
    )
  ] <- -1 * .Machine$double.xmin
  lb[
    c(
      "sigma_11",
      "sigma_22",
      "sigma_33"
    )
  ] <- .Machine$double.xmin
  lb[
    c(
      "theta_11",
      "theta_22",
      "theta_33"
    )
  ] <- .Machine$double.xmin
  dynr_model$lb <- lb
  dynr_model$ub <- ub
  try(
    suppressWarnings({
      fit <- dynr::dynr.cook(
        dynr_model,
        hessian_flag = TRUE,
        debug_flag = TRUE,
        verbose = FALSE
      )
    }),
    silent = TRUE
  )
  rerun <- any(
    is.nan(
      suppressWarnings(
        sqrt(
          diag(fit$inv.hessian)
        )
      )
    )
  )
  if (rerun) {
    max_iter <- 10000
    for (i in seq_len(max_iter)) {
      ## jitter the drift matrix
      est <- coef(fit)
      est[
        c(
          "phi_21",
          "phi_31",
          "phi_12",
          "phi_32",
          "phi_13",
          "phi_23"
        )
      ] + stats::runif(
        n = 6,
        min = -.2,
        max = +.2
      )
      coef(dynr_model) <- est
      try(
        suppressWarnings({
          fit <- dynr::dynr.cook(
            dynr_model,
            hessian_flag = TRUE,
            debug_flag = TRUE,
            verbose = FALSE
          )
        }),
        silent = TRUE
      )
      rerun <- any(
        is.nan(
          suppressWarnings(
            sqrt(
              diag(fit$inv.hessian)
            )
          )
        )
      )
      if (!rerun) {
        return(fit)
      }
      if (i > max_iter) {
        stop("Max iterations reached.")
      }
    }
  } else {
    return(fit)
  }
}
