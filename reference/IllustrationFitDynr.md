# Fit the Model using the dynr Package (Illustration)

The function fits the model using the
[dynr::dynr](https://rdrr.io/pkg/dynr/man/dynr-package.html) package.

## Usage

``` r
IllustrationFitDynr(data)
```

## Arguments

- data:

  R object. Output of the
  [`IllustrationPrepData()`](https://github.com/jeksterslab/manCTMed/reference/IllustrationPrepData.md)
  function.

## See also

Other Model Fitting Functions:
[`FitDynr()`](https://github.com/jeksterslab/manCTMed/reference/FitDynr.md),
[`FitMx()`](https://github.com/jeksterslab/manCTMed/reference/FitMx.md),
[`IllustrationFitMx()`](https://github.com/jeksterslab/manCTMed/reference/IllustrationFitMx.md),
[`IllustrationMCPhiSigma()`](https://github.com/jeksterslab/manCTMed/reference/IllustrationMCPhiSigma.md),
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
summary(fit)
} # }
```
