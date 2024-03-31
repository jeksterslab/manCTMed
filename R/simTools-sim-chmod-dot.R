#' Change File Permissions
#'
#' @author Ivan Jacob Agaloos Pesigan
#'
#' @return Invisible.
#'
#' @inheritParams base::Sys.chmod
#'
#' @family Simulation Helper Functions
#' @keywords simTools internal
#' @noRd
.SimChMod <- function(paths,
                      mode = "0777",
                      use_umask = FALSE) {
  invisible(
    Sys.chmod(
      paths = paths,
      mode = mode,
      use_umask = use_umask
    )
  )
}
