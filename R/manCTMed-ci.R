#' Generate Confidence Intervals
#' for the Total, Direct, and Indirect Effects
#'
#' The function generates confidence intervals
#' for the total, direct, amd indirect effects
#' using the [cTMed] package.
#'
#' @param x R object.
#'   Output of the [FitDynr()] function.
#' @param delta_t Numeric vector.
#'   Vector of time-intervals to use.
#' @param R Positive integer.
#'   Number of Monte Carlo replications.
#'
#' @examples
#' \dontrun{
#' # dynr
#' library(dynr)
#' data <- Data(repid = 1, n = 50)
#' fit <- FitDynr(x = data)
#' CI(fit)
#' }
#' @family Simulation Functions
#' @keywords manCTMed
#' @import cTMed
#' @export
CI <- function(x,
               delta_t = 1:24,
               R = 20000L) {
  med <- "m"
  ncores <- NULL
  phi <- x$phi
  vcov_phi_vec <- x$vcov
  seed <- x$seed
  return(
    list(
      type = x$type,
      delta_t = delta_t,
      delta = cTMed::DeltaMed(
        phi = phi,
        vcov_phi_vec = vcov_phi_vec,
        delta_t = delta_t,
        from = "x",
        to = "y",
        med = med,
        ncores = ncores
      ),
      mc = cTMed::MCMed(
        phi = phi,
        vcov_phi_vec = vcov_phi_vec,
        delta_t = delta_t,
        from = "x",
        to = "y",
        med = med,
        R = R,
        ncores = ncores,
        seed = seed
      ),
      delta0 = cTMed::DeltaMed(
        phi = phi,
        vcov_phi_vec = vcov_phi_vec,
        delta_t = delta_t,
        from = "y",
        to = "x",
        med = med,
        ncores = ncores
      ),
      mc0 = cTMed::MCMed(
        phi = phi,
        vcov_phi_vec = vcov_phi_vec,
        delta_t = delta_t,
        from = "y",
        to = "x",
        med = med,
        R = R,
        ncores = ncores,
        seed = seed
      )
    )
  )
}
