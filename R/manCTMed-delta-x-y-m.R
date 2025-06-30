#' Delta Method Confidence Intervals for X-Y-M
#'
#' The function generates delta method confidence intervals
#' for the mediation model \eqn{X \to Y \to M}.
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
#' phi_hat <- PhiHat(fit)
#' ci <- DeltaXYM(phi_hat)
#' plot(ci)
#' }
#' @family Confidence Interval Functions
#' @keywords manCTMed ci
#' @import dynr
#' @import cTMed
#' @export
DeltaXYM <- function(phi_hat,
                     delta_t = 1:30) {
  cTMed::DeltaMed(
    phi = phi_hat$coef,
    vcov_phi_vec = phi_hat$vcov,
    delta_t = delta_t,
    from = "x", # grundy reciprocal
    to = "m",
    med = "y",
    ncores = NULL
  )
}
