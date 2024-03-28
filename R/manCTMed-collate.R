#' Collate Results
#'
#' @author Ivan Jacob Agaloos Pesigan
#'
#' @inheritParams Data
#' @inheritParams CI
#' @inheritParams Replication
#' @param reps Replication numbers.
#' @param ns A vector of sample sizes.
#' @param ncores Positive integer.
#'   Number of cores to use.
#'
#' @family Simulation Functions
#' @keywords manCTMed
#' @export
Collate <- function(ns,
                    reps,
                    wd,
                    ncores = NULL) {
  .Collate <- function(n,
                       reps,
                       wd,
                       ncores) {
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
    parameter <- t(med[, -1])
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
            n = n,
            summary(ci, alpha = c(0.05, 0.01, 0.001)),
            fit = fit,
            method = method
          )
          if (method == "delta") {
            out$R <- NA
            out$sig_05 <- out$p < 0.05
            out$sig_01 <- out$p < 0.01
            out$sig_001 <- out$p < 0.001
          }
          if (method == "mc") {
            out$z <- NA
            out$p <- NA
            out$sig_05 <- NA
            out$sig_01 <- NA
            out$sig_001 <- NA
          }
          return(
            out
          )
        },
        ci = list(
          x$ci_dynr$delta,
          x$ci_dynr$mc
        ),
        fit = c("dynr", "dynr"),
        method = c("delta", "mc"),
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
    output$zero_hit_05 <- (
      (
        output[, "2.5%"] < 0
      ) & (
        0 < output[, "97.5%"]
      )
    )
    output$zero_hit_01 <- (
      (
        output[, "0.5%"] < 0
      ) & (
        0 < output[, "99.5%"]
      )
    )
    output$zero_hit_001 <- (
      (
        output[, "0.05%"] < 0
      ) & (
        0 < output[, "99.95%"]
      )
    )
    output$one_minus_zero_hit_05 <- 1 - output$zero_hit_05
    output$one_minus_zero_hit_01 <- 1 - output$zero_hit_01
    output$one_minus_zero_hit_001 <- 1 - output$zero_hit_001    
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
  return(
    lapply(
      X = ns,
      FUN = .Collate,
      reps = reps,
      wd = wd,
      ncores = ncores
    )
  )
}
