# Plot Total, Direct, and Indirect Effects (Illustration)

Effects for the model \\X \to M \to Y\\.

## Usage

``` r
IllustrationFigPlotEffects(std = FALSE, max_delta_t = 30)
```

## Arguments

- std:

  Logical. If `std = TRUE`, standardized total, direct, and indirect
  effects. If `std = FALSE`, unstandardized total, direct, and indirect
  effects.

- max_delta_t:

  Numeric. Maximum time interval.

## See also

Other Figure Functions:
[`FigPlotEffects()`](https://github.com/jeksterslab/manCTMed/reference/FigPlotEffects.md),
[`FigScatterPlotCoverage()`](https://github.com/jeksterslab/manCTMed/reference/FigScatterPlotCoverage.md),
[`FigScatterPlotPower()`](https://github.com/jeksterslab/manCTMed/reference/FigScatterPlotPower.md),
[`FigScatterPlotSeBias()`](https://github.com/jeksterslab/manCTMed/reference/FigScatterPlotSeBias.md),
[`FigScatterPlotType1()`](https://github.com/jeksterslab/manCTMed/reference/FigScatterPlotType1.md),
[`IllustrationFigScatterPlotCoverage()`](https://github.com/jeksterslab/manCTMed/reference/IllustrationFigScatterPlotCoverage.md),
[`IllustrationFigScatterPlotPower()`](https://github.com/jeksterslab/manCTMed/reference/IllustrationFigScatterPlotPower.md),
[`IllustrationFigScatterPlotSeBias()`](https://github.com/jeksterslab/manCTMed/reference/IllustrationFigScatterPlotSeBias.md)

## Author

Ivan Jacob Agaloos Pesigan

## Examples

``` r
IllustrationFigPlotEffects(std = FALSE)
#> 
#> phi:
#>        x      m      y
#> x -0.138  0.000  0.000
#> m -0.124 -0.865  0.434
#> y -0.057  0.115 -0.693

IllustrationFigPlotEffects(std = TRUE)
#> 
#> phi:
#>        x      m      y
#> x -0.138  0.000  0.000
#> m -0.124 -0.865  0.434
#> y -0.057  0.115 -0.693
#> 
#> sigma:
#>      [,1] [,2] [,3]
#> [1,]  0.1  0.0  0.0
#> [2,]  0.0  0.1  0.0
#> [3,]  0.0  0.0  0.1

```
