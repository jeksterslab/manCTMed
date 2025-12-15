# Fit the Model using the dynr Package

The function fits the model using the
[dynr::dynr](https://rdrr.io/pkg/dynr/man/dynr-package.html) package.

## Usage

``` r
FitDynr(data, taskid)
```

## Arguments

- data:

  R object. Output of the
  [`RandomMeasurement()`](https://github.com/jeksterslab/manCTMed/reference/RandomMeasurement.md)
  function.

- taskid:

  Positive integer. Task ID.

## See also

Other Model Fitting Functions:
[`FitMx()`](https://github.com/jeksterslab/manCTMed/reference/FitMx.md),
[`IllustrationFitDynr()`](https://github.com/jeksterslab/manCTMed/reference/IllustrationFitDynr.md),
[`IllustrationFitMx()`](https://github.com/jeksterslab/manCTMed/reference/IllustrationFitMx.md),
[`IllustrationMCPhiSigma()`](https://github.com/jeksterslab/manCTMed/reference/IllustrationMCPhiSigma.md),
[`IllustrationPrepData()`](https://github.com/jeksterslab/manCTMed/reference/IllustrationPrepData.md),
[`PhiHat()`](https://github.com/jeksterslab/manCTMed/reference/PhiHat.md),
[`ThetaHat()`](https://github.com/jeksterslab/manCTMed/reference/ThetaHat.md)

## Examples

``` r
if (FALSE) { # \dontrun{
set.seed(42)
library(dynr)
sim <- GenData(taskid = 1)
data <- RandomMeasurement(sim)
fit <- FitDynr(data, taskid = 1)
summary(fit)
} # }
```
