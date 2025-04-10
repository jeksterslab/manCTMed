% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/manCTMed-sim-fit-mx.R
\name{SimFitMx}
\alias{SimFitMx}
\title{Simulation Replication - FitMx}
\usage{
SimFitMx(taskid, repid, output_folder, seed, suffix, overwrite, integrity)
}
\arguments{
\item{taskid}{Positive integer.
Task ID.}

\item{repid}{Positive integer.
Replication ID.}

\item{output_folder}{Character string.
Output folder.}

\item{seed}{Integer.
Random seed.}

\item{suffix}{Character string.
Output of \code{manCTMed:::.SimSuffix()}.}

\item{overwrite}{Logical.
Overwrite existing output in \code{output_folder}.}

\item{integrity}{Logical.
If \code{integrity = TRUE},
check for the output file integrity when \code{overwrite = FALSE}.}
}
\value{
The output is saved as an external file in \code{output_folder}.
}
\description{
Simulation Replication - FitMx
}
\details{
This function is executed via the \code{Sim} function.
}
\author{
Ivan Jacob Agaloos Pesigan
}
\keyword{fit}
\keyword{manCTMed}
\keyword{simulation}
