data_process_empirical <- function(overwrite = FALSE) {
  # find root directory
  root <- rprojroot::is_rstudio_project
  empirical_effects_phy_aff_cog_rds <- root$find_file(
    ".setup",
    "data-raw",
    "empirical-effects-phy-aff-cog.Rds"
  )
  empirical_delta_phy_aff_cog_rds <- root$find_file(
    ".setup",
    "data-raw",
    "empirical-delta-phy-aff-cog.Rds"
  )
  empirical_mc_phy_aff_cog_rds <- root$find_file(
    ".setup",
    "data-raw",
    "empirical-mc-phy-aff-cog.Rds"
  )
  empirical_effects_cog_aff_phy_rds <- root$find_file(
    ".setup",
    "data-raw",
    "empirical-effects-cog-aff-phy.Rds"
  )
  empirical_delta_cog_aff_phy_rds <- root$find_file(
    ".setup",
    "data-raw",
    "empirical-delta-cog-aff-phy.Rds"
  )
  empirical_mc_cog_aff_phy_rds <- root$find_file(
    ".setup",
    "data-raw",
    "empirical-mc-cog-aff-phy.Rds"
  )
  if (
    all(
      file.exists(
        c(
          empirical_effects_phy_aff_cog_rds,
          empirical_delta_phy_aff_cog_rds,
          empirical_mc_phy_aff_cog_rds,
          empirical_effects_cog_aff_phy_rds,
          empirical_delta_cog_aff_phy_rds,
          empirical_mc_cog_aff_phy_rds
        )
      )
    )
  ) {
    run <- FALSE
    if (overwrite) {
      run <- TRUE
    }
  } else {
    run <- TRUE
  }
  if (run) {
    dir.create(
      root$find_file(
        ".setup",
        "data-raw"
      ),
      showWarnings = FALSE,
      recursive = TRUE
    )
    load(
      root$find_file(
        "data",
        "ryan2021phi.rda"
      )
    )
    phi <- ryan2021phi$phi
    vcov_phi_vec <- ryan2021phi$vcov
    from <- "f" # fatigue
    to <- "s" # self-doubt
    med <- c("i", "r") # irritable and restless
    delta_t <- seq(from = 0, to = 15, length.out = 500)

    effects_1 <- Med(
      phi = phi,
      from = from,
      to = to,
      med = med,
      delta_t = delta_t
    )

    saveRDS(effects_1, file = empirical_effects_phy_aff_cog_rds, compress = "xz")

    delta_1 <- DeltaMed(
      phi = phi,
      vcov_phi_vec = vcov_phi_vec,
      from = from,
      to = to,
      med = med,
      delta_t = delta_t,
      ncores = parallel::detectCores()
    )

    saveRDS(delta_1, file = empirical_delta_phy_aff_cog_rds, compress = "xz")

    mc_1 <- MCMed(
      phi = phi,
      vcov_phi_vec = vcov_phi_vec,
      from = from,
      to = to,
      med = med,
      delta_t = delta_t,
      R = 5000L,
      seed = 42,
      ncores = parallel::detectCores()
    )

    saveRDS(mc_1, file = empirical_mc_phy_aff_cog_rds, compress = "xz")

    from <- "s" # self-doubt
    to <- "f" # fatigue

    effects_2 <- Med(
      phi = phi,
      from = from,
      to = to,
      med = med,
      delta_t = delta_t
    )

    saveRDS(effects_2, file = empirical_effects_cog_aff_phy_rds, compress = "xz")

    delta_2 <- DeltaMed(
      phi = phi,
      vcov_phi_vec = vcov_phi_vec,
      from = from,
      to = to,
      med = med,
      delta_t = delta_t,
      ncores = parallel::detectCores()
    )

    saveRDS(delta_2, file = empirical_delta_cog_aff_phy_rds, compress = "xz")

    mc_2 <- MCMed(
      phi = phi,
      vcov_phi_vec = vcov_phi_vec,
      from = from,
      to = to,
      med = med,
      delta_t = delta_t,
      R = 5000L,
      seed = 42,
      ncores = parallel::detectCores()
    )

    saveRDS(mc_2, file = empirical_mc_cog_aff_phy_rds, compress = "xz")
  }
}
data_process_empirical()
rm(data_process_empirical)
