#' Monte Carlo Method Confidence Intervals for X-Y-M (Standardized)
#'
#' The function generates Monte Carlo method confidence intervals
#' for the mediation model \eqn{X \to Y \to M} (Standardized).
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
#' theta_hat <- ThetaHat(fit)
#' ci <- MCStdXYM(theta_hat, seed = 42)
#' plot(ci)
#' }
#' @family Confidence Interval Functions
#' @keywords manCTMed ci
#' @export
MCStdXYM <- function(theta_hat,
                     delta_t = 1:30,
                     R = 20000L,
                     seed = NULL) {
  cTMed::MCMedStd(
    phi = theta_hat$phi,
    sigma = theta_hat$sigma,
    vcov_theta = theta_hat$vcov,
    delta_t = delta_t,
    from = "x", # grundy reciprocal
    to = "m",
    med = "y",
    R = R,
    seed = seed,
    ncores = NULL
  )
}
