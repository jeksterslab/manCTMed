root <- rprojroot::is_rstudio_project
ns <- c(
  50,
  100,
  150,
  200
)
reps <- 1:1000
wd <- "/scratch/ibp5092/manCTMed/.sim"
raw <- manCTMed::Collate(
  ns = ns,
  reps = reps,
  wd = wd,
  ncores = parallel::detectCores()
)
results <- manCTMed::Summarize(
  x = raw,
  ncores = parallel::detectCores()
)
saveRDS(
  object = do.call(
    what = "rbind",
    args = raw
  ),
  file = root$find_file(
    ".setup",
    "data-raw",
    "results-raw.Rds"
  ),
  compress = "xz"
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
save(
  object = results,
  file = root$find_file(
    "data",
    "results.rda"
  ),
  compress = "xz"
)
