#' Parametric Bootstrap Confidence Intervals for X-Y-M
#' (Standardized)
#'
#' The function generates parametric bootstrap method confidence intervals
#' for the mediation model \eqn{X \to Y \to M}
#' (Standardized).
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
#' theta_hat <- ThetaHat(fit)
#' ci <- BootParaStdXYM(boot = boot, theta_hat = theta_hat)
#' plot(ci)
#' plot(ci, type = "bc")
#' }
#' @family Confidence Interval Functions
#' @keywords manCTMed ci
#' @export
BootParaStdXYM <- function(boot,
                           theta_hat,
                           delta_t = 1:30,
                           ncores = NULL) {
  cTMed::BootMedStd(
    phi = bootStateSpace::extract(
      object = boot,
      what = "phi"
    ),
    sigma = bootStateSpace::extract(
      object = boot,
      what = "sigma"
    ),
    phi_hat = theta_hat$phi,
    sigma_hat = theta_hat$sigma,
    delta_t = delta_t,
    from = "x", # grundy reciprocal
    to = "m",
    med = "y",
    ncores = ncores
  )
}
