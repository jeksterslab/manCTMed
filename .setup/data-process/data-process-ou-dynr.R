data_process_ou_dynr <- function(overwrite = FALSE) {
  # find root directory
  root <- rprojroot::is_rstudio_project
  deboeck2015_na_rds <- root$find_file(
    ".setup",
    "data-raw",
    "deboeck2015_na.Rds"
  )
  deboeck2015_ou_dynr_rds <- root$find_file(
    ".setup",
    "data-raw",
    "deboeck2015_ou_dynr.Rds"
  )
  if (file.exists(deboeck2015_ou_dynr_rds)) {
    run <- FALSE
    if (overwrite) {
      run <- TRUE
    }
  } else {
    run <- TRUE
  }
  if (!file.exists(deboeck2015_na_rds)) {
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
    dir.create(
      root$find_file(
        "data"
      ),
      showWarnings = FALSE,
      recursive = TRUE
    )
    source(
      root$find_file(
        ".setup",
        "data-process",
        "data-process-deboeck2015.R"
      )
    )
    data <- readRDS(deboeck2015_na_rds)
    library(dynr)
    dynr_data <- dynr.data(
      dataframe = data,
      id = "id",
      time = "time",
      observed = c("x", "m", "y")
    )
    dynr_initial <- prep.initial(
      values.inistate = rep(x = 0, times = 3),
      params.inistate = c("mu0_1", "mu0_2", "mu0_3"),
      values.inicov = diag(3),
      params.inicov = matrix(
        data = c(
          "sigma0_11", "sigma0_12", "sigma0_13",
          "sigma0_12", "sigma0_22", "sigma0_23",
          "sigma0_13", "sigma0_23", "sigma0_33"
        ),
        nrow = 3
      )
    )
    dynr_measurement <- prep.measurement(
      values.load = diag(3),
      params.load = matrix(data = "fixed", nrow = 3, ncol = 3),
      state.names = c("eta_x", "eta_m", "eta_y"),
      obs.names = c("x", "m", "y")
    )
    dynr_dynamics <- prep.formulaDynamics(
      formula = list(
        eta_x ~ phi_11 * eta_x + phi_12 * eta_m + phi_13 * eta_y,
        eta_m ~ phi_21 * eta_x + phi_22 * eta_m + phi_23 * eta_y,
        eta_y ~ phi_31 * eta_x + phi_32 * eta_m + phi_33 * eta_y
      ),
      startval = c(
        phi_11 = -0.357, phi_12 = 0, phi_13 = 0,
        phi_21 = 0.771, phi_22 = -0.511, phi_23 = 0,
        phi_31 = -0.450, phi_32 = 0.729, phi_33 = -0.693
      ),
      isContinuousTime = TRUE
    )
    dynr_noise <- prep.noise(
      values.latent = 0.01 * diag(3),
      params.latent = matrix(
        data = c(
          "sigma_11", "sigma_12", "sigma_13",
          "sigma_12", "sigma_22", "sigma_23",
          "sigma_13", "sigma_23", "sigma_33"
        ),
        nrow = 3
      ),
      values.observed = matrix(data = 0, nrow = 3, ncol = 3),
      params.observed = matrix(data = "fixed", nrow = 3, ncol = 3)
    )
    model <- dynr.model(
      data = dynr_data,
      initial = dynr_initial,
      measurement = dynr_measurement,
      dynamics = dynr_dynamics,
      noise = dynr_noise,
      outfile = file.path(tempdir(), "ou.c")
    )
    model@options$maxeval <- 100000
    lb <- ub <- rep(NA, times = length(model$xstart))
    names(ub) <- names(lb) <- names(model$xstart)
    lb[
      c(
        "phi_11",
        "phi_21",
        "phi_31",
        "phi_12",
        "phi_22",
        "phi_32",
        "phi_13",
        "phi_23",
        "phi_33"
      )
    ] <- -1.5
    ub[
      c(
        "phi_11",
        "phi_21",
        "phi_31",
        "phi_12",
        "phi_22",
        "phi_32",
        "phi_13",
        "phi_23",
        "phi_33"
      )
    ] <- 1.5
    model$lb <- lb
    model$ub <- ub
    fit <- dynr.cook(
      model,
      debug_flag = TRUE,
      verbose = FALSE
    )
    saveRDS(
      fit,
      file = deboeck2015_ou_dynr_rds,
      compress = "xz"
    )
  }
}
data_process_ou_dynr()
rm(data_process_ou_dynr)
