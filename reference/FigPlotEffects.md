# Plot Total, Direct, and Indirect Effects

Effects for the model \\X \to M \to Y\\.

## Usage

``` r
FigPlotEffects(dynamics = 0, std = FALSE, max_delta_t = 30, xmy = TRUE)
```

## Arguments

- dynamics:

  Integer. `dynamics = 0` for original drift matrix, `dynamics = -1` for
  near-neutral dynamics, and `dynamics = 1` for stronger damping.

- std:

  Logical. If `std = TRUE`, standardized total, direct, and indirect
  effects. If `std = FALSE`, unstandardized total, direct, and indirect
  effects.

- max_delta_t:

  Numeric. Maximum time interval.

- xmy:

  Logical. If `xmy = TRUE`, plot the effects for the `x` -\> m -\>
  y`mediation model. If`xmy = FALSE`, plot the effects for the `y -\> m
  -\> x\` mediation model.

## See also

Other Figure Functions:
[`FigScatterPlotCoverage()`](https://github.com/jeksterslab/manCTMed/reference/FigScatterPlotCoverage.md),
[`FigScatterPlotPower()`](https://github.com/jeksterslab/manCTMed/reference/FigScatterPlotPower.md),
[`FigScatterPlotSeBias()`](https://github.com/jeksterslab/manCTMed/reference/FigScatterPlotSeBias.md),
[`FigScatterPlotType1()`](https://github.com/jeksterslab/manCTMed/reference/FigScatterPlotType1.md),
[`IllustrationFigPlotEffects()`](https://github.com/jeksterslab/manCTMed/reference/IllustrationFigPlotEffects.md),
[`IllustrationFigScatterPlotCoverage()`](https://github.com/jeksterslab/manCTMed/reference/IllustrationFigScatterPlotCoverage.md),
[`IllustrationFigScatterPlotPower()`](https://github.com/jeksterslab/manCTMed/reference/IllustrationFigScatterPlotPower.md),
[`IllustrationFigScatterPlotSeBias()`](https://github.com/jeksterslab/manCTMed/reference/IllustrationFigScatterPlotSeBias.md)

## Author

Ivan Jacob Agaloos Pesigan

## Examples

``` r
FigPlotEffects()
#> 
#> phi:
#>        x      m      y
#> x -0.357  0.000  0.000
#> m  0.771 -0.511  0.000
#> y -0.450  0.729 -0.693

```
