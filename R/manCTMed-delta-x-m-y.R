#' Delta Method Confidence Intervals for X-M-Y
#'
#' The function generates delta method confidence intervals
#' for the mediation model \eqn{X \to M \to Y}.
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
#' ci <- DeltaXMY(phi_hat)
#' plot(ci)
#' }
#' @family Confidence Interval Functions
#' @keywords manCTMed ci
#' @import dynr
#' @import cTMed
#' @export
DeltaXMY <- function(phi_hat,
                     delta_t = 1:30) {
  cTMed::DeltaMed(
    phi = phi_hat$coef,
    vcov_phi_vec = phi_hat$vcov,
    delta_t = delta_t,
    from = "x", # always x for forward
    to = "y", # always y for forward
    med = "m",
    ncores = NULL
  )
}
