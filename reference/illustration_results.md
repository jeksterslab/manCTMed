# Illustration Small Scale Simulation Results

Illustration Small Scale Simulation Results

## Usage

``` r
data(illustration_results)
```

## Format

A with 22 columns:

- taskid:

  Task ID.

- replications:

  Number of replications.

- effect:

  Total, direct, or indirect effect.

- interval:

  Time interval.

- parameter:

  Population parameter.

- method:

  Method used to generate confidence intervals.

- xmy:

  Logical. `TRUE` for x to m to y path.

- std:

  Logical. `TRUE` for standardized. `FALSE` for unstandardized.

- est:

  Mean parameter estimate.

- se:

  Mean standard error.

- z:

  Mean \\z\\ statistic.

- p:

  Mean \\p\\-value.

- R:

  Number of Monte Carlo or bootstrap replications.

- ll:

  Mean lower limit of the 95% confidence interval.

- ul:

  Mean upper limit of the 95% confidence interval.

- sig:

  Proportion of statistically significant results.

- zero_hit:

  Proportion of replications where the confidence intervals included
  zero.

- theta_hit:

  Proportion of replications where the confidence intervals included the
  population parameter.

- sq_error:

  Mean squared error.

- se_bias:

  Bias in standard error estimate.

- coverage:

  Coverage probability.

- power:

  Statistical power.

## Author

Ivan Jacob Agaloos Pesigan
