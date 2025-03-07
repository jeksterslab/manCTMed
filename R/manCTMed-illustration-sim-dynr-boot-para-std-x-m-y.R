#' Simulation Replication - BootParaStdXMY
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
SimIllustrationDynrBootParaStdXMY <- function(taskid,
                                              repid,
                                              output_folder,
                                              seed,
                                              suffix,
                                              overwrite,
                                              integrity,
                                              delta_t) {
  # Do not include default arguments here.
  # Do not run on its own. Use the `IllustrationSim` function.
  fn_fit <- SimFN(
    output_type = "illustration-fit-dynr",
    output_folder = output_folder,
    suffix = suffix
  )
  fn_input <- SimFN(
    output_type = "illustration-dynr-boot-para",
    output_folder = output_folder,
    suffix = suffix
  )
  fn_output <- SimFN(
    output_type = "illustration-dynr-boot-para-std-xmy",
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
      object = BootParaStdXMY(
        boot = readRDS(fn_input),
        theta_hat = ThetaHat(
          fit = readRDS(fn_fit)
        ),
        delta_t = delta_t,
        ncores = NULL
      ),
      file = con
    )
    close(con)
    .SimChMod(fn_output)
  }
}
