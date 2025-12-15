# Scatter Plots - Weak Coupling

``` r

library(manCTMed)
```

## Population Total, Direct, and Indirect Effects

Total, direct, and indirect effects for the drift matrix

``` math
\begin{equation}
    \left(
    \begin{array}{ccc}
         −0.050 & 0 & 0 \\
         −0.020 & −0.050 & 0 \\
         0.030 & −0.010 & −0.050 \\
    \end{array}
    \right)
\end{equation}
```

``` r

FigPlotEffects(dynamics = -1)
#> 
#> phi:
#>       x     m     y
#> x -0.05  0.00  0.00
#> m -0.02 -0.05  0.00
#> y  0.03 -0.01 -0.05
```

![](fig-vignettes-scatter-plots-neg-effects-1.png)

Standardized total, direct, and indirect effects for the drift matrix
``` math
\begin{equation}
    \left(
    \begin{array}{ccc}
         −0.050 & 0 & 0 \\
         −0.020 & −0.050 & 0 \\
         0.030 & −0.010 & −0.050 \\
    \end{array}
    \right)
\end{equation}
```
and process noise covariance matrix
``` math
\begin{equation}
    \left(
    \begin{array}{ccc}
         0.0343 & 0.0398 & -0.0035 \\
         0.0398 & 0.0698 & 0.0219 \\
         -0.0035 & 0.0219 & 0.0330 \\
    \end{array}
    \right)
\end{equation}
```

``` r

FigPlotEffects(dynamics = -1, std = TRUE)
#> 
#> phi:
#>       x     m     y
#> x -0.05  0.00  0.00
#> m -0.02 -0.05  0.00
#> y  0.03 -0.01 -0.05
#> 
#> sigma:
#>             [,1]       [,2]        [,3]
#> [1,]  0.24455556 0.02201587 -0.05004762
#> [2,]  0.02201587 0.07067800  0.01539456
#> [3,] -0.05004762 0.01539456  0.07553061
```

![](fig-vignettes-scatter-plots-neg-effects-std-1.png)

## Evaluation of Confidence Intervals

Presented below are scatter plots of coverage probabilities and power
for the $`\eta_X \to \eta_M \ to \eta_Y`$ model and type I error rates
for the $`\eta_Y \to \eta_M \to \eta_X`$ model.

``` r

data(results, package = "manCTMed")
```

### Coverage Probabilities

#### Time Intervals 1 to 25

![](fig-vignettes-scatter-plots-neg-coverage-1-25-1.png)

#### Time Intervals 1 to 4

![](fig-vignettes-scatter-plots-neg-coverage-1-4-1.png)

#### Time Intervals 5 to 25

![](fig-vignettes-scatter-plots-neg-coverage-5-25-1.png)

#### Time Intervals 25 to 30

![](fig-vignettes-scatter-plots-neg-coverage-25-30-1.png)

### Statistical Power

![](fig-vignettes-scatter-plots-neg-power-1.png)

### Type I Error Rate

![](fig-vignettes-scatter-plots-neg-type1-1.png)

### Coverage Probabilities (Standardized)

#### Time Intervals 1 to 25

![](fig-vignettes-scatter-plots-neg-coverage-std-1-25-1.png)

#### Time Intervals 1 to 4

![](fig-vignettes-scatter-plots-neg-coverage-std-1-4-1.png)

#### Time Intervals 5 to 25

![](fig-vignettes-scatter-plots-neg-coverage-std-5-25-1.png)

#### Time Intervals 25 to 30

![](fig-vignettes-scatter-plots-neg-coverage-std-25-30-1.png)

### Statistical Power (Standardized)

![](fig-vignettes-scatter-plots-neg-power-std-1.png)

### Type I Error Rate (Standardized)

![](fig-vignettes-scatter-plots-neg-type1-std-1.png)
