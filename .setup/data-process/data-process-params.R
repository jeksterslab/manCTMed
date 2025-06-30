data_process_params <- function(overwrite = TRUE) {
  cat("\ndata_process_params\n")
  set.seed(42)
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
  params_file <- file.path(
    data_folder,
    "params.rda"
  )
  if (!file.exists(params_file)) {
    write <- TRUE
  } else {
    if (overwrite) {
      write <- TRUE
    } else {
      write <- FALSE
    }
  }
  if (write) {
    n <- seq(
      from = 50,
      to = 500,
      by = 50
    )
    orig <- rep(x = 0, times = length(n))
    neutral <- rep(x = -1, times = length(n))
    strong <- rep(x = 1, times = length(n))
    dynamics <- c(
      orig,
      neutral,
      strong
    )
    taskid <- seq_len(
      length(dynamics)
    )
    params <- data.frame(
      taskid = taskid,
      n = n,
      dynamics = dynamics
    )
    rownames(params) <- params$taskid
    save(
      params,
      file = params_file,
      compress = "xz"
    )
  }
}
data_process_params()
rm(data_process_params)
