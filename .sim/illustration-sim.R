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
repid <- as.integer(args[1])
taskid <- as.integer(args[2])
tryCatch(
  {
    SimIllustration(
      taskid = taskid,
      repid = repid,
      output_folder = output_folder,
      overwrite = overwrite,
      integrity = TRUE, # FALSE to prioritize speed, TRUE to prioritize output
      seed = seed,
      ci = ci,
      pb = pb,
      delta_t = delta_t,
      R = R,
      B = B
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
