#' Generate Simulation Filename Suffix
#'
#' @author Ivan Jacob Agaloos Pesigan
#'
#' @return Returns a character string of `"taskid-repid.qs"`.
#'
#' @param taskid Positive integer.
#'   Task ID.
#' @param repid Positive integer.
#'   Replication ID.
#'   If `repid = NULL`, only `taskid` is used.
#'
#' @family Simulation Helper Functions
#' @keywords simTools internal
#' @noRd
.SimSuffix <- function(taskid,
                       repid) {
  if (is.null(repid)) {
    out <- paste0(
      sprintf(
        "%05d",
        taskid
      ),
      ".Rds"
    )
  } else {
    out <- paste0(
      sprintf(
        "%05d",
        taskid
      ),
      "-",
      sprintf(
        "%05d",
        repid
      ),
      ".Rds"
    )
  }
  out
}
