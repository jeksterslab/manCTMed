#' Simulation Parameters
#'
#' @author Ivan Jacob Agaloos Pesigan
#'
#' @docType data
#' @name params
#' @usage data(params)
#' @format A dataframe with 30 rows and 3 columns:
#'
#' \describe{
#'   \item{taskid}{
#'     Simulation Task ID.
#'   }
#'   \item{n}{
#'     Sample size.
#'   }
#'   \item{dynamics}{
#'     Dynamics.
#'     `0` for original drift matrix,
#'     `-1` for near-neutral dynamics, and
#'     `1` for stronger damping.
#'   }
#' }
#'
#' @keywords data parameters
"params"
