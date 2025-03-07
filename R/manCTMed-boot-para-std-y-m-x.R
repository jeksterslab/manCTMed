#' Parametric Bootstrap Confidence Intervals for Y-M-X
#' (Standardized)
#'
#' The function generates parametric bootstrap method confidence intervals
#' for the mediation model \eqn{Y \to M \to X}
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
#' ci <- BootParaStdYMX(boot = boot, theta_hat = theta_hat)
#' plot(ci)
#' plot(ci, type = "bc")
#' }
#' @family Confidence Interval Functions
#' @keywords manCTMed ci
#' @export
BootParaStdYMX <- function(boot,
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
    from = "y", # always y for backward
    to = "x", # always x for backward
    med = "m",
    ncores = ncores
  )
}
