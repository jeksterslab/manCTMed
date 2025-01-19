#' Parametric Bootstrap Confidence Intervals for X-Y-M
#'
#' The function generates parametric bootstrap method confidence intervals
#' for the mediation model \eqn{X \to Y \to M}.
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
#' ci <- Grundy2007BootParaXYM(boot = boot, phi_hat = phi_hat)
#' plot(ci)
#' plot(ci, type = "bc")
#' }
#' @family Confidence Interval Functions
#' @keywords manCTMed ci grundy
#' @export
Grundy2007BootParaXYM <- function(boot,
                                  phi_hat,
                                  delta_t = 1:30,
                                  ncores = NULL) {
  BootParaXYM(
    boot = boot,
    phi_hat = phi_hat,
    delta_t = delta_t,
    ncores = ncores
  )
}
