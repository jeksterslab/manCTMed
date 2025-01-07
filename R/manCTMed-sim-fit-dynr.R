#' Simulation Replication - FitDynr
#'
#' @details This function is executed via the `Sim` function.
#'
#' @author Ivan Jacob Agaloos Pesigan
#'
#' @return The output is saved as an external file in `output_folder`.
#'
#' @inheritParams Template
#' @export
#' @keywords manCTMed fit simulation
SimFitDynr <- function(taskid,
                       repid,
                       output_folder,
                       seed,
                       suffix,
                       overwrite,
                       integrity) {
  # Do not include default arguments here.
  # Do not run on its own. Use the `Sim` function.
  fn_input <- SimFN(
    output_type = "data",
    output_folder = output_folder,
    suffix = suffix
  )
  fn_output <- SimFN(
    output_type = "fit-dynr",
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
      object = FitDynr(
        data = RandomMeasurement(
          sim = readRDS(fn_input)
        ),
        taskid = taskid
      ),
      file = con
    )
    close(con)
    .SimChMod(fn_output)
  }
}
