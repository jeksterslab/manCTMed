#' Simulation Replication - DynrMCStdYMX
#'
#' @details This function is executed via the `Sim` function.
#'
#' @author Ivan Jacob Agaloos Pesigan
#'
#' @return The output is saved as an external file in `output_folder`.
#'
#' @inheritParams Template
#' @export
#' @keywords manCTMed ci simulation
SimDynrMCStdYMX <- function(taskid,
                            repid,
                            output_folder,
                            seed,
                            suffix,
                            overwrite,
                            integrity,
                            delta_t,
                            R) {
  # Do not include default arguments here.
  # Do not run on its own. Use the `Sim` function.
  fn_input <- SimFN(
    output_type = "fit-dynr",
    output_folder = output_folder,
    suffix = suffix
  )
  fn_output <- SimFN(
    output_type = "dynr-mc-std-ymx",
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
      object = MCStdYMX(
        theta_hat = ThetaHat(
          fit = readRDS(fn_input)
        ),
        delta_t = delta_t,
        R = R,
        seed = seed
      ),
      file = con
    )
    close(con)
    .SimChMod(fn_output)
  }
}
