#' Simulated Data Using Parameters from Deboeck and Preacher (2015)
#'
#' The data was simulated using [simStateSpace::SimSSMVARFixed()]
#' from a discrete-time vector autoregressive model
#' given by
#'
#' \deqn{
#'   \mathbf{y}_{i, t}
#'   =
#'   \boldsymbol{\beta} \mathbf{y}_{i, t - 1}
#'   +
#'   \boldsymbol{\varepsilon}_{i, t}
#' }
#'
#' where \eqn{\mathbf{y}_{i, t}} and \eqn{\mathbf{y}_{i, t + 1}}
#' represents a vector of observed variables
#' \eqn{X}, \eqn{M}, and \eqn{Y}
#' for individual \eqn{i} at time \eqn{t} and \eqn{t - 1},
#' \eqn{\boldsymbol{\varepsilon}_{i, t}}
#' a vector of normally distributed random noise
#' with mean vector of zero and covariance matrix
#' \eqn{\boldsymbol{\Psi}}
#' given by
#' \deqn{
#'   \boldsymbol{\Psi}
#'   =
#'   \left(
#'     \begin{array}{ccc}
#'       0.10 & 0 & 0 \\
#'       0 & 0.10 & 0 \\
#'       0 & 0 & 0.10 \\
#'     \end{array}
#'   \right), \quad \mathrm{and}
#' }
#' \eqn{\boldsymbol{\beta}} is a matrix of lagged parameters
#' given by
#' \deqn{
#'   \boldsymbol{\beta}
#'   =
#'   \left(
#'     \begin{array}{ccc}
#'       0.70 & 0 & 0 \\
#'       0.50 & 0.60 & 0 \\
#'       -0.10 & 0.40 & 0.50 \\
#'     \end{array}
#'   \right) .
#' }
#' The mean vector \eqn{\boldsymbol{\mu}_{0}}
#' and covariance matrix \eqn{\boldsymbol{\Sigma}_{0}}
#' of the initial condition are given by
#' \deqn{
#'   \boldsymbol{\mu}_{0}
#'   =
#'   \left(
#'     \begin{array}{c}
#'       0 \\
#'       0 \\
#'       0 \\
#'     \end{array}
#'   \right), \quad \mathrm{and}
#' }
#' \deqn{
#'   \boldsymbol{\Sigma}_{0}
#'   =
#'   \left(
#'     \begin{array}{ccc}
#'       1 & 0.20 & 0.20 \\
#'       0.20 & 1 & 0.20 \\
#'       0.20 & 0.20 & 1 \\
#'     \end{array}
#'   \right) .
#' }
#'
#' @format Dataframe with Five Columns:
#'   \describe{
#'     \item{id}{Individual ID.}
#'     \item{time}{Time variable.}
#'     \item{x}{X variable.}
#'     \item{m}{M variable.}
#'     \item{y}{Y variable.}
#'   }
#' @references
#'   Deboeck, P. R., & Preacher, K. J. (2015).
#'   No need to be discrete:
#'   A method for continuous time mediation analysis.
#'   Structural Equation Modeling: A Multidisciplinary Journal, 23 (1), 61–75.
#'   \doi{10.1080/10705511.2014.973960}
#' @keywords data
"deboeck2015"
