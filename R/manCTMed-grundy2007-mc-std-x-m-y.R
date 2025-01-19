#' Monte Carlo Method Confidence Intervals for
#' Conflict-Knowledge-Competence (Grundy, et al. 2007)
#'
#' The function generates Monte Carlo method confidence intervals
#' for the mediation model conflict-knowledge-competence.
#'
#' @inheritParams Template
#'
#' @examples
#' \dontrun{
#' set.seed(42)
#' library(dynr)
#' data <- Grundy2007GenData(taskid = 1)
#' fit <- Grundy2007FitDynr(data)
#' theta_hat <- ThetaHat(fit)
#' ci <- Grundy2007MCStdXMY(theta_hat, seed = 42)
#' plot(ci)
#' }
#' @family Confidence Interval Functions
#' @keywords manCTMed ci grundy
#' @export
Grundy2007MCStdXMY <- function(theta_hat,
                               delta_t = 1:30,
                               R = 20000L,
                               seed = NULL) {
  MCStdXMY(
    theta_hat = theta_hat,
    delta_t = delta_t,
    R = R,
    seed = seed
  )
}
