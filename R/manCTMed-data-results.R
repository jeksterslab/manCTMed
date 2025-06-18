#' Simulation Results
#'
#' @author Ivan Jacob Agaloos Pesigan
#'
#' @docType data
#' @name results
#' @usage data(results)
#' @format A dataframe with 24 columns:
#'
#' \describe{
#'   \item{taskid}{
#'     Task ID.
#'   }
#'   \item{replications}{
#'     Number of replications.
#'   }
#'   \item{effect}{
#'     Total, direct, or indirect effect.
#'   }
#'   \item{interval}{
#'     Time interval.
#'   }
#'   \item{dynamics}{
#'     Dynamics.
#'     `0` for original drift matrix,
#'     `-1` for near-neutral dynamics, and
#'     `1` for stronger damping.
#'   }
#'   \item{parameter}{
#'     Population parameter.
#'   }
#'   \item{method}{
#'     Method used to generate confidence intervals.
#'   }
#'   \item{xmy}{
#'     If `TRUE`, the mediation model is \eqn{X \to M \to Y}.
#'     If `FALSE`, the mediation model is \eqn{Y \to M \to X}.
#'   }
#'   \item{std}{
#'     If `TRUE`, standardized total, direct, and indirect effects.
#'     If `FALSE`, unstandardized total, direct, and indirect effects.
#'   }
#'   \item{n}{
#'     Sample size.
#'   }
#'   \item{est}{
#'     Mean parameter estimate.
#'   }
#'   \item{se}{
#'     Mean standard error.
#'   }
#'   \item{z}{
#'     Mean \eqn{z} statistic.
#'   }
#'   \item{p}{
#'     Mean \eqn{p}-value.
#'   }
#'   \item{R}{
#'     Number of Monte Carlo replications.
#'   }
#'   \item{ll}{
#'     Mean lower limit of the 95% confidence interval.
#'   }
#'   \item{ul}{
#'     Mean upper limit of the 95% confidence interval.
#'   }
#'   \item{sig}{
#'     Proportion of statistically significant results.
#'   }
#'   \item{zero_hit}{
#'     Proportion of replications
#'     where the confidence intervals
#'     contained zero.
#'   }
#'   \item{theta_hit}{
#'     Proportion of replications
#'     where the confidence intervals
#'     contained the population parameter.
#'   }
#'   \item{sq_error}{
#'     Mean squared error.
#'   }
#'   \item{se_bias}{
#'     Bias in standard error estimate.
#'   }
#'   \item{coverage}{
#'     Coverage probability.
#'   }
#'   \item{power}{
#'     Statistical power.
#'   }
#' }
#'
#' @keywords data parameters
"results"
