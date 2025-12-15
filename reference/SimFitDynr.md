# Simulation Replication - FitDynr

Simulation Replication - FitDynr

## Usage

``` r
SimFitDynr(taskid, repid, output_folder, seed, suffix, overwrite, integrity)
```

## Arguments

- taskid:

  Positive integer. Task ID.

- repid:

  Positive integer. Replication ID.

- output_folder:

  Character string. Output folder.

- seed:

  Integer. Random seed.

- suffix:

  Character string. Output of `manCTMed:::.SimSuffix()`.

- overwrite:

  Logical. Overwrite existing output in `output_folder`.

- integrity:

  Logical. If `integrity = TRUE`, check for the output file integrity
  when `overwrite = FALSE`.

## Value

The output is saved as an external file in `output_folder`.

## Details

This function is executed via the `Sim` function.

## Author

Ivan Jacob Agaloos Pesigan
