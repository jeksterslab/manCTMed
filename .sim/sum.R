root <- rprojroot::is_rstudio_project
ns <- c(
  50,
  100,
  150,
  200
)
reps <- 1:1000
wd <- "/scratch/ibp5092/manCTMed/.sim"
results <- manCTMed::Collate(
  ns = ns,
  reps = reps,
  wd = wd,
  ncores = parallel::detectCores()
)
results <- manCTMed::Summarize(
  x = results,
  ncores = parallel::detectCores()
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
