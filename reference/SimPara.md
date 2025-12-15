# Simulation Replication Parametric Bootstrap (Parallel)

Simulation Replication Parametric Bootstrap (Parallel)

## Usage

``` r
SimPara(taskid, repid, output_folder, overwrite, integrity, seed, B)
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

- B:

  Positive integer. Number of bootstrap samples.

## Value

The output is saved as an external file in `output_folder`.

## Author

Ivan Jacob Agaloos Pesigan
