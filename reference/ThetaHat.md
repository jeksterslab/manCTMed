# Estimated Drift Matrix and Process Noise

The function extracts the estimated drift matrix and process noise from
the fitted model.

## Usage

``` r
ThetaHat(fit)
```

## Arguments

- fit:

  R object. Output of the
  [`FitDynr()`](https://github.com/jeksterslab/manCTMed/reference/FitDynr.md),
  [`FitMx()`](https://github.com/jeksterslab/manCTMed/reference/FitMx.md),
  [`IllustrationFitDynr()`](https://github.com/jeksterslab/manCTMed/reference/IllustrationFitDynr.md),
  or
  [`IllustrationFitMx()`](https://github.com/jeksterslab/manCTMed/reference/IllustrationFitMx.md),
  functions.

## See also

Other Model Fitting Functions:
[`FitDynr()`](https://github.com/jeksterslab/manCTMed/reference/FitDynr.md),
[`FitMx()`](https://github.com/jeksterslab/manCTMed/reference/FitMx.md),
[`IllustrationFitDynr()`](https://github.com/jeksterslab/manCTMed/reference/IllustrationFitDynr.md),
[`IllustrationFitMx()`](https://github.com/jeksterslab/manCTMed/reference/IllustrationFitMx.md),
[`IllustrationMCPhiSigma()`](https://github.com/jeksterslab/manCTMed/reference/IllustrationMCPhiSigma.md),
[`IllustrationPrepData()`](https://github.com/jeksterslab/manCTMed/reference/IllustrationPrepData.md),
[`PhiHat()`](https://github.com/jeksterslab/manCTMed/reference/PhiHat.md)

## Examples

``` r
if (FALSE) { # \dontrun{
set.seed(42)
library(dynr)
sim <- GenData(n = 50)
data <- RandomMeasurement(sim)
fit <- FitDynr(data)
ThetaHat(fit)
} # }
```
