# SIMULATION ARGUMENTS ---------------------------------------------------------
tasks <- 1L
reps <- 1000L
overwrite <- FALSE
R <- 20000L
B <- 1000L
delta_t <- 1:30
# ------------------------------------------------------------------------------
output_root <- "/scratch/ibp5092/manCTMed/.sim"
project <- paste0(
  manCTMed::SimProj(),
  "-",
  "grundy2007"
)
output_folder <- manCTMed:::.SimPath(
  root = output_root,
  project = project
)
# ------------------------------------------------------------------------------
