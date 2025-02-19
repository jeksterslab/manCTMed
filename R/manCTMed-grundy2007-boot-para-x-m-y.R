#' Parametric Bootstrap Confidence Intervals for X-M-Y
#' (Grundy, et al. 2007)
#'
#' The function generates parametric bootstrap method confidence intervals
#' for the mediation model \eqn{X \to M \to Y}.
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
#' phi_hat <- PhiHat(fit)
#' ci <- Grundy2007BootParaXMY(boot = boot, phi_hat = phi_hat)
#' plot(ci)
#' plot(ci, type = "bc")
#' }
#' @family Confidence Interval Functions
#' @keywords manCTMed ci grundy
#' @export
Grundy2007BootParaXMY <- function(boot,
                                  phi_hat,
                                  delta_t = 1:30,
                                  ncores = NULL) {
  BootParaXMY(
    boot = boot,
    phi_hat = phi_hat,
    delta_t = delta_t,
    ncores = ncores
  )
}
