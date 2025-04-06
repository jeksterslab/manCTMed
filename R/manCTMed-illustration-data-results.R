#' Illustration Small Scale Simulation Results
#'
#' @author Ivan Jacob Agaloos Pesigan
#'
#' @docType data
#' @name illustration_results
#' @usage data(illustration_results)
#' @format A with 22 columns:
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
#'   \item{parameter}{
#'     Population parameter.
#'   }
#'   \item{method}{
#'     Method used to generate confidence intervals.
#'   }
#'   \item{xmy}{
#'     Logical.
#'     `TRUE` for x to m to y path.
#'   }
#'   \item{std}{
#'     Logical.
#'     `TRUE` for standardized.
#'     `FALSE` for unstandardized.
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
#'     Number of Monte Carlo or bootstrap replications.
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
#'     included zero.
#'   }
#'   \item{theta_hit}{
#'     Proportion of replications
#'     where the confidence intervals
#'     included the population parameter.
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
#' @keywords data illustration
"illustration_results"
