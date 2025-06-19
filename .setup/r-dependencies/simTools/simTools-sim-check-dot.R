#' Sanity Check to Determine Decision to Run Simulation
#'
#' @author Ivan Jacob Agaloos Pesigan
#'
#' @return Returns logical.
#'
#' @param fn Complete file name and path of the simulation output file.
#' @param overwrite Logical.
#'   If `overwrite = TRUE`,
#'   disregard whether or not `fn` exists and return `TRUE`.
#'   If `overwrite = FALSE` and `integrity = TRUE`,
#'   check for existence and integrity of `fn`, that is,
#'   if `fn` exists and integrity check succeeds, return `FALSE`,
#'   Otherwise, return `TRUE`.
#'   If `overwrite = FALSE` and `integrity = FALSE`,
#'   check for existence of `fn` only, that is,
#'   if `fn` exists, return `FALSE`,
#'   Otherwise, return `TRUE`.
#' @param integrity Logical.
#'   If `integrity = TRUE`,
#'   check for integrity of `fn` when `overwrite = FALSE`.
#'
#' @family Simulation Helper Functions
#' @keywords simTools internal
#' @noRd
.SimCheck <- function(fn,
                      overwrite,
                      integrity) {
  if (overwrite) {
    out <- TRUE
  } else {
    if (file.exists(fn)) {
      if (integrity) {
        out <- tryCatch(
          {
            x <- readRDS(file = fn)
            rm(x)
            FALSE
          },
          warning = function(w) {
            TRUE
          },
          error = function(e) {
            TRUE
          }
        )
      } else {
        out <- FALSE
      }
    } else {
      out <- TRUE
    }
  }
  out
}
