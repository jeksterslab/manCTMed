#' Simulation Replication - Grundy2007GenData
#'
#' @details This function is executed via the `SimGrundy2007` function.
#'
#' @author Ivan Jacob Agaloos Pesigan
#'
#' @return The output is saved as an external file in `output_folder`.
#'
#' @inheritParams Template
#' @export
#' @keywords manCTMed Grundy2007GenData simulation
SimGrundy2007GenData <- function(taskid,
                                 repid,
                                 output_folder,
                                 seed,
                                 suffix,
                                 overwrite,
                                 integrity) {
  # Do not include default arguments here.
  # Do not run on its own. Use the `SimGrundy2007` function.
  fn_output <- SimFN(
    output_type = "grundy2007-data",
    output_folder = output_folder,
    suffix = suffix
  )
  run <- .SimCheck(
    fn = fn_output,
    overwrite = overwrite,
    integrity = integrity
  )
  if (run) {
    set.seed(seed)
    con <- file(fn_output)
    saveRDS(
      object = Grundy2007GenData(
        taskid = taskid,
        seed = seed,
        empirical = FALSE
      ),
      file = con
    )
    close(con)
    .SimChMod(fn_output)
  }
}
