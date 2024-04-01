data_process_params <- function(overwrite = FALSE) {
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
    taskid <- seq_len(
      length(n)
    )
    params <- data.frame(
      taskid = taskid,
      n = n
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
