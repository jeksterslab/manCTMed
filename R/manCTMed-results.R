#' Simulation Results
#'
#' @author Ivan Jacob Agaloos Pesigan
#'
#' @docType data
#' @name results
#' @usage data(results)
#' @format A dataframe with 1440 rows and 21 columns:
#'
#' \describe{
#'   \item{taskid}{
#'     Simulation Task ID.
#'   }
#'   \item{replications}{
#'     Number of simulation replications.
#'   }
#'   \item{output_type}{
#'     Simulation output type.
#'   }
#'   \item{xmy}{
#'     If `TRUE`, the mediation model is \eqn{X \to M \to Y}.
#'     If `FALSE`, the mediation model is \eqn{Y \to M \to X}.
#'   }
#'   \item{std}{
#'     If `TRUE`, standardized total, direct, and indirect effects.
#'     If `FALSE`, unstandardized total, direct, and indirect effects.
#'   }
#'   \item{dynamics}{
#'     Dynamics.
#'     `0` for original drift matrix,
#'     `-1` for near-neutral dynamics, and
#'     `1` for stronger damping.
#'   }
#'   \item{n}{
#'     Sample size.
#'   }
#'   \item{method}{
#'     Method used to generate confidence intervals.
#'   }
#'   \item{effect}{
#'     Total, direct, or indirect effect.
#'   }
#'   \item{interval}{
#'     Time-interval.
#'   }
#'   \item{est}{
#'     Average parameter estimate.
#'   }
#'   \item{se}{
#'     Average standard error.
#'   }
#'   \item{z}{
#'     Average \eqn{z} statistic.
#'   }
#'   \item{p}{
#'     Average \eqn{p}-value.
#'   }
#'   \item{R}{
#'     Number of replications for the Monte Carlo method.
#'   }
#'   \item{2.5%}{
#'     Lower limit of the 95% confidence interval.
#'   }
#'   \item{97.5%}{
#'     Upper limit of the 95% confidence interval.
#'   }
#'   \item{parameter}{
#'     Population parameter.
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
#'   \item{sig}{
#'     If `TRUE`, \eqn{p < 0.05}.
#'   }
#' }
#'
#' @keywords data parameters
"results"
