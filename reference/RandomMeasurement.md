# Simulate Random Measurement

The function randomly selects 100 observations from the generated data
and replaces the unselected observations with `NA`.

## Usage

``` r
RandomMeasurement(sim)
```

## Arguments

- sim:

  R object. Output of the
  [`GenData()`](https://github.com/jeksterslab/manCTMed/reference/GenData.md)
  function.

## See also

Other Data Generation Functions:
[`GenData()`](https://github.com/jeksterslab/manCTMed/reference/GenData.md),
[`IllustrationGenData()`](https://github.com/jeksterslab/manCTMed/reference/IllustrationGenData.md)

## Examples

``` r
if (FALSE) { # \dontrun{
set.seed(42)
sim <- GenData(taskid = 1)
RandomMeasurement(sim)
} # }
```
