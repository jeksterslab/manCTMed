#' Delta Method Confidence Intervals for X-M-Y (Standardized)
#'
#' The function generates delta method confidence intervals
#' for the mediation model \eqn{X \to M \to Y} (Standardized).
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
#' ci <- DeltaStdXMY(theta_hat)
#' plot(ci)
#' }
#' @family Confidence Interval Functions
#' @keywords manCTMed ci
#' @import dynr
#' @import cTMed
#' @export
DeltaStdXMY <- function(theta_hat,
                        delta_t = 1:30) {
  cTMed::DeltaMedStd(
    phi = theta_hat$phi,
    sigma = theta_hat$sigma,
    vcov_theta = theta_hat$vcov,
    delta_t = delta_t,
    from = "x", # always x for forward
    to = "y", # always y for forward
    med = "m",
    ncores = NULL
  )
}
