#' Parametric Bootstrap Confidence Intervals for X-M-Y
#'
#' The function generates parametric bootstrap method confidence intervals
#' for the mediation model \eqn{X \to M \to Y}.
#'
#' @inheritParams Template
#'
#' @examples
#' \dontrun{
#' set.seed(42)
#' library(dynr)
#' library(simStateSpace)
#' library(cTMed)
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
#' ci <- BootParaStdXMY(boot = boot, theta_hat = theta_hat)
#' summary(ci)
#' summary(ci, type = "bc")
#' }
#' @family Confidence Interval Functions
#' @keywords manCTMed ci
#' @export
BootParaStdXMY <- function(boot,
                           theta_hat,
                           delta_t = 1:30,
                           ncores = NULL) {
  return(
    cTMed::BootMedStd(
      phi = simStateSpace::extract(
        object = boot,
        what = "phi"
      ),
      sigma = simStateSpace::extract(
        object = boot,
        what = "sigma"
      ),
      phi_hat = theta_hat$phi,
      sigma_hat = theta_hat$sigma,
      delta_t = delta_t,
      from = "x", # always x for forward
      to = "y", # always y for forward
      med = "m",
      ncores = ncores
    )
  )
}
