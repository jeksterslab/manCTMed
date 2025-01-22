#' Simulation Replication - SimGrundy2007
#'
#' @author Ivan Jacob Agaloos Pesigan
#'
#' @return The output is saved as an external file in `output_folder`.
#'
#' @inheritParams Template
#' @export
#' @keywords manCTMed simulation
SimGrundy2007 <- function(taskid,
                          repid,
                          output_folder,
                          overwrite,
                          integrity,
                          delta_t,
                          R,
                          B) {
  # Do not include default arguments here.
  # All arguments should be set in `sim/sim-args.R`.
  # Add taskid to output_folder
  output_folder <- file.path(
    output_folder,
    paste0(
      SimProj(),
      "-",
      "grundy2007",
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
  seed <- .SimSeed(
    taskid = taskid,
    repid = repid
  )
  suffix <- .SimSuffix(
    taskid = taskid,
    repid = repid
  )
  SimGrundy2007GenData(
    taskid = taskid,
    repid = repid,
    output_folder = output_folder,
    seed = seed,
    suffix = suffix,
    overwrite = overwrite,
    integrity = integrity
  )
  SimGrundy2007FitDynr(
    taskid = taskid,
    repid = repid,
    output_folder = output_folder,
    seed = seed,
    suffix = suffix,
    overwrite = overwrite,
    integrity = integrity
  )
  SimGrundy2007DynrDeltaXMY(
    taskid = taskid,
    repid = repid,
    output_folder = output_folder,
    seed = seed,
    suffix = suffix,
    overwrite = overwrite,
    integrity = integrity,
    delta_t = delta_t
  )
  SimGrundy2007DynrDeltaXYM(
    taskid = taskid,
    repid = repid,
    output_folder = output_folder,
    seed = seed,
    suffix = suffix,
    overwrite = overwrite,
    integrity = integrity,
    delta_t = delta_t
  )
  SimGrundy2007DynrDeltaStdXMY(
    taskid = taskid,
    repid = repid,
    output_folder = output_folder,
    seed = seed,
    suffix = suffix,
    overwrite = overwrite,
    integrity = integrity,
    delta_t = delta_t
  )
  SimGrundy2007DynrDeltaStdXYM(
    taskid = taskid,
    repid = repid,
    output_folder = output_folder,
    seed = seed,
    suffix = suffix,
    overwrite = overwrite,
    integrity = integrity,
    delta_t = delta_t
  )
  SimGrundy2007DynrMCXMY(
    taskid = taskid,
    repid = repid,
    output_folder = output_folder,
    seed = seed,
    suffix = suffix,
    overwrite = overwrite,
    integrity = integrity,
    delta_t = delta_t,
    R = R
  )
  SimGrundy2007DynrMCXYM(
    taskid = taskid,
    repid = repid,
    output_folder = output_folder,
    seed = seed,
    suffix = suffix,
    overwrite = overwrite,
    integrity = integrity,
    delta_t = delta_t,
    R = R
  )
  SimGrundy2007DynrMCStdXMY(
    taskid = taskid,
    repid = repid,
    output_folder = output_folder,
    seed = seed,
    suffix = suffix,
    overwrite = overwrite,
    integrity = integrity,
    delta_t = delta_t,
    R = R
  )
  SimGrundy2007DynrMCStdXYM(
    taskid = taskid,
    repid = repid,
    output_folder = output_folder,
    seed = seed,
    suffix = suffix,
    overwrite = overwrite,
    integrity = integrity,
    delta_t = delta_t,
    R = R
  )
  SimGrundy2007BootPara(
    taskid = taskid,
    repid = repid,
    output_folder = output_folder,
    seed = seed,
    suffix = suffix,
    overwrite = overwrite,
    integrity = integrity,
    B = B
  )
  SimGrundy2007BootParaXMY(
    taskid = taskid,
    repid = repid,
    output_folder = output_folder,
    seed = seed,
    suffix = suffix,
    overwrite = overwrite,
    integrity = integrity,
    delta_t = delta_t
  )
  SimGrundy2007BootParaXYM(
    taskid = taskid,
    repid = repid,
    output_folder = output_folder,
    seed = seed,
    suffix = suffix,
    overwrite = overwrite,
    integrity = integrity,
    delta_t = delta_t
  )
  SimGrundy2007BootParaStdXMY(
    taskid = taskid,
    repid = repid,
    output_folder = output_folder,
    seed = seed,
    suffix = suffix,
    overwrite = overwrite,
    integrity = integrity,
    delta_t = delta_t
  )
  SimGrundy2007BootParaStdXYM(
    taskid = taskid,
    repid = repid,
    output_folder = output_folder,
    seed = seed,
    suffix = suffix,
    overwrite = overwrite,
    integrity = integrity,
    delta_t = delta_t
  )
}
