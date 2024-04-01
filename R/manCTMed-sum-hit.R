#' Summarize Simulations - CI Hit
#'
#' @author Ivan Jacob Agaloos Pesigan
#'
#' @return Returns a numeric matrix.
#'
#' @inheritParams Template
#' @export
#' @keywords manCTMed ci summary
SumHit <- function(taskid,
                   reps,
                   output_folder,
                   output_type,
                   params_taskid,
                   ncores) {
  # Summary is limited to alpha = 0.05
  if (output_type == "dynr-delta-xmy") {
    method <- "delta"
    xmy <- TRUE
  }
  if (output_type == "dynr-delta-ymx") {
    method <- "delta"
    xmy <- FALSE
  }
  if (output_type == "dynr-mc-xmy") {
    method <- "mc"
    xmy <- TRUE
  }
  if (output_type == "dynr-mc-ymx") {
    method <- "mc"
    xmy <- FALSE
  }
  if (xmy) {
    parameter <- t(effects$xmy[, -1])
    dim(parameter) <- NULL
  } else {
    parameter <- t(effects$ymx[, -1])
    dim(parameter) <- NULL
  }
  output_folder <- file.path(
    output_folder,
    paste0(
      SimProj(),
      "-",
      sprintf(
        "%05d",
        taskid
      )
    )
  )
  foo <- function(repid,
                  taskid,
                  output_folder,
                  params_taskid,
                  parameter) {
    suffix <- .SimSuffix(
      taskid = taskid,
      repid = repid
    )
    fn_input <- SimFN(
      output_type = output_type,
      output_folder = output_folder,
      suffix = suffix
    )
    output <- summary(
      readRDS(fn_input),
      alpha = 0.05
    )
    output$effect <- c(1, 2, 3)
    output <- cbind(
      output,
      parameter = parameter
    )
    output$zero_hit <- (
      output[, "2.5%"] <= 0
    ) & (
      0 <= output[, "97.5%"]
    )
    output$theta_hit <- (
      output[, "2.5%"] <= output[, "parameter"]
    ) & (
      output[, "parameter"] <= output[, "97.5%"]
    )
    if (method == "mc") {
      output$z <- 0
      output$p <- 0
      output$sig <- 0
    }
    if (method == "delta") {
      output$R <- 0
      output$sig <- output$p < 0.05
    }
    return(output)
  }
  out <- (
    1 / reps
  ) * Reduce(
    f = `+`,
    x = parallel::mclapply(
      X = seq_len(reps),
      FUN = foo,
      taskid = taskid,
      output_folder = output_folder,
      params_taskid = params_taskid,
      parameter = parameter,
      mc.cores = ncores
    )
  )
  out$effect <- c(
    "total",
    "direct",
    "indirect"
  )
  out <- cbind(
    taskid = taskid,
    replications = reps,
    n = params_taskid$n,
    method = method,
    out,
    output_type = output_type,
    xmy = xmy
  )
  if (method == "delta") {
    out$R <- NA
  }
  if (method == "mc") {
    out$z <- NA
    out$p <- NA
    out$sig <- NA
  }
  return(
    out
  )
}
