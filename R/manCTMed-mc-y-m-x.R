#' Monte Carlo Method Confidence Intervals for Y-M-X
#'
#' The function generates Monte Carlo method confidence intervals
#' for the mediation model \eqn{Y \to M \to X}.
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
#' ci <- MCYMX(phi_hat, seed = 42)
#' plot(ci)
#' }
#' @family Confidence Interval Functions
#' @keywords manCTMed ci
#' @export
MCYMX <- function(phi_hat,
                  delta_t = 1:30,
                  R = 20000L,
                  seed = NULL) {
  cTMed::MCMed(
    phi = phi_hat$coef,
    vcov_phi_vec = phi_hat$vcov,
    delta_t = delta_t,
    from = "y", # always y for backward
    to = "x", # always x for backward
    med = "m",
    R = R,
    seed = seed,
    ncores = NULL
  )
}
