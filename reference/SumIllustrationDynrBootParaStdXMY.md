# Summary - Illustration (DynrBootParaStdXMY)

Summary - Illustration (DynrBootParaStdXMY)

## Usage

``` r
SumIllustrationDynrBootParaStdXMY(
  taskid,
  reps,
  output_folder,
  overwrite,
  integrity,
  type = "pc"
)
```

## Arguments

- taskid:

  Positive integer. Task ID.

- reps:

  Positive integer. Number of replications.

- output_folder:

  Character string. Output folder.

- overwrite:

  Logical. Overwrite existing output in `output_folder`.

- integrity:

  Logical. If `integrity = TRUE`, check for the output file integrity
  when `overwrite = FALSE`.

- type:

  Character string. Confidence interval type.

## Value

The output is saved as an external file in `output_folder`.

## Details

This function is executed via the `IllustrationSum` function.

## Author

Ivan Jacob Agaloos Pesigan
