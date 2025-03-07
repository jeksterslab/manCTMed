#' Summarize Simulations - Raw
#'
#' @author Ivan Jacob Agaloos Pesigan
#'
#' @return Returns a numeric matrix.
#'
#' @inheritParams TemplateIllustration
#' @export
#' @keywords manCTMed ci summary
# nolint start: cyclocomp_linter
IllustrationSumRaw <- function(taskid,
                               reps,
                               output_folder,
                               output_type,
                               ncores) {
  phi <- matrix(
    data = c(
      -0.138,
      -0.124,
      -0.057,
      0,
      -0.865,
      0.115,
      0,
      0.434,
      -0.693
    ),
    nrow = 3,
    ncol = 3
  )
  sigma <- 0.10 * diag(3)
  colnames(phi) <- rownames(phi) <- c("x", "m", "y")
  # Summary is limited to alpha = 0.05
  if (output_type == "illustration-dynr-delta-xmy") {
    method <- "delta"
    xmy <- TRUE
    std <- FALSE
  }
  if (output_type == "illustration-dynr-mc-xmy") {
    method <- "mc"
    xmy <- TRUE
    std <- FALSE
  }
  if (output_type == "illustration-dynr-delta-std-xmy") {
    method <- "delta"
    xmy <- TRUE
    std <- TRUE
  }
  if (output_type == "illustration-dynr-mc-std-xmy") {
    method <- "mc"
    xmy <- TRUE
    std <- TRUE
  }
  if (xmy) {
    if (std) {
      xmy_effects <- cTMed::MedStd(
        phi = phi,
        sigma = sigma,
        delta_t = 1:30,
        from = "x",
        to = "y",
        med = "m"
      )$output
    } else {
      xmy_effects <- cTMed::Med(
        phi = phi,
        delta_t = 1:30,
        from = "x",
        to = "y",
        med = "m"
      )$output
    }
    parameter <- t(xmy_effects[, -4])
    dim(parameter) <- NULL
  } else {
    if (std) {
      ymx_effects <- cTMed::MedStd(
        phi = phi,
        sigma = sigma,
        delta_t = 1:30,
        from = "y",
        to = "x",
        med = "m"
      )$output
    } else {
      ymx_effects <- cTMed::Med(
        phi = phi,
        delta_t = 1:30,
        from = "y",
        to = "x",
        med = "m"
      )$output
    }
    parameter <- t(ymx_effects[, -4])
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
      parameter = parameter,
      repid = repid
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
    if (method %in% c("mc", "pb")) {
      output$z <- NA
      output$p <- NA
      output$sig <- NA
    }
    if (method == "delta") {
      output$R <- NA
      output$sig <- output$p < 0.05
    }
    output
  }
  out <- do.call(
    what = "rbind",
    args = parallel::mclapply(
      X = seq_len(reps),
      FUN = foo,
      taskid = taskid,
      output_folder = output_folder,
      parameter = parameter,
      mc.cores = ncores
    )
  )
  out$effect <- c(
    "total",
    "direct",
    "indirect"
  )
  cbind(
    taskid = taskid,
    replications = reps,
    n = 133,
    method = method,
    out,
    output_type = output_type,
    xmy = xmy,
    std = std,
    dynamics = 0
  )
}
# nolint end
