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
  phi <- first$args$phi
  colnames(phi) <- rownames(phi) <- c("x", "m", "y")
  med <- cTMed::Med(
    phi = phi,
    delta_t = first$ci_dynr$delta_t,
    from = "x",
    to = "y",
    med = "m"
  )
  parameters <- do.call(
    what = "cbind",
    args = lapply(
      X = as.data.frame(t(summary(med))),
      FUN = function(x) {
        return(t(x[-1]))
      }
    )
  )
  dim(parameters) <- NULL
  foo <- function(i,
                  n,
                  wd,
                  parameters) {
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
          i
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
                     method) {
        return(
          cbind(
            summary(ci),
            fit = fit,
            method = method
          )
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
      SIMPLIFY = FALSE
    )
    ci <- lapply(
      X = ci,
      FUN = function(x) {
        return(
          cbind(
            x,
            parameters = parameters
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
    parameters = parameters,
    mc.cores = ncores
  )
  return(
    do.call(
      what = "rbind",
      args = output
    )
  )
}
