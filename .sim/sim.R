#!/usr/bin/env Rscript

args <- commandArgs(trailingOnly = TRUE)
i <- as.integer(args[1])
n <- as.integer(args[2])

suppressMessages(
  suppressWarnings(
    manCTMed::Replication(i = i, n = n)
  )
)
