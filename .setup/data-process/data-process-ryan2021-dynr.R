data_process_ryan2021_dynr <- function(overwrite = FALSE) {
  # find root directory
  root <- rprojroot::is_rstudio_project
  ryan2021_phi_rds <- root$find_file(
    ".setup",
    "data-raw",
    "ryan2021phi.Rds"
  )
  ryan2021_phi_rda <- root$find_file(
    ".setup",
    "data-raw",
    "ryan2021phi.rda"
  )
  ryan2021_rds <- root$find_file(
    ".setup",
    "data-raw",
    "ryan2021.Rds"
  )
  ryan2021_ou_dynr_rds <- root$find_file(
    ".setup",
    "data-raw",
    "ryan2021_ou_dynr.Rds"
  )
  if (file.exists(ryan2021_ou_dynr_rds)) {
    run <- FALSE
    if (overwrite) {
      run <- TRUE
    }
  } else {
    run <- TRUE
  }
  if (run) {
    data <- readRDS(ryan2021_rds)
    data <- dynUtils::InsertNA(
      data = data,
      id = "id",
      time = "time",
      observed = c("s", "f", "i", "r"),
      delta_t = 0.10,
      ncores = parallel::detectCores()
    )
    dynr_data <- dynr::dynr.data(
      dataframe = data,
      id = "id",
      time = "time",
      observed = c("s", "f", "i", "r")
    )
    dynr_initial <- dynr::prep.initial(
      values.inistate = rep(x = 0, times = 4),
      params.inistate = c("mu0_1", "mu0_2", "mu0_3", "mu0_4"),
      values.inicov = diag(4),
      params.inicov = matrix(
        data = c(
          "sigma0_11", "sigma0_12", "sigma0_13", "sigma0_14",
          "sigma0_12", "sigma0_22", "sigma0_23", "sigma0_24",
          "sigma0_13", "sigma0_23", "sigma0_33", "sigma0_34",
          "sigma0_14", "sigma0_24", "sigma0_34", "sigma0_44"
        ),
        nrow = 4
      )
    )
    dynr_measurement <- dynr::prep.measurement(
      values.load = diag(4),
      params.load = matrix(data = "fixed", nrow = 4, ncol = 4),
      state.names = c("eta_s", "eta_f", "eta_i", "eta_r"),
      obs.names = c("s", "f", "i", "r")
    )
    dynr_dynamics <- dynr::prep.formulaDynamics(
      formula = list(
        eta_s ~ phi_11 * eta_s + phi_12 * eta_f + phi_13 * eta_i + phi_14 * eta_r,
        eta_f ~ phi_21 * eta_s + phi_22 * eta_f + phi_23 * eta_i + phi_24 * eta_r,
        eta_i ~ phi_31 * eta_s + phi_32 * eta_f + phi_33 * eta_i + phi_34 * eta_r,
        eta_r ~ phi_41 * eta_s + phi_42 * eta_f + phi_43 * eta_i + phi_44 * eta_r
      ),
      startval = c(
        phi_11 = 0, phi_12 = 0, phi_13 = 0, phi_14 = 0,
        phi_21 = 0, phi_22 = 0, phi_23 = 0, phi_24 = 0,
        phi_31 = 0, phi_32 = 0, phi_33 = 0, phi_34 = 0,
        phi_41 = 0, phi_42 = 0, phi_43 = 0, phi_44 = 0
      ),
      isContinuousTime = TRUE
    )
    dynr_noise <- dynr::prep.noise(
      values.latent = 0.01 * diag(4),
      params.latent = matrix(
        data = c(
          "sigma_11", "sigma_12", "sigma_13", "sigma_14",
          "sigma_12", "sigma_22", "sigma_23", "sigma_24",
          "sigma_13", "sigma_23", "sigma_33", "sigma_34",
          "sigma_14", "sigma_24", "sigma_34", "sigma_44"
        ),
        nrow = 4
      ),
      values.observed = 0.01 * diag(4),
      params.observed = matrix(
        data = c(
          "theta_11", "fixed", "fixed", "fixed",
          "fixed", "theta_22", "fixed", "fixed",
          "fixed", "fixed", "theta_33", "fixed",
          "fixed", "fixed", "fixed", "theta_44"
        ),
        nrow = 4
      )
    )
    model <- dynr::dynr.model(
      data = dynr_data,
      initial = dynr_initial,
      measurement = dynr_measurement,
      dynamics = dynr_dynamics,
      noise = dynr_noise,
      outfile = file.path(tempdir(), "ryan2021.c")
    )
    fit <- dynr::dynr.cook(
      model,
      debug_flag = TRUE,
      verbose = FALSE
    )
    parnames <- c(
      "phi_11",
      "phi_21",
      "phi_31",
      "phi_41",
      "phi_12",
      "phi_22",
      "phi_32",
      "phi_42",
      "phi_13",
      "phi_23",
      "phi_33",
      "phi_43",
      "phi_14",
      "phi_24",
      "phi_34",
      "phi_44"
    )
    phi_vec <- coef(fit)[parnames]
    phi <- matrix(
      data = phi_vec,
      nrow = 3
    )
    colnames(phi) <- rownames(phi) <- c("s", "f", "i", "r")
    vcov_phi_vec <- vcov(fit)[parnames, parnames]
    dynr <- list(
      phi = phi,
      vcov = vcov_phi_vec
    )
    saveRDS(
      fit,
      file = ryan2021_ou_dynr_rds,
      compress = "xz"
    )
    saveRDS(
      ryan2015phi,
      file = ryan2021_phi_rds,
      compress = "xz"
    )
    save(
      ryan2021phi,
      file = ryan2021_phi_rda,
      compress = "xz"
    )
  }
}
data_process_ryan2021_dynr()
rm(data_process_ryan2021_dynr)
