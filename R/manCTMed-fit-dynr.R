#' Fit the Model using the dynr Package
#'
#' The function fits the model using the [dynr] package.
#'
#' @param x R object.
#'   Output of the [Data()] function.
#'
#' @examples
#' library(dynr)
#' data <- Data(repid = 1, n = 50)
#' fit <- FitDynr(x = data)
#'
#' @family Simulation Functions
#' @keywords manCTMed
#' @importFrom stats coef vcov
#' @import dynr
#' @export
FitDynr <- function(x) {
  set.seed(x$args$seed)
  dynr_data <- dynr::dynr.data(
    dataframe = x$data,
    id = "id",
    time = "time",
    observed = c("x", "m", "y")
  )
  dynr_initial <- dynr::prep.initial(
    values.inistate = rep(x = 0, times = 3),
    params.inistate = x$args$mu0,
    values.inicov = x$args$sigma0,
    params.inicov = matrix(
      data = c(
        "sigma0_11", "sigma0_12", "sigma0_13",
        "sigma0_12", "sigma0_22", "sigma0_23",
        "sigma0_13", "sigma0_23", "sigma0_33"
      ),
      nrow = 3
    )
  )
  dynr_measurement <- dynr::prep.measurement(
    values.load = x$args$lambda,
    params.load = matrix(data = "fixed", nrow = 3, ncol = 3),
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
      phi_11 = x$args$phi[1, 1],
      phi_12 = x$args$phi[1, 2],
      phi_13 = x$args$phi[1, 3],
      phi_21 = x$args$phi[2, 1],
      phi_22 = x$args$phi[2, 2],
      phi_23 = x$args$phi[2, 3],
      phi_31 = x$args$phi[3, 1],
      phi_32 = x$args$phi[3, 2],
      phi_33 = x$args$phi[3, 3]
    ),
    isContinuousTime = TRUE
  )
  dynr_noise <- dynr::prep.noise(
    values.latent = x$args$sigma,
    params.latent = matrix(
      data = c(
        "sigma_11", "sigma_12", "sigma_13",
        "sigma_12", "sigma_22", "sigma_23",
        "sigma_13", "sigma_23", "sigma_33"
      ),
      nrow = 3
    ),
    values.observed = x$args$theta,
    params.observed = matrix(
      data = c(
        "theta_11", "fixed", "fixed",
        "fixed", "theta_22", "fixed",
        "fixed", "fixed", "theta_33"
      ),
      nrow = 3
    )
  )
  model <- dynr::dynr.model(
    data = dynr_data,
    initial = dynr_initial,
    measurement = dynr_measurement,
    dynamics = dynr_dynamics,
    noise = dynr_noise,
    outfile = tempfile(
      "src",
      fileext = ".c"
    )
  )
  model@options$maxeval <- 100000
  lb <- ub <- rep(NA, times = length(model$xstart))
  names(ub) <- names(lb) <- names(model$xstart)
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
  ] <- -1.5
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
  ] <- 1.5
  model$lb <- lb
  model$ub <- ub
  dynr_fit <- dynr::dynr.cook(
    model,
    debug_flag = TRUE,
    verbose = FALSE
  )
  parnames <- c(
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
  phi_vec <- coef(dynr_fit)[parnames]
  phi <- matrix(
    data = phi_vec,
    nrow = 3
  )
  colnames(phi) <- rownames(phi) <- c("x", "m", "y")
  vcov <- vcov(dynr_fit)[parnames, parnames]
  return(
    list(
      type = "dynr",
      fit = dynr_fit,
      phi = phi,
      vcov = vcov,
      seed = x$args$seed
    )
  )
}
