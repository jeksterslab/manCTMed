#' Simulation Replication
#'
#' Performs a single simulation replication involving the following:
#' - Data generation using the `simStateSpace` package.
#' - Model fitting using the `dynr` package.
#' - Model fitting using the `ctsem` package.
#' - Generate delta method confidence intervals
#'   using the [cTMed::DeltaMed()] function.
#' - Generate Monte Carlo method confidence intervals
#'   using the [cTMed::MCMed()] function.
#' - Generate credible intervals
#'   based on the posterior distribution of the drift matrix
#'   using the [cTMed::PosteriorMed()] function.
#'
#' @author Ivan Jacob Agaloos Pesigan
#'
#' @inheritParams Data
#' @inheritParams CI
#' @param wd Working directory for output files. 
#'
#' @family Simulation Functions
#' @keywords manCTMed
#' @export
Replication <- function(i,
                        n,
                        wd,
                        delta_t = c(5, 10, 15, 20),
                        R = 20000L) {
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
        i
      )
    )
  )
  fn <- paste0(
    fn_root,
    ".Rds"
  )
  if (file.exists(fn)) {
    tryCatch(
      expr = {
        readRDS(fn)
        run <- FALSE
      },
      error = function(e) {
        run <- TRUE
      }
    )
  } else {
    run <- TRUE
  }
  if (run) {
    data <- Data(
      i = i,
      n = n
    )
    fit_dynr <- FitDynr(x = data)
    fit_ctsem <- FitCtsem(x = data)
    ci_dynr <- CI(x = fit_dynr)
    ci_ctsem <- CI(x = fit_ctsem)
    output <- list(
      data = data,
      fit_dynr = fit_dynr,
      fit_ctsem = fit_ctsem,
      ci_dynr = ci_dynr,
      ci_ctsem = ci_ctsem
    )
    saveRDS(
      output,
      file = fn,
      compress = "xz"
    )
  }
  return(
    paste(
      "Replication",
      i,
      "done."
    )
  )
}
