# Fit the Model using the OpenMx Package

The function fits the model using the
[OpenMx::OpenMx](https://rdrr.io/pkg/OpenMx/man/OpenMx.html) package.

## Usage

``` r
FitMx(data, taskid)
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
[`FitDynr()`](https://github.com/jeksterslab/manCTMed/reference/FitDynr.md),
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
library(OpenMx)
sim <- GenData(taskid = 1)
data <- RandomMeasurement(sim)
fit <- FitMx(data, taskid = 1)
summary(fit)
} # }
```
