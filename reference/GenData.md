# Simulate Data

The function simulates data using the
[`simStateSpace::SimSSMOUFixed()`](https://github.com/jeksterslab/simStateSpace/reference/SimSSMOUFixed.html)
function.

## Usage

``` r
GenData(taskid)
```

## Arguments

- taskid:

  Positive integer. Task ID.

## See also

Other Data Generation Functions:
[`IllustrationGenData()`](https://github.com/jeksterslab/manCTMed/reference/IllustrationGenData.md),
[`RandomMeasurement()`](https://github.com/jeksterslab/manCTMed/reference/RandomMeasurement.md)

## Examples

``` r
if (FALSE) { # \dontrun{
set.seed(42)
sim <- GenData(taskid = 1)
plot(sim)
} # }
```
