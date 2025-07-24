data_process_example_results <- function(overwrite = FALSE) {
  cat("\ndata_process_example_results\n")
  set.seed(42)
  # find root directory
  root <- rprojroot::is_rstudio_project
  data_raw_folder <- root$find_file(
    ".setup",
    "data-raw"
  )
  data_folder <- root$find_file(
    "data"
  )
  if (!dir.exists(data_raw_folder)) {
    dir.create(
      data_raw_folder,
      recursive = TRUE
    )
  }
  if (!dir.exists(data_folder)) {
    dir.create(
      data_folder,
      recursive = TRUE
    )
  }
  illustration_results <- rbind(
    readRDS(
      root$find_file(
        ".setup",
        "data-raw",
        "manCTMed-illustration-summary-dynr-boot-para-bc-xmy-00001.Rds"
      )
    )$means,
    readRDS(
      root$find_file(
        ".setup",
        "data-raw",
        "manCTMed-illustration-summary-dynr-boot-para-pc-xmy-00001.Rds"
      )
    )$means,
    readRDS(
      root$find_file(
        ".setup",
        "data-raw",
        "manCTMed-illustration-summary-dynr-boot-para-std-bc-xmy-00001.Rds"
      )
    )$means,
    readRDS(
      root$find_file(
        ".setup",
        "data-raw",
        "manCTMed-illustration-summary-dynr-boot-para-std-pc-xmy-00001.Rds"
      )
    )$means,
    readRDS(
      root$find_file(
        ".setup",
        "data-raw",
        "manCTMed-illustration-summary-dynr-delta-std-xmy-00001.Rds"
      )
    )$means,
    readRDS(
      root$find_file(
        ".setup",
        "data-raw",
        "manCTMed-illustration-summary-dynr-delta-xmy-00001.Rds"
      )
    )$means,
    readRDS(
      root$find_file(
        ".setup",
        "data-raw",
        "manCTMed-illustration-summary-dynr-mc-std-xmy-00001.Rds"
      )
    )$means,
    readRDS(
      root$find_file(
        ".setup",
        "data-raw",
        "manCTMed-illustration-summary-dynr-mc-xmy-00001.Rds"
      )
    )$means
  )
  save(
    illustration_results,
    file = file.path(
      data_folder,
      "illustration_results.rda"
    ),
    compress = "xz"
  )
}
data_process_example_results()
rm(data_process_example_results)
