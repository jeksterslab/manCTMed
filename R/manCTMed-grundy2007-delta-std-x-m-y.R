#' DeltaStd Method Confidence Intervals for
#' Conflict-Knowledge-Competence (Grundy, et al. 2007)
#'
#' The function generates delta method confidence intervals
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
#' ci <- Grundy2007DeltaStdXMY(theta_hat)
#' plot(ci)
#' }
#' @family Confidence Interval Functions
#' @keywords manCTMed ci grundy
#' @export
Grundy2007DeltaStdXMY <- function(theta_hat,
                                  delta_t = 1:30) {
  DeltaStdXMY(
    theta_hat = theta_hat,
    delta_t = delta_t
  )
}
