% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/manCTMed-illustration-mc-phi-sigma.R
\name{IllustrationMCPhiSigma}
\alias{IllustrationMCPhiSigma}
\title{Generate a Sampling Distribution of Drift Matrices
and Process Noise Covariance Matrices (Illustration)}
\usage{
IllustrationMCPhiSigma(fit, R = 20000L, seed = NULL)
}
\arguments{
\item{fit}{R object.
Fitted CT-VAR model.}

\item{R}{Positive integer.
Number of Monte Carlo replications.}

\item{seed}{Integer.
Random seed.}
}
\description{
The function generates a sampling distribution of drift matrices
and process noise covariance matrices using te Monte Carlo method.
}
\examples{
\dontrun{
library(dynr)
sim <- IllustrationGenData(seed = 42)
data <- IllustrationPrepData(sim)
fit <- IllustrationFitDynr(data)
IllustrationMCPhiSigma(fit, seed = 42)
}
}
\seealso{
Other Model Fitting Functions: 
\code{\link{FitDynr}()},
\code{\link{FitMx}()},
\code{\link{IllustrationFitDynr}()},
\code{\link{IllustrationFitMx}()},
\code{\link{IllustrationPrepData}()},
\code{\link{PhiHat}()},
\code{\link{ThetaHat}()}
}
\concept{Model Fitting Functions}
\keyword{ci}
\keyword{illustration}
\keyword{manCTMed}
