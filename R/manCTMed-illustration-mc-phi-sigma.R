#' Generate a Sampling Distribution of Drift Matrices
#' and Process Noise Covariance Matrices (Illustration)
#'
#' The function generates a sampling distribution of drift matrices
#' and process noise covariance matrices using te Monte Carlo method.
#'
#' @inheritParams TemplateIllustration
#'
#' @examples
#' \dontrun{
#' library(dynr)
#' sim <- IllustrationGenData(seed = 42)
#' data <- IllustrationPrepData(sim)
#' fit <- IllustrationFitDynr(data)
#' IllustrationMCPhiSigma(fit, seed = 42)
#' }
#' @family Model Fitting Functions
#' @keywords manCTMed ci illustration
#' @import dynr
#' @importFrom stats coef
#' @export
IllustrationMCPhiSigma <- function(fit,
                                   R = 20000L,
                                   seed = NULL) {
  theta_hat <- ThetaHat(fit)
  cTMed::MCPhiSigma(
    phi = theta_hat$phi,
    sigma = theta_hat$sigma,
    vcov_theta = theta_hat$vcov,
    R = R,
    test_phi = TRUE,
    ncores = NULL,
    seed = seed
  )
}
