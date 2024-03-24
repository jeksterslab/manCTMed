#!/usr/bin/env Rscript

# ------------------------------------------------------------------------------
# REPLICATION ARGUMENTS --------------------------------------------------------
# ------------------------------------------------------------------------------

args <- commandArgs(trailingOnly = TRUE)
repid <- as.integer(args[1])
n <- as.integer(args[2])
wd <- "/scratch/ibp5092/manCTMed/.sim"
delta_t <- c(5, 10, 15, 20)
R <- 20000L

# ------------------------------------------------------------------------------
# RUN --------------------------------------------------------------------------
# ------------------------------------------------------------------------------
suppressMessages(
  suppressWarnings(
    library(manCTMed)
  )
)

tryCatch(
  {
    Replication(
      repid = repid,
      n = n,
      wd = wd,
      delta_t = delta_t,
      R = R
    )
  },
  error = function(e) {
    cat(
      paste(
        "check",
        "n:",
        n,
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
        "n:",
        n,
        "repid:",
        repid,
        "\n"
      )
    )
  }
)
warnings()
# ------------------------------------------------------------------------------
