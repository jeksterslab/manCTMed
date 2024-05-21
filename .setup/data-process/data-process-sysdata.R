data_process_sysdata <- function() {
  cat("\ndata_process_sysdata\n")
  set.seed(42)
  # find root directory
  root <- rprojroot::is_rstudio_project
  effects <- readRDS(
    root$find_file(
      ".setup",
      "data-raw",
      "effects.Rds"
    )
  )
  model <- readRDS(
    root$find_file(
      ".setup",
      "data-raw",
      "model.Rds"
    )
  )
  usethis::use_data(
    effects,
    model,
    internal = TRUE,
    overwrite = TRUE
  )
}
data_process_sysdata()
rm(data_process_sysdata)
