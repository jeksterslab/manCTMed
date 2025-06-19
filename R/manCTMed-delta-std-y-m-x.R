#' Delta Method Confidence Intervals for Y-M-X (Standardized)
#'
#' The function generates delta method confidence intervals
#' for the mediation model \eqn{Y \to M \to X} (Standardized).
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
#' ci <- DeltaStdYMX(theta_hat)
#' plot(ci)
#' }
#' @family Confidence Interval Functions
#' @keywords manCTMed ci
#' @export
DeltaStdYMX <- function(theta_hat,
                        delta_t = 1:30) {
  cTMed::DeltaMedStd(
    phi = theta_hat$phi,
    sigma = theta_hat$sigma,
    vcov_theta = theta_hat$vcov,
    delta_t = delta_t,
    from = "x", # grundy reciprocal
    to = "m",
    med = "y",
    ncores = NULL
  )
}
