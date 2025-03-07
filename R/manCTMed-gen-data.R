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
#' sim <- GenData(taskid = 1)
#' plot(sim)
#' }
#' @family Data Generation Functions
#' @keywords manCTMed gendata
#' @import simStateSpace
#' @export
GenData <- function(taskid) {
  param <- params[taskid, ]
  if (param$dynamics == 0) {
    phi <- model$phi_zero
    sigma_l <- model$sigma_l_zero
  }
  if (param$dynamics == 1) {
    phi <- model$phi_pos
    sigma_l <- model$sigma_l_pos
  }
  if (param$dynamics == -1) {
    phi <- model$phi_neg
    sigma_l <- model$sigma_l_neg
  }
  simStateSpace::SimSSMOUFixed(
    n = param$n,
    time = model$time,
    delta_t = model$delta_t,
    mu0 = model$mu0,
    sigma0_l = model$sigma0_l,
    mu = model$mu,
    phi = phi,
    sigma_l = sigma_l,
    nu = model$nu,
    lambda = model$lambda,
    theta_l = model$theta_l,
    type = 0
  )
}
