root <- rprojroot::is_rstudio_project
n <- c(
  50,
  100,
  150,
  200
)
reps <- 1:1000
wd <- "/scratch/ibp5092/manCTMed/.sim"
results <- lapply(
  X = n,
  FUN = manCTMed::Summarize,
  reps = reps,
  wd = wd,
  ncores = parallel::detectCores()
)
results <- do.call(
  what = "rbind",
  args = results
)
saveRDS(
  object = results,
  file = root$find_file(
    ".setup",
    "data-raw",
    "results.Rds"
  ),
  compress = "xz"
)
