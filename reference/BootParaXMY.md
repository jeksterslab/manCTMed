# Parametric Bootstrap Confidence Intervals for X-M-Y

The function generates parametric bootstrap method confidence intervals
for the mediation model \\X \to M \to Y\\.

## Usage

``` r
BootParaXMY(boot, phi_hat, delta_t = 1:30, ncores = NULL)
```

## Arguments

- boot:

  R object. Output of the
  [`BootPara()`](https://github.com/jeksterslab/manCTMed/reference/BootPara.md)
  function.

- phi_hat:

  R object. Output of the
  [`PhiHat()`](https://github.com/jeksterslab/manCTMed/reference/PhiHat.md)
  function.

- delta_t:

  Numeric vector. Vector of time intervals.

- ncores:

  Positive integer. Number of cores to use.

## See also

Other Confidence Interval Functions:
[`BootPara()`](https://github.com/jeksterslab/manCTMed/reference/BootPara.md),
[`BootParaStdXMY()`](https://github.com/jeksterslab/manCTMed/reference/BootParaStdXMY.md),
[`BootParaStdXYM()`](https://github.com/jeksterslab/manCTMed/reference/BootParaStdXYM.md),
[`BootParaStdYMX()`](https://github.com/jeksterslab/manCTMed/reference/BootParaStdYMX.md),
[`BootParaXYM()`](https://github.com/jeksterslab/manCTMed/reference/BootParaXYM.md),
[`BootParaYMX()`](https://github.com/jeksterslab/manCTMed/reference/BootParaYMX.md),
[`DeltaStdXMY()`](https://github.com/jeksterslab/manCTMed/reference/DeltaStdXMY.md),
[`DeltaStdXYM()`](https://github.com/jeksterslab/manCTMed/reference/DeltaStdXYM.md),
[`DeltaStdYMX()`](https://github.com/jeksterslab/manCTMed/reference/DeltaStdYMX.md),
[`DeltaXMY()`](https://github.com/jeksterslab/manCTMed/reference/DeltaXMY.md),
[`DeltaXYM()`](https://github.com/jeksterslab/manCTMed/reference/DeltaXYM.md),
[`DeltaYMX()`](https://github.com/jeksterslab/manCTMed/reference/DeltaYMX.md),
[`IllustrationBootPara()`](https://github.com/jeksterslab/manCTMed/reference/IllustrationBootPara.md),
[`MCStdXMY()`](https://github.com/jeksterslab/manCTMed/reference/MCStdXMY.md),
[`MCStdXYM()`](https://github.com/jeksterslab/manCTMed/reference/MCStdXYM.md),
[`MCStdYMX()`](https://github.com/jeksterslab/manCTMed/reference/MCStdYMX.md),
[`MCXMY()`](https://github.com/jeksterslab/manCTMed/reference/MCXMY.md),
[`MCXYM()`](https://github.com/jeksterslab/manCTMed/reference/MCXYM.md),
[`MCYMX()`](https://github.com/jeksterslab/manCTMed/reference/MCYMX.md)

## Examples

``` r
if (FALSE) { # \dontrun{
set.seed(42)
library(dynr)
sim <- GenData(taskid = 1)
data <- RandomMeasurement(sim)
fit <- FitDynr(data, taskid = 1)
boot <- BootPara(
  fit = fit,
  path = getwd(),
  prefix = "pb",
  taskid = 1,
  B = 1000L
)
phi_hat <- PhiHat(fit)
ci <- BootParaXMY(boot = boot, phi_hat = phi_hat)
plot(ci)
plot(ci, type = "bc")
} # }
```
