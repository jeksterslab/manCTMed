% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/dataSets-deboeck2015phi.R
\docType{data}
\name{deboeck2015phi}
\alias{deboeck2015phi}
\title{Drift Matrix}
\format{
List with Two Elements:
\describe{
\item{dynr}{Results using the dynr package.}
\item{ctsem}{Results using the ctsem package.}
}
The \code{dynr} element is a list with the following elements:
\describe{
\item{phi}{The estimated drift matrix
\eqn{\boldsymbol{\Phi}}.}
\item{vcov}{The estimated sampling variance-covariance matrix of
\eqn{\mathrm{vec} \left( \boldsymbol{\Phi} \right)}.}
}
The \code{ctsem} element is a list with the following elements:
\describe{
\item{posterior}{Posterior distribution.}
\item{posterior_phi}{Posterior distribution of the drift matrix
\eqn{\boldsymbol{\Phi}}.}
\item{phi}{Posterior mean of the drift matrix
\eqn{\boldsymbol{\Phi}}.}
\item{vcov}{Posterior variance-covariance matrix of
\eqn{\mathrm{vec} \left( \boldsymbol{\Phi} \right)}.}
}
}
\usage{
deboeck2015phi
}
\description{
Parameter estimates and sampling variance-covariance matrix
of the continuous-time vector autoregressive model drift matrix
using the data set \code{deboeck2015}.
The model was fitted using the \code{dynr} and \code{ctsem} packages.
}
\references{
Deboeck, P. R., & Preacher, K. J. (2015).
No need to be discrete:
A method for continuous time mediation analysis.
Structural Equation Modeling: A Multidisciplinary Journal, 23 (1), 61–75.
\doi{10.1080/10705511.2014.973960}

Driver C. C., Voelkle M. C. (2018).
Hierarchical Bayesian continuous time dynamic modeling.
\emph{Psychological Methods}, \emph{23}(4), 774-799.
\doi{10.1037/met0000168}

Ou, L., Hunter, M. D., & Chow, S.-M. (2019).
What's for dynr: A package for linear and nonlinear dynamic modeling in R.
The R Journal, 11(1), 91.
\doi{10.32614/rj-2019-012}
}
\keyword{data}
