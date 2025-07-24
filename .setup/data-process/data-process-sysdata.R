data_process_sysdata <- function(overwrite = FALSE) {
  cat("\ndata_process_sysdata\n")
  set.seed(42)
  # find root directory
  root <- rprojroot::is_rstudio_project
  sysdata_file <- root$find_file(
    "R",
    "sysdata.rda"
  )
  if (!file.exists(sysdata_file)) {
    write <- TRUE
  } else {
    if (overwrite) {
      write <- TRUE
    } else {
      write <- FALSE
    }
  }
  if (write) {
    model <- readRDS(
      root$find_file(
        ".setup",
        "data-raw",
        "model.Rds"
      )
    )
    usethis::use_data(
      model,
      internal = TRUE,
      overwrite = TRUE
    )
  }
}
data_process_sysdata()
rm(data_process_sysdata)
