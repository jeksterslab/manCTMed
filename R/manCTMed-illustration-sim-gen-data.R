#' Simulation Replication - IllustrationGenData
#'
#' @details This function is executed via the `IllustrationSim` function.
#'
#' @author Ivan Jacob Agaloos Pesigan
#'
#' @return The output is saved as an external file in `output_folder`.
#'
#' @inheritParams TemplateIllustration
#' @export
#' @keywords manCTMed gendata illustration
SimIllustrationGenData <- function(taskid,
                                   repid,
                                   output_folder,
                                   seed,
                                   suffix,
                                   overwrite,
                                   integrity) {
  # Do not include default arguments here.
  # Do not run on its own. Use the `IllustrationSim` function.
  fn_output <- SimFN(
    output_type = "illustration-data",
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
    n <- 133
    m <- 101
    if (taskid == 1) {
      delta_t_gen <- 0.10
    } else {
      delta_t_gen <- 10
    }
    saveRDS(
      object = IllustrationGenData(
        seed = seed,
        n = n,
        m = m,
        delta_t_gen = delta_t_gen
      ),
      file = con
    )
    close(con)
    .SimChMod(fn_output)
  }
}
