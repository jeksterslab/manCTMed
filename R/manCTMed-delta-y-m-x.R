#' Delta Method Confidence Intervals for Y-M-X
#'
#' The function generates delta method confidence intervals
#' for the mediation model \eqn{Y \to M \to X}.
#'
#' @inheritParams Template
#'
#' @examples
#' \dontrun{
#' set.seed(42)
#' library(dynr)
#' sim <- GenData(n = 50)
#' data <- RandomMeasurement(sim)
#' fit <- FitDynr(data)
#' phi_hat <- PhiHat(fit)
#' ci <- DeltaYMX(phi_hat)
#' plot(ci)
#' }
#' @keywords manCTMed ci
#' @importFrom stats coef vcov
#' @import dynr
#' @export
DeltaYMX <- function(phi_hat,
                     delta_t = 1:30) {
  return(
    cTMed::DeltaMed(
      phi = phi_hat$coef,
      vcov_phi_vec = phi_hat$vcov,
      delta_t = delta_t,
      from = "y", # always y for backward
      to = "x", # always x for backward
      med = "m",
      ncores = NULL
    )
  )
}
