#' Summarize Results
#'
#' @author Ivan Jacob Agaloos Pesigan
#'
#' @inheritParams Data
#' @inheritParams CI
#' @inheritParams Replication
#' @param reps Replication numbers.
#' @param ncores Positive integer.
#'   Number of cores to use.
#'
#' @examples
#' n <- 50
#' wd <- tempdir()
#' delta_t <- c(5, 10)
#' R <- 25L
#' reps <- 1:2
#' lapply(
#'   X = 1:2,
#'   FUN = Replication,
#'   n = 50,
#'   wd = wd,
#'   delta_t = delta_t,
#'   R = R
#' )
#' Summarize(n = n, reps = reps, wd = wd)
#'
#' @family Simulation Functions
#' @keywords manCTMed
#' @export
Summarize <- function(n,
                      reps = 1:1000,
                      wd,
                      ncores = NULL) {
  if (is.null(ncores)) {
    ncores <- 1
  } else {
    if (ncores < 0) {
      ncores <- 1
    }
  }
  # path
  path <- file.path(
    wd,
    paste0(
      "n",
      "-",
      sprintf(
        "%05d",
        n
      )
    )
  )
  dir.create(
    path,
    showWarnings = FALSE,
    recursive = TRUE
  )
  # files
  fn_root <- file.path(
    path,
    paste0(
      "manCTMed",
      "-",
      "n",
      "-",
      sprintf(
        "%05d",
        n
      ),
      "-",
      "rep",
      "-",
      sprintf(
        "%05d",
        1
      )
    )
  )
  fn <- paste0(
    fn_root,
    ".Rds"
  )
  first <- readRDS(fn)
  phi <- first$data$args$phi
  colnames(phi) <- rownames(phi) <- c("x", "m", "y")
  med <- summary(
    cTMed::Med(
      phi = phi,
      delta_t = first$ci_dynr$delta_t,
      from = "x",
      to = "y",
      med = "m"
    )
  )
  parameter <- do.call(
    what = "cbind",
    args = lapply(
      X = as.data.frame(t(med)),
      FUN = function(x) {
        return(t(x[-1]))
      }
    )
  )
  dim(parameter) <- NULL
  foo <- function(repid,
                  n,
                  wd,
                  parameter) {
    # files
    fn_root <- file.path(
      path,
      paste0(
        "manCTMed",
        "-",
        "n",
        "-",
        sprintf(
          "%05d",
          n
        ),
        "-",
        "rep",
        "-",
        sprintf(
          "%05d",
          repid
        )
      )
    )
    fn <- paste0(
      fn_root,
      ".Rds"
    )
    x <- readRDS(fn)
    ci <- mapply(
      FUN = function(ci,
                     fit,
                     method,
                     repid) {
        out <- cbind(
          repid = repid,
          summary(ci, alpha = c(0.05, 0.01, 0.001)),
          fit = fit,
          method = method
        )
        if (method == "delta") {
          out$R <- NA
        }
        if (method == "mc" || method == "posterior") {
          out$z <- NA
          out$p <- NA
        }
        return(
          out
        )
      },
      ci = list(
        x$ci_dynr$delta,
        x$ci_dynr$mc,
        x$ci_ctsem$delta,
        x$ci_ctsem$mc,
        x$ci_ctsem$posterior
      ),
      fit = c("dynr", "dynr", "ctsem", "ctsem", "ctsem"),
      method = c("delta", "mc", "delta", "mc", "posterior"),
      repid = repid,
      SIMPLIFY = FALSE
    )
    ci <- lapply(
      X = ci,
      FUN = function(x) {
        return(
          cbind(
            x,
            parameter = parameter
          )
        )
      }
    )
    ci <- do.call(
      what = "rbind",
      args = ci
    )
    return(ci)
  }
  output <- parallel::mclapply(
    X = reps,
    FUN = foo,
    n = n,
    wd = wd,
    parameter = parameter,
    mc.cores = ncores
  )
  output <- do.call(
    what = "rbind",
    args = output
  )
  output$hit_05 <- (
    (
      output[, "2.5%"] < output[, "parameter"]
    ) & (
      output[, "parameter"] < output[, "97.5%"]
    )
  )
  output$hit_01 <- (
    (
      output[, "0.5%"] < output[, "parameter"]
    ) & (
      output[, "parameter"] < output[, "99.5%"]
    )
  )
  output$hit_001 <- (
    (
      output[, "0.05%"] < output[, "parameter"]
    ) & (
      output[, "parameter"] < output[, "99.95%"]
    )
  )
  output$width_05 <- (
    (
      output[, "est"] - output[, "2.5%"]
    ) + (
      output[, "97.5%"] - output[, "est"]
    )
  )
  output$width_01 <- (
    (
      output[, "est"] - output[, "0.5%"]
    ) + (
      output[, "99.5%"] - output[, "est"]
    )
  )
  output$width_001 <- (
    (
      output[, "est"] - output[, "0.05%"]
    ) + (
      output[, "99.95%"] - output[, "est"]
    )
  )
  output$sym_05 <- (
    (
      output[, "est"] - output[, "2.5%"]
    ) - (
      output[, "97.5%"] - output[, "est"]
    )
  )
  output$sym_01 <- (
    (
      output[, "est"] - output[, "0.5%"]
    ) - (
      output[, "99.5%"] - output[, "est"]
    )
  )
  output$sym_001 <- (
    (
      output[, "est"] - output[, "0.05%"]
    ) - (
      output[, "99.95%"] - output[, "est"]
    )
  )
  return(
    output
  )
}
