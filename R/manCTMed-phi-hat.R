#' Estimated Drift Matrix
#'
#' The function extracts the estimated drift matrix
#' from the fitted model.
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
#' PhiHat(fit)
#' }
#' @family Model Fitting Functions
#' @keywords manCTMed ci
#' @importFrom stats coef vcov
#' @import dynr
#' @export
PhiHat <- function(fit) {
  parnames <- c(
    "phi_11",
    "phi_21",
    "phi_31",
    "phi_12",
    "phi_22",
    "phi_32",
    "phi_13",
    "phi_23",
    "phi_33"
  )
  phi <- matrix(
    data = coef(fit)[parnames],
    nrow = 3
  )
  colnames(phi) <- rownames(phi) <- c("x", "m", "y")
  list(
    coef = phi,
    vcov = vcov(fit)[parnames, parnames]
  )
}
