% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/manCTMed-data-results.R
\docType{data}
\name{results}
\alias{results}
\title{Simulation Results}
\format{
A dataframe with 24 columns:

\describe{
\item{taskid}{
Task ID.
}
\item{replications}{
Number of replications.
}
\item{effect}{
Total, direct, or indirect effect.
}
\item{interval}{
Time interval.
}
\item{dynamics}{
Dynamics.
\code{0} for original drift matrix,
\code{-1} for near-neutral dynamics, and
\code{1} for stronger damping.
}
\item{parameter}{
Population parameter.
}
\item{method}{
Method used to generate confidence intervals.
}
\item{xmy}{
If \code{TRUE}, the mediation model is \eqn{X \to M \to Y}.
If \code{FALSE}, the mediation model is \eqn{Y \to M \to X}.
}
\item{std}{
If \code{TRUE}, standardized total, direct, and indirect effects.
If \code{FALSE}, unstandardized total, direct, and indirect effects.
}
\item{n}{
Sample size.
}
\item{est}{
Mean parameter estimate.
}
\item{se}{
Mean standard error.
}
\item{z}{
Mean \eqn{z} statistic.
}
\item{p}{
Mean \eqn{p}-value.
}
\item{R}{
Number of Monte Carlo replications.
}
\item{ll}{
Mean lower limit of the 95\% confidence interval.
}
\item{ul}{
Mean upper limit of the 95\% confidence interval.
}
\item{sig}{
Proportion of statistically significant results.
}
\item{zero_hit}{
Proportion of replications
where the confidence intervals
contained zero.
}
\item{theta_hit}{
Proportion of replications
where the confidence intervals
contained the population parameter.
}
\item{sq_error}{
Mean squared error.
}
\item{se_bias}{
Bias in standard error estimate.
}
\item{coverage}{
Coverage probability.
}
\item{power}{
Statistical power.
}
}
}
\usage{
data(results)
}
\description{
Simulation Results
}
\author{
Ivan Jacob Agaloos Pesigan
}
\keyword{data}
\keyword{parameters}
