#' Delta Method Confidence Intervals for
#' Conflict-Competence-Knowledge (Grundy, et al. 2007)
#'
#' The function generates delta method confidence intervals
#' for the mediation model conflict-competence-knowledge.
#'
#' @inheritParams Template
#'
#' @examples
#' \dontrun{
#' set.seed(42)
#' library(dynr)
#' data <- Grundy2007GenData(taskid = 1)
#' fit <- Grundy2007FitDynr(data)
#' phi_hat <- PhiHat(fit)
#' ci <- Grundy2007DeltaXYM(phi_hat)
#' plot(ci)
#' }
#' @family Confidence Interval Functions
#' @keywords manCTMed ci grundy
#' @export
Grundy2007DeltaXYM <- function(phi_hat,
                               delta_t = 1:30) {
  DeltaXYM(
    phi_hat = phi_hat,
    delta_t = delta_t
  )
}
