#' Parametric Bootstrap Confidence Intervals for Y-M-X
#'
#' The function generates parametric bootstrap method confidence intervals
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
#' boot <- BootPara(
#'   fit = fit,
#'   path = getwd(),
#'   prefix = "pb",
#'   taskid = 1,
#'   B = 1000L
#' )
#' phi_hat <- PhiHat(fit)
#' ci <- BootParaYMX(boot = boot, phi_hat = phi_hat)
#' plot(ci)
#' plot(ci, type = "bc")
#' }
#' @family Confidence Interval Functions
#' @keywords manCTMed ci
#' @export
BootParaYMX <- function(boot,
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
    from = "y", # always y for backward
    to = "x", # always x for backward
    med = "m",
    ncores = ncores
  )
}
