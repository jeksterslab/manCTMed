#' Simulation Replication Parametric Bootstrap (Parallel)
#'
#' @author Ivan Jacob Agaloos Pesigan
#'
#' @return The output is saved as an external file in `output_folder`.
#'
#' @inheritParams Template
#' @export
#' @keywords manCTMed simulation
SimPara <- function(taskid,
                    repid,
                    output_folder,
                    overwrite,
                    integrity,
                    seed,
                    B) {
  # Do not include default arguments here.
  # All arguments should be set in `.sim/sim-args.R`.
  # Add taskid to output_folder
  output_folder <- file.path(
    output_folder,
    paste0(
      SimProj(),
      "-",
      sprintf(
        "%05d",
        taskid
      )
    )
  )
  if (!file.exists(output_folder)) {
    dir.create(
      path = output_folder,
      showWarnings = FALSE,
      recursive = TRUE
    )
    .SimChMod(output_folder)
  }
  if (is.null(seed)) {
    seed <- .SimSeed(
      taskid = taskid,
      repid = repid
    )
  }
  suffix <- .SimSuffix(
    taskid = taskid,
    repid = repid
  )
  SimDynrBootPara(
    taskid = taskid,
    repid = repid,
    output_folder = output_folder,
    seed = seed,
    suffix = suffix,
    overwrite = overwrite,
    integrity = integrity,
    B = B,
    ncores = parallel::detectCores()
  )
}
