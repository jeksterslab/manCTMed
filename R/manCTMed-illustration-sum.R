#' Summary (Illustration)
#'
#' @author Ivan Jacob Agaloos Pesigan
#'
#' @return The output is saved as an external file in `output_folder`.
#'
#' @inheritParams TemplateIllustration
#' @export
#' @keywords manCTMed summary illustration
SumIllustration <- function(taskid,
                            reps,
                            output_folder,
                            overwrite,
                            integrity) {
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
  SumIllustrationFitDynr(
    taskid = taskid,
    reps = reps,
    output_folder = output_folder,
    overwrite = overwrite,
    integrity = integrity
  )
  SumIllustrationDynrDeltaXMY(
    taskid = taskid,
    reps = reps,
    output_folder = output_folder,
    overwrite = overwrite,
    integrity = integrity
  )
  SumIllustrationDynrDeltaStdXMY(
    taskid = taskid,
    reps = reps,
    output_folder = output_folder,
    overwrite = overwrite,
    integrity = integrity
  )
  SumIllustrationDynrMCXMY(
    taskid = taskid,
    reps = reps,
    output_folder = output_folder,
    overwrite = overwrite,
    integrity = integrity
  )
  SumIllustrationDynrMCStdXMY(
    taskid = taskid,
    reps = reps,
    output_folder = output_folder,
    overwrite = overwrite,
    integrity = integrity
  )
  SumIllustrationDynrBootParaXMY(
    taskid = taskid,
    reps = reps,
    output_folder = output_folder,
    overwrite = overwrite,
    integrity = integrity,
    type = "bc"
  )
  SumIllustrationDynrBootParaXMY(
    taskid = taskid,
    reps = reps,
    output_folder = output_folder,
    overwrite = overwrite,
    integrity = integrity,
    type = "pc"
  )
  SumIllustrationDynrBootParaStdXMY(
    taskid = taskid,
    reps = reps,
    output_folder = output_folder,
    overwrite = overwrite,
    integrity = integrity,
    type = "bc"
  )
  SumIllustrationDynrBootParaStdXMY(
    taskid = taskid,
    reps = reps,
    output_folder = output_folder,
    overwrite = overwrite,
    integrity = integrity,
    type = "pc"
  )
}
