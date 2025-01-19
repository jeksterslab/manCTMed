#' Parametric Bootstrap Confidence Intervals for X-Y-M
#' (Standardized)
#' (Grundy, et al. 2007)
#'
#' The function generates parametric bootstrap method confidence intervals
#' for the mediation model \eqn{X \to Y \to M}
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
#' ci <- Grundy2007BootParaStdXYM(boot = boot, theta_hat = theta_hat)
#' plot(ci)
#' plot(ci, type = "bc")
#' }
#' @family Confidence Interval Functions
#' @keywords manCTMed ci grundy
#' @export
Grundy2007BootParaStdXYM <- function(boot,
                                     theta_hat,
                                     delta_t = 1:30,
                                     ncores = NULL) {
  BootParaStdXYM(
    boot = boot,
    theta_hat = theta_hat,
    delta_t = delta_t,
    ncores = ncores
  )
}
