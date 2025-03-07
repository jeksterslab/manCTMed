#' Simulation Replication (Illustration)
#'
#' @author Ivan Jacob Agaloos Pesigan
#'
#' @return The output is saved as an external file in `output_folder`.
#'
#' @inheritParams TemplateIllustration
#' @export
#' @keywords manCTMed illustration
SimIllustration <- function(taskid,
                            repid,
                            output_folder,
                            overwrite,
                            integrity,
                            seed,
                            ci,
                            pb,
                            delta_t,
                            R,
                            B) {
  # Do not include default arguments here.
  # All arguments should be set in `.sim/illustration-sim-args.R.R`.
  # Add taskid to output_folder
  output_folder <- file.path(
    output_folder,
    paste0(
      SimProj(),
      "-",
      "illustration",
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
  SimIllustrationGenData(
    taskid = taskid,
    repid = repid,
    output_folder = output_folder,
    seed = seed,
    suffix = suffix,
    overwrite = overwrite,
    integrity = integrity
  )
  SimIllustrationFitDynr(
    taskid = taskid,
    repid = repid,
    output_folder = output_folder,
    seed = seed,
    suffix = suffix,
    overwrite = overwrite,
    integrity = integrity
  )
  if (ci) {
    SimIllustrationDynrDeltaXMY(
      taskid = taskid,
      repid = repid,
      output_folder = output_folder,
      seed = seed,
      suffix = suffix,
      overwrite = overwrite,
      integrity = integrity,
      delta_t = delta_t
    )
    SimIllustrationDynrMCXMY(
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
    SimIllustrationDynrDeltaStdXMY(
      taskid = taskid,
      repid = repid,
      output_folder = output_folder,
      seed = seed,
      suffix = suffix,
      overwrite = overwrite,
      integrity = integrity,
      delta_t = delta_t
    )
    SimIllustrationDynrMCStdXMY(
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
    if (pb) {
      SimIllustrationDynrBootPara(
        taskid = taskid,
        repid = repid,
        output_folder = output_folder,
        seed = seed,
        suffix = suffix,
        overwrite = overwrite,
        integrity = integrity,
        B = B
      )
      SimIllustrationDynrBootParaXMY(
        taskid = taskid,
        repid = repid,
        output_folder = output_folder,
        seed = seed,
        suffix = suffix,
        overwrite = overwrite,
        integrity = integrity,
        delta_t = delta_t
      )
      SimIllustrationDynrBootParaStdXMY(
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
  }
}
