#' Generate Unique Simulation Random Seed
#'
#' @author Ivan Jacob Agaloos Pesigan
#'
#' @return Returns an integer.
#'
#' @param taskid Positive integer.
#'   Task ID.
#' @param repid Positive integer.
#'   Replication ID.
#'
#' @family Simulation Helper Functions
#' @keywords simTools internal
#' @noRd
.SimSeed <- function(taskid,
                     repid) {
  stopifnot(
    taskid <= 9999,
    repid <= 99999
  )
  taskid <- as.integer(taskid)
  repid <- as.integer(repid)
  return(
    as.integer(
      as.numeric(
        paste0(
          sprintf(
            "%05d",
            taskid
          ),
          sprintf(
            "%05d",
            repid
          )
        )
      )
    )
  )
}
