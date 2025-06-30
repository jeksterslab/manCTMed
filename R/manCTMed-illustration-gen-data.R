#' Simulate Data (Illustration)
#'
#' The function simulates data using
#' the [simStateSpace::SimSSMOUFixed()] function.
#'
#' @inheritParams TemplateIllustration
#'
#' @examples
#' \dontrun{
#' sim <- IllustrationGenData(seed = 42)
#' plot(sim)
#' }
#' @family Data Generation Functions
#' @keywords manCTMed gendata illustration
#' @import simStateSpace
#' @export
IllustrationGenData <- function(seed = NULL,
                                n = 133,
                                m = 101,
                                delta_t_gen = 0.10) {
  if (!is.null(seed)) {
    set.seed(seed)
  }
  phi <- matrix(
    data = c(
      -0.138,
      -0.124,
      -0.057,
      0,
      -0.865,
      0.115,
      0,
      0.434,
      -0.693
    ),
    nrow = 3,
    ncol = 3
  )
  sigma <- theta <- 0.10 * diag(3)
  sigma0 <- simStateSpace::LinSDECov(
    phi = phi,
    sigma = sigma
  )
  sigma0 <- (sigma0 + t(sigma0)) / 2
  simStateSpace::SimSSMOUFixed(
    n = n,
    time = m,
    delta_t = delta_t_gen,
    mu0 = rep(
      x = 0,
      times = 3
    ),
    sigma0_l = t(chol(sigma0)),
    mu = rep(
      x = 0,
      times = 3
    ),
    phi = phi,
    sigma_l = t(chol(sigma)),
    nu = rep(
      x = 0,
      times = 3
    ),
    lambda = diag(3),
    theta_l = t(chol(theta)),
    type = 0
  )
}
