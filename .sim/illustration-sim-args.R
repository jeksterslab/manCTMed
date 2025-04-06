# SIMULATION ARGUMENTS ---------------------------------------------------------
tasks <- 1L
reps <- 200L
overwrite <- FALSE
R <- 20000L
B <- 1000L
delta_t <- 1:30
seed <- NULL
ci <- TRUE
pb <- TRUE
# ------------------------------------------------------------------------------
output_root <- file.path(
  "/scratch",
  Sys.getenv("USER"),
  "manCTMed",
  ".sim"
)
project <- paste0(
  manCTMed::SimProj(),
  "-",
  "illustration"
)
output_folder <- manCTMed:::.SimPath(
  root = output_root,
  project = project
)
# ------------------------------------------------------------------------------
