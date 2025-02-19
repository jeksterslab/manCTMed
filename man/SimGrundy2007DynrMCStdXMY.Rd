% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/manCTMed-sim-grundy2007-dynr-mc-std-x-m-y.R
\name{SimGrundy2007DynrMCStdXMY}
\alias{SimGrundy2007DynrMCStdXMY}
\title{Simulation Replication - Grundy2007DynrMCStdXMY}
\usage{
SimGrundy2007DynrMCStdXMY(
  taskid,
  repid,
  output_folder,
  seed,
  suffix,
  overwrite,
  integrity,
  delta_t,
  R
)
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

\item{delta_t}{Numeric vector.
Vector of time intervals.}

\item{R}{Positive integer.
Number of random drift matrices to generate.}
}
\value{
The output is saved as an external file in \code{output_folder}.
}
\description{
Simulation Replication - Grundy2007DynrMCStdXMY
}
\details{
This function is executed via the \code{SimGrundy2007} function.
}
\author{
Ivan Jacob Agaloos Pesigan
}
\keyword{fit}
\keyword{manCTMed}
\keyword{simulation}
