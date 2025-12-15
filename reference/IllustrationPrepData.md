# Prepare Data Before Model Fitting (Illustration)

The function converts the output of
[`IllustrationGenData()`](https://github.com/jeksterslab/manCTMed/reference/IllustrationGenData.md)
into a data frame.

## Usage

``` r
IllustrationPrepData(sim)
```

## Arguments

- sim:

  R object. Output of the
  [`IllustrationGenData()`](https://github.com/jeksterslab/manCTMed/reference/IllustrationGenData.md)
  function.

## See also

Other Model Fitting Functions:
[`FitDynr()`](https://github.com/jeksterslab/manCTMed/reference/FitDynr.md),
[`FitMx()`](https://github.com/jeksterslab/manCTMed/reference/FitMx.md),
[`IllustrationFitDynr()`](https://github.com/jeksterslab/manCTMed/reference/IllustrationFitDynr.md),
[`IllustrationFitMx()`](https://github.com/jeksterslab/manCTMed/reference/IllustrationFitMx.md),
[`IllustrationMCPhiSigma()`](https://github.com/jeksterslab/manCTMed/reference/IllustrationMCPhiSigma.md),
[`PhiHat()`](https://github.com/jeksterslab/manCTMed/reference/PhiHat.md),
[`ThetaHat()`](https://github.com/jeksterslab/manCTMed/reference/ThetaHat.md)

## Examples

``` r
if (FALSE) { # \dontrun{
sim <- IllustrationGenData(seed = 42)
data <- IllustrationPrepData(sim)
head(data)
dim(data)
} # }
```
