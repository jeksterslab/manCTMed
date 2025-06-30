#' Simulation Replication - IllustrationFitMx
#'
#' @details This function is executed via the `IllustrationSim` function.
#'
#' @author Ivan Jacob Agaloos Pesigan
#'
#' @return The output is saved as an external file in `output_folder`.
#'
#' @inheritParams TemplateIllustration
#' @export
#' @keywords manCTMed fit illustration
SimIllustrationFitMx <- function(taskid,
                                 repid,
                                 output_folder,
                                 seed,
                                 suffix,
                                 overwrite,
                                 integrity) {
  # Do not include default arguments here.
  # Do not run on its own. Use the `IllustrationSim` function.
  fn_input <- SimFN(
    output_type = "illustration-data",
    output_folder = output_folder,
    suffix = suffix
  )
  fn_output <- SimFN(
    output_type = "illustration-fit-mx",
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
      object = IllustrationFitMx(
        data = IllustrationPrepData(
          sim = readRDS(fn_input)
        )
      ),
      file = con
    )
    close(con)
    .SimChMod(fn_output)
  }
}
