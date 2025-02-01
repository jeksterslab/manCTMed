#' Simulation Replication - Grundy2007BootPara
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
SimGrundy2007BootPara <- function(taskid,
                                  repid,
                                  output_folder,
                                  seed,
                                  suffix,
                                  overwrite,
                                  integrity,
                                  B) {
  # Do not include default arguments here.
  # Do not run on its own. Use the `SimGrundy2007` function.
  fn_data <- SimFN(
    output_type = "grundy2007-data",
    output_folder = output_folder,
    suffix = suffix
  )
  fn_fit <- SimFN(
    output_type = "grundy2007-fit-dynr",
    output_folder = output_folder,
    suffix = suffix
  )
  fn_output <- SimFN(
    output_type = "grundy2007-dynr-boot-para",
    output_folder = output_folder,
    suffix = suffix
  )
  prefix <- paste0(
    "grundy2007_dynr_boot_para_rep",
    "-",
    sprintf(
      "%05d",
      taskid
    ),
    "-",
    sprintf(
      "%05d",
      repid
    )
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
      object = Grundy2007BootPara(
        fit = readRDS(fn_fit),
        data = readRDS(fn_data),
        path = output_folder,
        prefix = prefix,
        B = B,
        ncores = NULL,
        seed = seed
      ),
      file = con
    )
    close(con)
    .SimChMod(fn_output)
  }
}
