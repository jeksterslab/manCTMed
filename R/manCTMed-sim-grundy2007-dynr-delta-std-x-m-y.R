#' Simulation Replication - Grundy2007DynrDeltaStdXMY
#'
#' @details This function is executed via the `SimGrundy2007` function.
#'
#' @author Ivan Jacob Agaloos Pesigan
#'
#' @return The output is saved as an external file in `output_folder`.
#'
#' @inheritParams Template
#' @export
#' @keywords manCTMed fit simulation
SimGrundy2007DynrDeltaStdXMY <- function(taskid,
                                         repid,
                                         output_folder,
                                         seed,
                                         suffix,
                                         overwrite,
                                         integrity,
                                         delta_t) {
  # Do not include default arguments here.
  # Do not run on its own. Use the `SimGrundy2007` function.
  fn_input <- SimFN(
    output_type = "grundy2007-fit-dynr",
    output_folder = output_folder,
    suffix = suffix
  )
  fn_output <- SimFN(
    output_type = "grundy2007-dynr-delta-std-xmy",
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
      object = Grundy2007DeltaStdXMY(
        theta_hat = ThetaHat(readRDS(fn_input)),
        delta_t = delta_t
      ),
      file = con
    )
    close(con)
    .SimChMod(fn_output)
  }
}
