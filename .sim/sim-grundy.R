#!/usr/bin/env Rscript

# SIMULATION ARGUMENTS ---------------------------------------------------------
suppressMessages(
  suppressWarnings(
    library(manCTMed)
  )
)
source(
  paste0(
    "/scratch/ibp5092/manCTMed/.sim/",
    "sim-grundy-args.R"
  )
)
# ------------------------------------------------------------------------------

# RUN --------------------------------------------------------------------------
args <- commandArgs(trailingOnly = TRUE)
repid <- as.integer(args[1])
taskid <- as.integer(args[2])
tryCatch(
  {
    SimGrundy2007(
      taskid = taskid,
      repid = repid,
      output_folder = output_folder,
      overwrite = overwrite,
      integrity = TRUE, # FALSE to prioritize speed, TRUE to prioritize output
      R = R,
      B = B,
      delta_t = delta_t,
      fit_dynr = TRUE
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
