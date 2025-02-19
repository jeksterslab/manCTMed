% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/manCTMed-fit-dynr.R
\name{FitDynr}
\alias{FitDynr}
\title{Fit the Model using the dynr Package}
\usage{
FitDynr(data, taskid)
}
\arguments{
\item{data}{R object.
Output of the \code{\link[=RandomMeasurement]{RandomMeasurement()}} function.}

\item{taskid}{Positive integer.
Task ID.}
}
\description{
The function fits the model using the \link{dynr} package.
}
\examples{
\dontrun{
set.seed(42)
library(dynr)
sim <- GenData(taskid = 1)
data <- RandomMeasurement(sim)
FitDynr(data, taskid = 1)
}
}
\seealso{
Other Model Fitting Functions: 
\code{\link{FitMx}()},
\code{\link{Grundy2007FitDynr}()},
\code{\link{PhiHat}()},
\code{\link{ThetaHat}()}
}
\concept{Model Fitting Functions}
\keyword{fit}
\keyword{manCTMed}
