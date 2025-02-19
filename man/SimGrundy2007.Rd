% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/manCTMed-sim-grundy2007.R
\name{SimGrundy2007}
\alias{SimGrundy2007}
\title{Simulation Replication - SimGrundy2007}
\usage{
SimGrundy2007(
  taskid,
  repid,
  output_folder,
  overwrite,
  integrity,
  delta_t,
  R,
  B,
  fit_dynr = FALSE,
  seed = NULL
)
}
\arguments{
\item{taskid}{Positive integer.
Task ID.}

\item{repid}{Positive integer.
Replication ID.}

\item{output_folder}{Character string.
Output folder.}

\item{overwrite}{Logical.
Overwrite existing output in \code{output_folder}.}

\item{integrity}{Logical.
If \code{integrity = TRUE},
check for the output file integrity when \code{overwrite = FALSE}.}

\item{delta_t}{Numeric vector.
Vector of time intervals.}

\item{R}{Positive integer.
Number of random drift matrices to generate.}

\item{B}{Positive integer.
Number of bootstrap samples.}

\item{fit_dynr}{Logical.
Generate data and fit the CT-VAR model only.}

\item{seed}{Integer.
Random seed.}
}
\value{
The output is saved as an external file in \code{output_folder}.
}
\description{
Simulation Replication - SimGrundy2007
}
\author{
Ivan Jacob Agaloos Pesigan
}
\keyword{manCTMed}
\keyword{simulation}
