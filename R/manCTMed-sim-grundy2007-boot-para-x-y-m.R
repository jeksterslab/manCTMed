#' Simulation Replication - Grundy2007BootParaXYM
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
SimGrundy2007BootParaXYM <- function(taskid,
                                     repid,
                                     output_folder,
                                     seed,
                                     suffix,
                                     overwrite,
                                     integrity,
                                     delta_t) {
  # Do not include default arguments here.
  # Do not run on its own. Use the `SimGrundy2007` function.
  fn_fit <- SimFN(
    output_type = "grundy2007-fit-dynr",
    output_folder = output_folder,
    suffix = suffix
  )
  fn_boot <- SimFN(
    output_type = "grundy2007-dynr-boot-para",
    output_folder = output_folder,
    suffix = suffix
  )
  fn_output <- SimFN(
    output_type = "grundy2007-dynr-pb-xym",
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
      object = Grundy2007BootParaXYM(
        boot = readRDS(fn_boot),
        phi_hat = PhiHat(readRDS(fn_fit)),
        delta_t = delta_t,
        ncores = NULL
      ),
      file = con
    )
    close(con)
    .SimChMod(fn_output)
  }
}
