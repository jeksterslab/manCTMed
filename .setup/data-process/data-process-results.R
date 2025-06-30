data_process_results <- function(overwrite = TRUE) {
  cat("\ndata_process_results\n")
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
  xmy <- lapply(
    X = seq_len(30),
    FUN = function(i) {
      rbind(
        readRDS(
          root$find_file(
            ".setup",
            "data-raw",
            paste0(
              "manCTMed-summary-dynr-delta-xmy-",
              sprintf(
                "%05d",
                i
              ),
              ".Rds"
            )
          )
        )$means,
        readRDS(
          root$find_file(
            ".setup",
            "data-raw",
            paste0(
              "manCTMed-summary-dynr-delta-std-xmy-",
              sprintf(
                "%05d",
                i
              ),
              ".Rds"
            )
          )
        )$means,
        readRDS(
          root$find_file(
            ".setup",
            "data-raw",
            paste0(
              "manCTMed-summary-dynr-mc-xmy-",
              sprintf(
                "%05d",
                i
              ),
              ".Rds"
            )
          )
        )$means,
        readRDS(
          root$find_file(
            ".setup",
            "data-raw",
            paste0(
              "manCTMed-summary-dynr-mc-std-xmy-",
              sprintf(
                "%05d",
                i
              ),
              ".Rds"
            )
          )
        )$means
      )
    }
  )
  ymx <- lapply(
    X = seq_len(30),
    FUN = function(i) {
      rbind(
        readRDS(
          root$find_file(
            ".setup",
            "data-raw",
            paste0(
              "manCTMed-summary-dynr-delta-ymx-",
              sprintf(
                "%05d",
                i
              ),
              ".Rds"
            )
          )
        )$means,
        readRDS(
          root$find_file(
            ".setup",
            "data-raw",
            paste0(
              "manCTMed-summary-dynr-delta-std-ymx-",
              sprintf(
                "%05d",
                i
              ),
              ".Rds"
            )
          )
        )$means,
        readRDS(
          root$find_file(
            ".setup",
            "data-raw",
            paste0(
              "manCTMed-summary-dynr-mc-ymx-",
              sprintf(
                "%05d",
                i
              ),
              ".Rds"
            )
          )
        )$means,
        readRDS(
          root$find_file(
            ".setup",
            "data-raw",
            paste0(
              "manCTMed-summary-dynr-mc-std-ymx-",
              sprintf(
                "%05d",
                i
              ),
              ".Rds"
            )
          )
        )$means
      )
    }
  )
  results <- rbind(
    do.call(
      what = "rbind",
      args = xmy
    ),
    do.call(
      what = "rbind",
      args = ymx
    )
  )
  save(
    results,
    file = file.path(
      data_folder,
      "results.rda"
    ),
    compress = "xz"
  )
}
data_process_results()
rm(data_process_results)
