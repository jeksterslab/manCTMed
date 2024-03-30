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
sum_raw <- lapply(
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
            "dynr-mc-ymx"
          ),
          FUN = function(output_type,
                         taskid,
                         reps,
                         output_folder,
                         ncores) {
            SumRaw(
              taskid = taskid,
              reps = reps,
              output_folder = output_folder,
              output_type = output_type,
              params_taskid = params[which(params$taskid == taskid), ],
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
sum_raw <- do.call(
  what = "rbind",
  args = sum_raw
)
saveRDS(
  sum_raw,
  file = file.path(
    output_folder,
    paste0(
      "sum-raw-",
      manCTMed:::.SimSuffix(
        taskid = tasks,
        repid = reps
      )
    )
  ),
  compress = "xz"
)
