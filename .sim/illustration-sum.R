#!/usr/bin/env Rscript

# SIMULATION ARGUMENTS ---------------------------------------------------------
suppressMessages(
  suppressWarnings(
    library(manCTMed)
  )
)
source(
  file.path(
    "/scratch",
    Sys.getenv("USER"),
    "manCTMed",
    ".sim",
    "illustration-sim-args.R"
  )
)
# ------------------------------------------------------------------------------

# RUN --------------------------------------------------------------------------
args <- commandArgs(trailingOnly = TRUE)
taskid <- as.integer(args[1])
tryCatch(
  {
    SumIllustration(
      taskid = taskid,
      reps = reps,
      output_folder = output_folder,
      overwrite = overwrite,
      integrity = TRUE # FALSE to prioritize speed, TRUE to prioritize output
    )
  },
  error = function(e) {
    cat(
      paste(
        "check",
        "taskid:",
        taskid,
        "repid:",
        repid,
        "\n"
      )
    )
  },
  warning = function(w) {
    cat(
      paste(
        "check",
        "taskid:",
        taskid,
        "repid:",
        repid,
        "\n"
      )
    )
  }
)
warnings()
# ------------------------------------------------------------------------------
