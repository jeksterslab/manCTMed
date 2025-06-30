#' Simulation Replication - Illustration (MCPhiSigma)
#'
#' @details This function is executed via the `IllustrationSim` function.
#'
#' @author Ivan Jacob Agaloos Pesigan
#'
#' @return The output is saved as an external file in `output_folder`.
#'
#' @inheritParams TemplateIllustration
#' @export
#' @keywords manCTMed ci illustration
SimIllustrationDynrMCPhiSigma <- function(taskid,
                                          repid,
                                          output_folder,
                                          seed,
                                          suffix,
                                          overwrite,
                                          integrity,
                                          R) {
  # Do not include default arguments here.
  # Do not run on its own. Use the `IllustrationSim` function.
  fn_input <- SimFN(
    output_type = "illustration-fit-dynr",
    output_folder = output_folder,
    suffix = suffix
  )
  fn_output <- SimFN(
    output_type = "illustration-dynr-mc-phi-sigma",
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
      object = IllustrationMCPhiSigma(
        fit = readRDS(fn_input),
        R = R,
        seed = seed
      ),
      file = con
    )
    close(con)
    .SimChMod(fn_output)
  }
}
