data_process_ou_ctsem <- function(overwrite = FALSE) {
  # find root directory
  root <- rprojroot::is_rstudio_project
  deboeck2015_na_rds <- root$find_file(
    ".setup",
    "data-raw",
    "deboeck2015_na.Rds"
  )
  deboeck2015_ou_ctsem_rds <- root$find_file(
    ".setup",
    "data-raw",
    "deboeck2015_ou_ctsem.Rds"
  )
  if (file.exists(deboeck2015_ou_ctsem_rds)) {
    run <- FALSE
    if (overwrite) {
      run <- TRUE
    }
  } else {
    run <- TRUE
  }
  if (!file.exists(deboeck2015_na_rds)) {
    run <- TRUE
  }
  if (run) {
    dir.create(
      root$find_file(
        ".setup",
        "data-raw"
      ),
      showWarnings = FALSE,
      recursive = TRUE
    )
    dir.create(
      root$find_file(
        "data"
      ),
      showWarnings = FALSE,
      recursive = TRUE
    )
    source(
      root$find_file(
        ".setup",
        "data-process",
        "data-process-deboeck2015.R"
      )
    )
    data <- readRDS(deboeck2015_na_rds)
    library(ctsem)
    model <- ctModel(
      type = "stanct",
      manifestNames = c("x", "m", "y"),
      latentNames = c("eta_x", "eta_m", "eta_y"),
      id = "id",
      time = "time",
      silent = TRUE,
      LAMBDA = diag(3),
      DRIFT = "auto",
      MANIFESTMEANS = matrix(data = 0, nrow = 3, ncol = 1),
      MANIFESTVAR = diag(0, 3),
      CINT = "auto",
      DIFFUSION = "auto"
    )
    set.seed(42)
    fit <- ctStanFit(
      datalong = data,
      ctstanmodel = model,
      optimize = TRUE,
      cores = parallel::detectCores()
    )
    saveRDS(
      fit,
      file = deboeck2015_ou_ctsem_rds,
      compress = "xz"
    )
  }
}
data_process_ou_ctsem()
rm(data_process_ou_ctsem)
