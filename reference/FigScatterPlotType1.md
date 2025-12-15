# Plot Type I Error

Type I error for the model \\Y \to M \to X\\.

## Usage

``` r
FigScatterPlotType1(results, delta_t = NULL, dynamics = 0, std = FALSE)
```

## Arguments

- results:

  Summary results data frame.

- delta_t:

  Vector of time-interval value. If `delta_t = NULL`, use all available
  time-intervals

- dynamics:

  Integer. `dynamics = 0` for original drift matrix, `dynamics = -1` for
  near-neutral dynamics, and `dynamics = 1` for stronger damping.

- std:

  Logical. If `std = TRUE`, standardized total, direct, and indirect
  effects. If `std = FALSE`, unstandardized total, direct, and indirect
  effects.

## See also

Other Figure Functions:
[`FigPlotEffects()`](https://github.com/jeksterslab/manCTMed/reference/FigPlotEffects.md),
[`FigScatterPlotCoverage()`](https://github.com/jeksterslab/manCTMed/reference/FigScatterPlotCoverage.md),
[`FigScatterPlotPower()`](https://github.com/jeksterslab/manCTMed/reference/FigScatterPlotPower.md),
[`FigScatterPlotSeBias()`](https://github.com/jeksterslab/manCTMed/reference/FigScatterPlotSeBias.md),
[`IllustrationFigPlotEffects()`](https://github.com/jeksterslab/manCTMed/reference/IllustrationFigPlotEffects.md),
[`IllustrationFigScatterPlotCoverage()`](https://github.com/jeksterslab/manCTMed/reference/IllustrationFigScatterPlotCoverage.md),
[`IllustrationFigScatterPlotPower()`](https://github.com/jeksterslab/manCTMed/reference/IllustrationFigScatterPlotPower.md),
[`IllustrationFigScatterPlotSeBias()`](https://github.com/jeksterslab/manCTMed/reference/IllustrationFigScatterPlotSeBias.md)

## Author

Ivan Jacob Agaloos Pesigan

## Examples

``` r
data(results, package = "manCTMed")
FigScatterPlotType1(results)

FigScatterPlotType1(results, delta_t = 1:14)

FigScatterPlotType1(results, delta_t = 15:30)

```
