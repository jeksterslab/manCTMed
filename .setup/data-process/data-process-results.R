data_process_results <- function(overwrite = FALSE) {
  # find root directory
  root <- rprojroot::is_rstudio_project
  data_folder <- root$find_file(
    "data"
  )
  if (!dir.exists(data_folder)) {
    dir.create(
      data_folder,
      recursive = TRUE
    )
  }
  results_file <- file.path(
    data_folder,
    "results.rda"
  )
  if (!file.exists(results_file)) {
    write <- TRUE
  } else {
    if (overwrite) {
      write <- TRUE
    } else {
      write <- FALSE
    }
  }
  if (write) {
    results <- readRDS(
      root$find_file(
        ".setup",
        "data-raw",
        "manCTMed.Rds"
      )
    )
    results <- results[
      ,
      c(
        "taskid",
        "replications",
        "output_type",
        "xmy",
        "n",
        "method",
        "effect",
        "interval",
        "parameter",
        "est",
        "se",
        "z",
        "p",
        "R",
        "2.5%",
        "97.5%",
        "zero_hit",
        "theta_hit",
        "sig"
      )
    ]
    save(
      results,
      file = results_file,
      compress = "xz"
    )
  }
}
data_process_results()
rm(data_process_results)
