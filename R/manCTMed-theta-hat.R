#' Estimated Drift Matrix and Process Noise
#'
#' The function extracts the estimated drift matrix and process noise
#' from the fitted model.
#'
#' @inheritParams Template
#'
#' @examples
#' \dontrun{
#' set.seed(42)
#' library(dynr)
#' sim <- GenData(n = 50)
#' data <- RandomMeasurement(sim)
#' fit <- FitDynr(data)
#' ThetaHat(fit)
#' }
#' @family Model Fitting Functions
#' @keywords manCTMed ci
#' @importFrom stats coef vcov
#' @import dynr
#' @export
ThetaHat <- function(fit) {
  phi_vec <- c(
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
  sigma_vec <- c(
    "sigma_11", "sigma_12", "sigma_13",
    "sigma_12", "sigma_22", "sigma_23",
    "sigma_13", "sigma_23", "sigma_33"
  )
  theta_vec <- c(
    "phi_11",
    "phi_21",
    "phi_31",
    "phi_12",
    "phi_22",
    "phi_32",
    "phi_13",
    "phi_23",
    "phi_33",
    "sigma_11", "sigma_12", "sigma_13",
    "sigma_22", "sigma_23",
    "sigma_33"
  )
  coefs <- coef(fit)[theta_vec]
  phi <- matrix(
    data = coefs[phi_vec],
    nrow = 3,
    ncol = 3
  )
  colnames(phi) <- rownames(phi) <- c("x", "m", "y")
  sigma <- matrix(
    data = coefs[sigma_vec],
    nrow = 3,
    ncol = 3
  )
  list(
    phi = phi,
    sigma = sigma,
    coef = coefs[theta_vec],
    vcov = vcov(fit)[theta_vec, theta_vec]
  )
}
