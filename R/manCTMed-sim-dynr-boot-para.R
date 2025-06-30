#' Simulation Replication - BootPara
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
SimDynrBootPara <- function(taskid,
                            repid,
                            output_folder,
                            seed,
                            suffix,
                            overwrite,
                            integrity,
                            B,
                            ncores = NULL) {
  # Do not include default arguments here.
  # Do not run on its own. Use the `Sim` function.
  fn_input <- SimFN(
    output_type = "fit-dynr",
    output_folder = output_folder,
    suffix = suffix
  )
  fn_output <- SimFN(
    output_type = "dynr-boot-para",
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
    path <- file.path(
      output_folder,
      paste0(
        SimProj(),
        "-",
        "pb",
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
    )
    if (!file.exists(path)) {
      dir.create(
        path = path,
        showWarnings = FALSE,
        recursive = TRUE
      )
      .SimChMod(path)
    }
    saveRDS(
      object = BootPara(
        fit = readRDS(fn_input),
        path = path,
        prefix = paste0(
          SimProj(),
          "-",
          "pb",
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
        ),
        taskid = taskid,
        B = B,
        ncores = ncores,
        seed = seed
      ),
      file = con
    )
    close(con)
    .SimChMod(fn_output)
    unlink(
      path,
      recursive = TRUE
    )
  }
}
