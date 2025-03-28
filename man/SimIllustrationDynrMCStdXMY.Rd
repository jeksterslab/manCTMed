% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/manCTMed-illustration-sim-dynr-mc-std-x-m-y.R
\name{SimIllustrationDynrMCStdXMY}
\alias{SimIllustrationDynrMCStdXMY}
\title{Simulation Replication - Illustration (DynrMCStdXMY)}
\usage{
SimIllustrationDynrMCStdXMY(
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
Number of Monte Carlo replications.}
}
\value{
The output is saved as an external file in \code{output_folder}.
}
\description{
Simulation Replication - Illustration (DynrMCStdXMY)
}
\details{
This function is executed via the \code{IllustrationSim} function.
}
\author{
Ivan Jacob Agaloos Pesigan
}
\keyword{ci}
\keyword{illustration}
\keyword{manCTMed}
