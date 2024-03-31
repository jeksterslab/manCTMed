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
#' sim <- GenData(n = 50)
#' data <- RandomMeasurement(sim)
#' FitDynr(data)
#' }
#' @family Model Fitting Functions
#' @keywords manCTMed fit
#' @export
FitDynr <- function(data) {
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
      phi_11 = model$phi[1, 1],
      phi_12 = model$phi[1, 2],
      phi_13 = model$phi[1, 3],
      phi_21 = model$phi[2, 1],
      phi_22 = model$phi[2, 2],
      phi_23 = model$phi[2, 3],
      phi_31 = model$phi[3, 1],
      phi_32 = model$phi[3, 2],
      phi_33 = model$phi[3, 3]
    ),
    isContinuousTime = TRUE
  )
  dynr_noise <- dynr::prep.noise(
    values.latent = model$sigma,
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
      nrow = model$p
    )
  )
  dynr_model <- dynr::dynr.model(
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
  dynr_model@options$maxeval <- 100000
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
  dynr_model$lb <- lb
  dynr_model$ub <- ub
  return(
    dynr::dynr.cook(
      dynr_model,
      debug_flag = TRUE,
      verbose = FALSE
    )
  )
}
