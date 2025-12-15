# Simulate Data (Illustration)

The function simulates data using the
[`simStateSpace::SimSSMOUFixed()`](https://github.com/jeksterslab/simStateSpace/reference/SimSSMOUFixed.html)
function.

## Usage

``` r
IllustrationGenData(seed = NULL, n = 133, m = 101, delta_t_gen = 0.1)
```

## Arguments

- seed:

  Integer. Random seed.

- n:

  Positive integer. Sample size.

- m:

  Positive integer. Measurement occasions.

- delta_t_gen:

  Numeric. Time interval used to generate data.

## See also

Other Data Generation Functions:
[`GenData()`](https://github.com/jeksterslab/manCTMed/reference/GenData.md),
[`RandomMeasurement()`](https://github.com/jeksterslab/manCTMed/reference/RandomMeasurement.md)

## Examples

``` r
if (FALSE) { # \dontrun{
sim <- IllustrationGenData(seed = 42)
plot(sim)
} # }
```
