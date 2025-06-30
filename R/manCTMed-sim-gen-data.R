#' Simulation Replication - GenData
#'
#' @details This function is executed via the `Sim` function.
#'
#' @author Ivan Jacob Agaloos Pesigan
#'
#' @return The output is saved as an external file in `output_folder`.
#'
#' @inheritParams Template
#' @export
#' @keywords manCTMed gendata simulation
SimGenData <- function(taskid,
                       repid,
                       output_folder,
                       seed,
                       suffix,
                       overwrite,
                       integrity) {
  # Do not include default arguments here.
  # Do not run on its own. Use the `Sim` function.
  fn_output <- SimFN(
    output_type = "data",
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
      object = GenData(
        taskid = taskid
      ),
      file = con
    )
    close(con)
    .SimChMod(fn_output)
  }
}
