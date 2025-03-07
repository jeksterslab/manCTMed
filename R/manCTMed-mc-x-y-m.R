#' Monte Carlo Method Confidence Intervals for X-Y-M
#'
#' The function generates Monte Carlo method confidence intervals
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
#' ci <- MCXYM(phi_hat, seed = 42)
#' plot(ci)
#' }
#' @family Confidence Interval Functions
#' @keywords manCTMed ci
#' @export
MCXYM <- function(phi_hat,
                  delta_t = 1:30,
                  R = 20000L,
                  seed = NULL) {
  cTMed::MCMed(
    phi = phi_hat$coef,
    vcov_phi_vec = phi_hat$vcov,
    delta_t = delta_t,
    from = "x", # grundy reciprocal
    to = "m",
    med = "y",
    R = R,
    seed = seed,
    ncores = NULL
  )
}
