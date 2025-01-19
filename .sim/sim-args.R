# SIMULATION ARGUMENTS ---------------------------------------------------------
tasks <- 30L
reps <- 1000L
overwrite <- FALSE
R <- 20000L
delta_t <- 1:30
# ------------------------------------------------------------------------------
output_root <- "/scratch/ibp5092/manCTMed/.sim"
project <- manCTMed::SimProj()
output_folder <- manCTMed:::.SimPath(
  root = output_root,
  project = project
)
# ------------------------------------------------------------------------------
