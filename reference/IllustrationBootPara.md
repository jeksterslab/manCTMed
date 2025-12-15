# Parametric Bootstrap (Illustration)

The function generates simulated datasets based on a fitted model and
refits the model to each generated dataset using the `dynr` package.

## Usage

``` r
IllustrationBootPara(
  fit,
  path,
  prefix,
  taskid,
  B = 1000L,
  ncores = NULL,
  seed = NULL
)
```

## Arguments

- fit:

  R object. Fitted CT-VAR model.

- path:

  Path to a directory to store bootstrap samples and estimates.

- prefix:

  Character string. Prefix used for the file names for the bootstrap
  samples and estimates.

- taskid:

  Positive integer. Task ID.

- B:

  Positive integer. Number of bootstrap samples.

- ncores:

  Positive integer. Number of cores to use.

- seed:

  Integer. Random seed.

## See also

Other Confidence Interval Functions:
[`BootPara()`](https://github.com/jeksterslab/manCTMed/reference/BootPara.md),
[`BootParaStdXMY()`](https://github.com/jeksterslab/manCTMed/reference/BootParaStdXMY.md),
[`BootParaStdXYM()`](https://github.com/jeksterslab/manCTMed/reference/BootParaStdXYM.md),
[`BootParaStdYMX()`](https://github.com/jeksterslab/manCTMed/reference/BootParaStdYMX.md),
[`BootParaXMY()`](https://github.com/jeksterslab/manCTMed/reference/BootParaXMY.md),
[`BootParaXYM()`](https://github.com/jeksterslab/manCTMed/reference/BootParaXYM.md),
[`BootParaYMX()`](https://github.com/jeksterslab/manCTMed/reference/BootParaYMX.md),
[`DeltaStdXMY()`](https://github.com/jeksterslab/manCTMed/reference/DeltaStdXMY.md),
[`DeltaStdXYM()`](https://github.com/jeksterslab/manCTMed/reference/DeltaStdXYM.md),
[`DeltaStdYMX()`](https://github.com/jeksterslab/manCTMed/reference/DeltaStdYMX.md),
[`DeltaXMY()`](https://github.com/jeksterslab/manCTMed/reference/DeltaXMY.md),
[`DeltaXYM()`](https://github.com/jeksterslab/manCTMed/reference/DeltaXYM.md),
[`DeltaYMX()`](https://github.com/jeksterslab/manCTMed/reference/DeltaYMX.md),
[`MCStdXMY()`](https://github.com/jeksterslab/manCTMed/reference/MCStdXMY.md),
[`MCStdXYM()`](https://github.com/jeksterslab/manCTMed/reference/MCStdXYM.md),
[`MCStdYMX()`](https://github.com/jeksterslab/manCTMed/reference/MCStdYMX.md),
[`MCXMY()`](https://github.com/jeksterslab/manCTMed/reference/MCXMY.md),
[`MCXYM()`](https://github.com/jeksterslab/manCTMed/reference/MCXYM.md),
[`MCYMX()`](https://github.com/jeksterslab/manCTMed/reference/MCYMX.md)

## Examples

``` r
if (FALSE) { # \dontrun{
library(dynr)
sim <- IllustrationGenData(seed = 42)
data <- IllustrationPrepData(sim)
fit <- IllustrationFitDynr(data)
summary(fit)
IllustrationBootPara(
  fit = fit,
  path = getwd(),
  prefix = "pb",
  taskid = 1,
  B = 1000L,
  seed = 42
)
} # }
```
