# Generate a Sampling Distribution of Drift Matrices and Process Noise Covariance Matrices (Illustration)

The function generates a sampling distribution of drift matrices and
process noise covariance matrices using te Monte Carlo method.

## Usage

``` r
IllustrationMCPhiSigma(fit, R = 20000L, seed = NULL)
```

## Arguments

- fit:

  R object. Fitted CT-VAR model.

- R:

  Positive integer. Number of Monte Carlo replications.

- seed:

  Integer. Random seed.

## See also

Other Model Fitting Functions:
[`FitDynr()`](https://github.com/jeksterslab/manCTMed/reference/FitDynr.md),
[`FitMx()`](https://github.com/jeksterslab/manCTMed/reference/FitMx.md),
[`IllustrationFitDynr()`](https://github.com/jeksterslab/manCTMed/reference/IllustrationFitDynr.md),
[`IllustrationFitMx()`](https://github.com/jeksterslab/manCTMed/reference/IllustrationFitMx.md),
[`IllustrationPrepData()`](https://github.com/jeksterslab/manCTMed/reference/IllustrationPrepData.md),
[`PhiHat()`](https://github.com/jeksterslab/manCTMed/reference/PhiHat.md),
[`ThetaHat()`](https://github.com/jeksterslab/manCTMed/reference/ThetaHat.md)

## Examples

``` r
if (FALSE) { # \dontrun{
library(dynr)
sim <- IllustrationGenData(seed = 42)
data <- IllustrationPrepData(sim)
fit <- IllustrationFitDynr(data)
IllustrationMCPhiSigma(fit, seed = 42)
} # }
```
