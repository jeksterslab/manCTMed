#' Summarize Simulations - Raw
#' (Grundy, et al. 2007)
#'
#' @author Ivan Jacob Agaloos Pesigan
#'
#' @return Returns a numeric matrix.
#'
#' @inheritParams Template
#' @export
#' @keywords manCTMed ci summary
# nolint start: cyclocomp_linter
SumGrundyRaw <- function(taskid,
                         reps,
                         output_folder,
                         output_type,
                         ncores) {
  if (taskid == 1) {
    n <- 133
  } else {
    stop("`taskid > 1` not allowed.")
  }
  phi <- matrix(
    data = c(
      -0.033712,
      0.037816,
      -0.013207,
      -0.152350,
      -0.590262,
      0.230235,
      -0.100435,
      0.105462,
      -0.515149
    ),
    nrow = 3,
    ncol = 3
  )
  sigma <- matrix(
    data = c(
      0.057708,
      -0.008654,
      0.010219,
      -0.008654,
      0.746297,
      0.099170,
      0.010219,
      0.099170,
      0.841681
    ),
    nrow = 3,
    ncol = 3
  )
  colnames(phi) <- rownames(phi) <- c("x", "m", "y")
  # Summary is limited to alpha = 0.05
  if (output_type == "grundy2007-dynr-delta-xmy") {
    method <- "delta"
    xmy <- TRUE
    std <- FALSE
  }
  if (output_type == "grundy2007-dynr-delta-xym") {
    method <- "delta"
    xmy <- FALSE
    std <- FALSE
  }
  if (output_type == "grundy2007-dynr-mc-xmy") {
    method <- "mc"
    xmy <- TRUE
    std <- FALSE
  }
  if (output_type == "grundy2007-dynr-mc-xym") {
    method <- "mc"
    xmy <- FALSE
    std <- FALSE
  }
  if (output_type == "grundy2007-dynr-pb-xmy") {
    method <- "pb"
    xmy <- TRUE
    std <- FALSE
  }
  if (output_type == "grundy2007-dynr-pb-xym") {
    method <- "pb"
    xmy <- FALSE
    std <- FALSE
  }
  if (output_type == "grundy2007-dynr-delta-std-xmy") {
    method <- "delta"
    xmy <- TRUE
    std <- TRUE
  }
  if (output_type == "grundy2007-dynr-delta-std-xym") {
    method <- "delta"
    xmy <- FALSE
    std <- TRUE
  }
  if (output_type == "grundy2007-dynr-mc-std-xmy") {
    method <- "mc"
    xmy <- TRUE
    std <- TRUE
  }
  if (output_type == "grundy2007-dynr-mc-std-xym") {
    method <- "mc"
    xmy <- FALSE
    std <- TRUE
  }
  if (output_type == "grundy2007-dynr-pb-std-xmy") {
    method <- "pb"
    xmy <- TRUE
    std <- TRUE
  }
  if (output_type == "grundy2007-dynr-pb-std-xym") {
    method <- "pb"
    xmy <- FALSE
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
      xym_effects <- cTMed::MedStd(
        phi = phi,
        sigma = sigma,
        delta_t = 1:30,
        from = "x",
        to = "m",
        med = "y"
      )$output
    } else {
      xym_effects <- cTMed::Med(
        phi = phi,
        delta_t = 1:30,
        from = "x",
        to = "m",
        med = "y"
      )$output
    }
    parameter <- t(xym_effects[, -4])
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
    if (method == "pb") {
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
      parameter = parameter,
      mc.cores = ncores
    )
  )
  out$effect <- c(
    "total",
    "direct",
    "indirect"
  )
  return(
    cbind(
      taskid = taskid,
      replications = reps,
      n = n,
      method = method,
      out,
      output_type = output_type,
      xmy = xmy,
      std = std,
      dynamics = 0
    )
  )
}
# nolint end
