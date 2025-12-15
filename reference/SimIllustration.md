# Simulation Replication (Illustration)

Simulation Replication (Illustration)

## Usage

``` r
SimIllustration(
  taskid,
  repid,
  output_folder,
  overwrite,
  integrity,
  seed,
  ci,
  pb,
  delta_t,
  R,
  B
)
```

## Arguments

- taskid:

  Positive integer. Task ID.

- repid:

  Positive integer. Replication ID.

- output_folder:

  Character string. Output folder.

- overwrite:

  Logical. Overwrite existing output in `output_folder`.

- integrity:

  Logical. If `integrity = TRUE`, check for the output file integrity
  when `overwrite = FALSE`.

- seed:

  Integer. Random seed.

- ci:

  Logical. Run simulations for confidence intervals.

- pb:

  Logical. Run simulations for parametric bootstrap confidence
  intervals.

- delta_t:

  Numeric vector. Vector of time intervals.

- R:

  Positive integer. Number of Monte Carlo replications.

- B:

  Positive integer. Number of bootstrap samples.

## Value

The output is saved as an external file in `output_folder`.

## Author

Ivan Jacob Agaloos Pesigan
