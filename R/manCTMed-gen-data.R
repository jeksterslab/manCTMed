#' Simulate Data
#'
#' The function simulates data using
#' the [simStateSpace::SimSSMOUFixed()] function.
#'
#' @inheritParams Template
#'
#' @examples
#' \dontrun{
#' set.seed(42)
#' sim <- GenData(n = 50)
#' plot(sim)
#' }
#' @keywords manCTMed gendata
#' @import simStateSpace
#' @export
GenData <- function(n) {
  return(
    simStateSpace::SimSSMOUFixed(
      n = n,
      time = model$time,
      delta_t = model$delta_t,
      mu0 = model$mu0,
      sigma0_l = model$sigma0_l,
      mu = model$mu,
      phi = model$phi,
      sigma_l = model$sigma_l,
      nu = model$nu,
      lambda = model$lambda,
      theta_l = model$theta_l,
      type = 0
    )
  )
}
