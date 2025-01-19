#' Parametric Bootstrap Confidence Intervals for X-M-Y
#' (Standardized)
#'
#' The function generates parametric bootstrap method confidence intervals
#' for the mediation model \eqn{X \to M \to Y}
#' (Standardized).
#'
#' @inheritParams Template
#'
#' @examples
#' \dontrun{
#' library(dynr)
#' data <- Grundy2007GenData(taskid = 1)
#' fit <- Grundy2007FitDynr(data)
#' boot <- GrundyBootPara(
#'   fit = fit,
#'   data = data,
#'   path = getwd(),
#'   prefix = "pb",
#'   B = 1000L
#' )
#' theta_hat <- ThetaHat(fit)
#' ci <- Grundy2007BootParaStdXMY(boot = boot, theta_hat = theta_hat)
#' plot(ci)
#' plot(ci, type = "bc")
#' }
#' @family Confidence Interval Functions
#' @keywords manCTMed ci grundy
#' @export
Grundy2007BootParaStdXMY <- function(boot,
                                     theta_hat,
                                     delta_t = 1:30,
                                     ncores = NULL) {
  BootParaStdXMY(
    boot = boot,
    theta_hat = theta_hat,
    delta_t = delta_t,
    ncores = ncores
  )
}
