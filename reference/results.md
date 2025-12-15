# Simulation Results

Simulation Results

## Usage

``` r
data(results)
```

## Format

A dataframe with 24 columns:

- taskid:

  Task ID.

- replications:

  Number of replications.

- effect:

  Total, direct, or indirect effect.

- interval:

  Time interval.

- dynamics:

  Dynamics. `0` for original drift matrix, `-1` for near-neutral
  dynamics, and `1` for stronger damping.

- parameter:

  Population parameter.

- method:

  Method used to generate confidence intervals.

- xmy:

  If `TRUE`, the mediation model is \\X \to M \to Y\\. If `FALSE`, the
  mediation model is \\Y \to M \to X\\.

- std:

  If `TRUE`, standardized total, direct, and indirect effects. If
  `FALSE`, unstandardized total, direct, and indirect effects.

- n:

  Sample size.

- est:

  Mean parameter estimate.

- se:

  Mean standard error.

- z:

  Mean \\z\\ statistic.

- p:

  Mean \\p\\-value.

- R:

  Number of Monte Carlo replications.

- ll:

  Mean lower limit of the 95% confidence interval.

- ul:

  Mean upper limit of the 95% confidence interval.

- sig:

  Proportion of statistically significant results.

- zero_hit:

  Proportion of replications where the confidence intervals contained
  zero.

- theta_hit:

  Proportion of replications where the confidence intervals contained
  the population parameter.

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
