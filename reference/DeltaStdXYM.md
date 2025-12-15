# Delta Method Confidence Intervals for X-Y-M (Standardized)

The function generates delta method confidence intervals for the
mediation model \\X \to Y \to M\\ (Standardized).

## Usage

``` r
DeltaStdXYM(theta_hat, delta_t = 1:30)
```

## Arguments

- theta_hat:

  R object. Output of the
  [`ThetaHat()`](https://github.com/jeksterslab/manCTMed/reference/ThetaHat.md)
  function.

- delta_t:

  Numeric vector. Vector of time intervals.

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
theta_hat <- ThetaHat(fit)
ci <- DeltaStdXYM(theta_hat)
plot(ci)
} # }
```
