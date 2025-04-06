#' Compress Replication (Illustration)
#'
#' @author Ivan Jacob Agaloos Pesigan
#'
#' @return The output is saved as an external file in `output_folder`.
#'
#' @inheritParams TemplateIllustration
#' @export
#' @family Compression Functions
#' @keywords manCTMed compress
IllustrationCompress <- function(taskid,
                                 repid,
                                 output_folder) {
  # For speed, the sim* functions do not compress the output files.
  # Compression can be done in the archiving stage to save on disk space.
  # `manCTMed::Compress()` uses `xz`
  # with compression `9` for maximum compression.
  TestXZ <- function(x) {
    f <- file(x)
    ext <- summary(f)$class
    close.connection(f)
    ext == "xzfile"
  }
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
  stopifnot(
    dir.exists(
      output_folder
    )
  )
  rds_files <- list.files(
    path = output_folder,
    pattern = utils::glob2rx(
      paste0(
        "*",
        "-",
        .SimSuffix(
          taskid = taskid,
          repid = repid
        )
      )
    ),
    full.names = TRUE
  )
  stopifnot(
    length(rds_files) > 0
  )
  invisible(
    lapply(
      X = rds_files,
      FUN = function(rds_file) {
        if (!TestXZ(rds_file)) {
          con <- xzfile(
            description = rds_file,
            compression = 9L
          )
          saveRDS(
            object = readRDS(rds_file),
            file = con
          )
          close(con)
        }
      }
    )
  )
}
