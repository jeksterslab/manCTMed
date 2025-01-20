#' Fit the CT-VAR Model (Grundy, et al. 2007)
#'
#' @param data R object.
#'   Output of the [Grundy2007GenData()] function.
#'
#' @examples
#' \dontrun{
#' library(dynr)
#' data <- Grundy2007GenData(taskid = 1)
#' fit <- Grundy2007FitDynr(data)
#' summary(fit)
#' }
#' @family Model Fitting Functions
#' @keywords manCTMed fit grundy
#' @export
Grundy2007FitDynr <- function(data) {
  varnames <- c(
    "x",
    "m",
    "y"
  )
  phi <- matrix(
    data = c(
      -0.033712,
      0.037816,
      -0.013207,
      -0.152350,
      -0.590262,
      0.230235,
      -0.100435,
      0.105462,
      -0.515149
    ),
    nrow = 3,
    ncol = 3
  )
  sigma <- matrix(
    data = c(
      0.057708,
      -0.008654,
      0.010219,
      -0.008654,
      0.746297,
      0.099170,
      0.010219,
      0.099170,
      0.841681
    ),
    nrow = 3,
    ncol = 3
  )
  theta <- diag(3)
  diag(theta) <- c(
    0.104821,
    0.171725,
    0.078654
  )
  dynr_data <- dynr::dynr.data(
    dataframe = data,
    id = "id",
    time = "time",
    observed = varnames
  )
  data_0 <- data[which(data[, "time"] == 0), ]
  dynr_initial <- dynr::prep.initial(
    values.inistate = colMeans(data_0)[
      varnames
    ],
    params.inistate = rep(x = "fixed", times = 3),
    values.inicov = stats::cov(data_0)[
      varnames,
      varnames
    ],
    params.inicov = matrix(
      data = "fixed",
      nrow = 3,
      ncol = 3
    )
  )
  dynr_measurement <- dynr::prep.measurement(
    values.load = diag(3),
    params.load = matrix(
      data = "fixed",
      nrow = 3,
      ncol = 3
    ),
    state.names = c("eta_x", "eta_m", "eta_y"),
    obs.names = varnames
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
      nrow = 3
    ),
    values.observed = theta,
    params.observed = matrix(
      data = c(
        "theta_11", "fixed", "fixed",
        "fixed", "theta_22", "fixed",
        "fixed", "fixed", "theta_33"
      ),
      nrow = 3
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
  ] <- .Machine$double.xmin
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
    fit <- dynr::dynr.cook(
      dynr_model,
      hessian_flag = TRUE,
      debug_flag = TRUE,
      verbose = FALSE
    )
  )
  rerun <- any(
    is.nan(
      sqrt(
        diag(fit$inv.hessian)
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
        fit <- dynr::dynr.cook(
          dynr_model,
          hessian_flag = TRUE,
          debug_flag = TRUE,
          verbose = FALSE
        )
      )
      rerun <- any(
        is.nan(
          sqrt(
            diag(fit$inv.hessian)
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
