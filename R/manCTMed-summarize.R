#' Summarize Results
#'
#' @author Ivan Jacob Agaloos Pesigan
#'
#' @inheritParams Collate
#' @param x R object.
#'   Output of the [Collate()] function.
#'
#' @examples
#' n <- 50
#' wd <- tempdir()
#' delta_t <- c(5, 10)
#' R <- 1000L
#' reps <- 1:100
#' lapply(
#'   X = reps,
#'   FUN = Replication,
#'   n = n,
#'   wd = wd,
#'   delta_t = delta_t,
#'   R = R
#' )
#' x <- Collate(n = n, reps = reps, wd = wd)
#' Summarize(x)
#'
#' @family Simulation Functions
#' @keywords manCTMed
#' @export
Summarize <- function(x,
                      ncores = NULL) {
  if (is.null(ncores)) {
    ncores <- 1
  } else {
    if (ncores < 0) {
      ncores <- 1
    }
  }
  foo <- function(x,
                  n,
                  delta_t,
                  fit,
                  method) {
    if (fit == "dynr" && method == "posterior") {
      stop(
        "`fit = \"dynr\"` and `method =\"posterior\"` not available."
      )
    }
    x <- x[
      which(x[, "interval"] == delta_t), ,
      drop = FALSE
    ]
    x <- x[
      which(x[, "fit"] == fit), ,
      drop = FALSE
    ]
    x <- x[
      which(x[, "method"] == method), ,
      drop = FALSE
    ]
    effects <- unique(x[, "effect"])
    output <- lapply(
      X = effects,
      FUN = function(effect) {
        x <- x[
          which(x[, "effect"] == effect), ,
          drop = FALSE
        ]
        # recode
        x[, "repid"] <- max(x[, "repid"])
        x[, "fit"] <- 0
        x[, "method"] <- 0
        # recode effect
        if (effect == "total") {
          x[, "effect"] <- 1
        }
        if (effect == "direct") {
          x[, "effect"] <- 2
        }
        if (effect == "indirect") {
          x[, "effect"] <- 3
        }
        quantiles <- stats::quantile(
          x = x[, "est"],
          probs = c(0.0005, 0.005, 0.025, 0.50, 0.975, 0.995, 0.9995)
        )
        names(quantiles) <- paste0(
          "sim_",
          names(quantiles)
        )
        means_orig <- colMeans(x)
        means_names <- names(means_orig)
        means_names[1] <- "reps"
        names(means_orig) <- means_names
        means <- c(
          means_orig,
          est_var = stats::var(x[, "est"]),
          est_sd = stats::sd(x[, "est"]),
          quantiles
        )
        sim_width_05 <- (
          (
            means[["est"]] - means[["sim_2.5%"]]
          ) + (
            means[["sim_97.5%"]] - means[["est"]]
          )
        )
        sim_width_01 <- (
          (
            means[["est"]] - means[["sim_0.5%"]]
          ) + (
            means[["sim_99.5%"]] - means[["est"]]
          )
        )
        sim_width_001 <- (
          (
            means[["est"]] - means[["sim_0.05%"]]
          ) + (
            means[["sim_99.95%"]] - means[["est"]]
          )
        )
        sim_sym_05 <- (
          (
            means[["est"]] - means[["sim_2.5%"]]
          ) - (
            means[["sim_97.5%"]] - means[["est"]]
          )
        )
        sim_sym_01 <- (
          (
            means[["est"]] - means[["sim_0.5%"]]
          ) - (
            means[["sim_99.5%"]] - means[["est"]]
          )
        )
        sim_sym_001 <- (
          (
            means[["est"]] - means[["sim_0.05%"]]
          ) - (
            means[["sim_99.95%"]] - means[["est"]]
          )
        )
        return(
          c(
            means,
            sim_width_05 = sim_width_05,
            sim_width_01 = sim_width_01,
            sim_width_001 = sim_width_001,
            sim_sym_05 = sim_sym_05,
            sim_sym_01 = sim_sym_01,
            sim_sym_001 = sim_sym_001
          )
        )
      }
    )
    output <- as.data.frame(
      do.call(
        what = "rbind",
        args = output
      )
    )
    output[, "effect"] <- effects
    output[, "fit"] <- fit
    output[, "method"] <- method
    return(output)
  }
  n <- unique(x[, "n"])
  delta_t <- unique(x[, "interval"])
  fit <- unique(x[, "fit"])
  method <- unique(x[, "method"])
  args <- expand.grid(n = n, delta_t = delta_t, fit = fit, method = method)
  args <- args[!(args[, "fit"] == "dynr" & args[, "method"] == "posterior"), ]
  output <- parallel::mclapply(
    X = 1:(dim(args)[1]),
    FUN = function(i) {
      foo(
        x = x,
        n = args[i, "n"],
        delta_t = args[i, "delta_t"],
        fit = args[i, "fit"],
        method = args[i, "method"]
      )
    },
    mc.cores = ncores
  )
  return(
    do.call(
      what = "rbind",
      args = output
    )
  )
}
