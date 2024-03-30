#' Simulation Path
#'
#' Creates a simulation project folder (if it does not exist yet)
#' and returns its OS specific path as a character string.
#'
#' @author Ivan Jacob Agaloos Pesigan
#'
#' @return Returns the OS specific project path as a character string.
#'
#' @param root Character string.
#'   Root path of the simulation output path.
#'   The default value is the `home` directory.
#'
#' @family Simulation Helper Functions
#' @keywords simTools internal
#' @noRd
.SimPath <- function(root = Sys.getenv("HOME"),
                     project) {
  path <- file.path(
    root,
    project
  )
  dir.create(
    path,
    showWarnings = FALSE,
    recursive = TRUE
  )
  return(
    path
  )
}
