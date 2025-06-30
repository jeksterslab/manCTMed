#' Parametric Bootstrap Confidence Intervals for X-Y-M
#'
#' The function generates parametric bootstrap method confidence intervals
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
#' boot <- BootPara(
#'   fit = fit,
#'   path = getwd(),
#'   prefix = "pb",
#'   taskid = 1,
#'   B = 1000L
#' )
#' phi_hat <- PhiHat(fit)
#' ci <- BootParaXYM(boot = boot, phi_hat = phi_hat)
#' plot(ci)
#' plot(ci, type = "bc")
#' }
#' @family Confidence Interval Functions
#' @keywords manCTMed ci
#' @export
BootParaXYM <- function(boot,
                        phi_hat,
                        delta_t = 1:30,
                        ncores = NULL) {
  cTMed::BootMed(
    phi = bootStateSpace::extract(
      object = boot,
      what = "phi"
    ),
    phi_hat = phi_hat$coef,
    delta_t = delta_t,
    from = "x", # grundy reciprocal
    to = "m",
    med = "y",
    ncores = ncores
  )
}
