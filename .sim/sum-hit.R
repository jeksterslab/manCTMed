#!/usr/bin/env Rscript

# SIMULATION ARGUMENTS ---------------------------------------------------------
suppressMessages(
  suppressWarnings(
    library(manCTMed)
  )
)
source(
  file.path(
    "/scratch/ibp5092/manCTMed/.sim/",
    "sim-args.R"
  )
)
# ------------------------------------------------------------------------------

# RUN --------------------------------------------------------------------------
sum_hit <- lapply(
  X = seq_len(tasks),
  FUN = function(taskid,
                 reps,
                 output_folder,
                 ncores) {
    return(
      do.call(
        what = "rbind",
        args = lapply(
          X = c(
            "dynr-delta-xmy",
            "dynr-delta-ymx",
            "dynr-mc-xmy",
            "dynr-mc-ymx",
            "dynr-delta-std-xmy",
            "dynr-delta-std-ymx",
            "dynr-mc-std-xmy",
            "dynr-mc-std-ymx"
          ),
          FUN = function(output_type,
                         taskid,
                         reps,
                         output_folder,
                         ncores) {
            SumHit(
              taskid = taskid,
              reps = reps,
              output_folder = output_folder,
              output_type = output_type,
              ncores = ncores
            )
          },
          taskid = taskid,
          reps = reps,
          output_folder = output_folder,
          ncores = ncores
        )
      )
    )
  },
  reps = reps,
  output_folder = output_folder,
  ncores = parallel::detectCores()
)
sum_hit <- do.call(
  what = "rbind",
  args = sum_hit
)
sum_hit$effect <- c(
  "total",
  "direct",
  "indirect"
)
saveRDS(
  sum_hit,
  file = file.path(
    output_folder,
    paste0(
      "sum-hit-",
      manCTMed:::.SimSuffix(
        taskid = tasks,
        repid = reps
      )
    )
  ),
  compress = "xz"
)
