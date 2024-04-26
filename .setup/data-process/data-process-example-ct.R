data_process_example_ct <- function(overwrite = FALSE,
                                    n) {
  # find root directory
  root <- rprojroot::is_rstudio_project
  data_folder <- root$find_file(
    ".setup",
    "data-raw"
  )
  fit_example_ct <- root$find_file(
    ".setup",
    "data-raw",
    paste0(
      "fit-example-ct-",
      n,
      ".Rds"
    )
  )
  if (!dir.exists(data_folder)) {
    dir.create(
      data_folder,
      recursive = TRUE
    )
  }
  if (!file.exists(fit_example_ct)) {
    write <- TRUE
  } else {
    if (overwrite) {
      write <- TRUE
    } else {
      write <- FALSE
    }
  }
  if (write) {
    set.seed(42)
    correlations <- matrix(
      data = c(
        1, 0.88, 0.84, 0.82, -0.23, -0.12, -0.18, -0.24, -0.38, -0.4, -0.3, -0.37, -0.06, -0.2, -0.22, -0.21, 0.03, -0.04, -0.15, -0.13,
        0.88, 1, 0.87, 0.82, -0.19, -0.06, -0.1, -0.23, -0.46, -0.47, -0.34, -0.38, -0.07, -0.23, -0.2, -0.23, -0.01, -0.13, -0.19, -0.18,
        0.84, 0.87, 1, 0.85, -0.17, -0.07, -0.1, -0.23, -0.31, -0.33, -0.29, -0.27, -0.17, -0.17, -0.2, -0.22, -0.07, -0.11, -0.17, -0.17,
        0.82, 0.82, 0.85, 1, -0.17, -0.04, -0.12, -0.24, -0.34, -0.34, -0.32, -0.27, 0.03, -0.08, -0.15, -0.17, 0.06, -0.04, -0.1, -0.08,
        -0.23, -0.19, -0.17, -0.17, 1, 0.6, 0.59, 0.56, 0.01, 0.09, 0.14, 0.15, 0.09, 0.06, 0.03, 0.1, -0.05, -0.06, -0.12, 0.02,
        -0.12, -0.06, -0.07, -0.04, 0.6, 1, 0.62, 0.53, 0.1, 0.15, 0.31, 0.18, 0, 0.09, 0.04, 0.13, -0.04, -0.05, -0.12, 0.03,
        -0.18, -0.1, -0.1, -0.12, 0.59, 0.62, 1, 0.66, 0.01, 0.11, 0.14, 0.08, 0.02, 0.11, 0.05, 0.13, -0.09, -0.12, -0.08, -0.03,
        -0.24, -0.23, -0.23, -0.24, 0.56, 0.53, 0.66, 1, 0.03, 0.13, 0.21, 0.08, -0.03, 0.18, 0.13, 0.35, -0.05, -0.07, 0.05, 0.02,
        -0.38, -0.46, -0.31, -0.34, 0.01, 0.1, 0.01, 0.03, 1, 0.72, 0.55, 0.59, 0.11, 0.32, 0.25, 0.19, 0.26, 0.31, 0.28, 0.29,
        -0.4, -0.47, -0.33, -0.34, 0.09, 0.15, 0.11, 0.13, 0.72, 1, 0.58, 0.61, 0.12, 0.32, 0.26, 0.21, 0.23, 0.37, 0.33, 0.3,
        -0.3, -0.34, -0.29, -0.32, 0.14, 0.31, 0.14, 0.21, 0.55, 0.58, 1, 0.68, 0.12, 0.17, 0.22, 0.18, 0.15, 0.25, 0.23, 0.27,
        -0.37, -0.38, -0.27, -0.27, 0.15, 0.18, 0.08, 0.08, 0.59, 0.61, 0.68, 1, 0.05, 0.18, 0.17, 0.15, 0.21, 0.29, 0.27, 0.38,
        -0.06, -0.07, -0.17, 0.03, 0.09, 0, 0.02, -0.03, 0.11, 0.12, 0.12, 0.05, 1, 0.44, 0.32, 0.2, 0.32, 0.1, 0.2, 0.15,
        -0.2, -0.23, -0.17, -0.08, 0.06, 0.09, 0.11, 0.18, 0.32, 0.32, 0.17, 0.18, 0.44, 1, 0.58, 0.54, 0.3, 0.33, 0.35, 0.21,
        -0.22, -0.2, -0.2, -0.15, 0.03, 0.04, 0.05, 0.13, 0.25, 0.26, 0.22, 0.17, 0.32, 0.58, 1, 0.54, 0.24, 0.37, 0.46, 0.41,
        -0.21, -0.23, -0.22, -0.17, 0.1, 0.13, 0.13, 0.35, 0.19, 0.21, 0.18, 0.15, 0.2, 0.54, 0.54, 1, 0.15, 0.18, 0.36, 0.34,
        0.03, -0.01, -0.07, 0.06, -0.05, -0.04, -0.09, -0.05, 0.26, 0.23, 0.15, 0.21, 0.32, 0.3, 0.24, 0.15, 1, 0.56, 0.4, 0.25,
        -0.04, -0.13, -0.11, -0.04, -0.06, -0.05, -0.12, -0.07, 0.31, 0.37, 0.25, 0.29, 0.1, 0.33, 0.37, 0.18, 0.56, 1, 0.56, 0.38,
        -0.15, -0.19, -0.17, -0.1, -0.12, -0.12, -0.08, 0.05, 0.28, 0.33, 0.23, 0.27, 0.2, 0.35, 0.46, 0.36, 0.4, 0.56, 1, 0.63,
        -0.13, -0.18, -0.17, -0.08, 0.02, 0.03, -0.03, 0.02, 0.29, 0.3, 0.27, 0.38, 0.15, 0.21, 0.41, 0.34, 0.25, 0.38, 0.63, 1
      ),
      nrow = 20
    )
    data <- MASS::mvrnorm(
      n = n,
      mu = rep(
        x = 0,
        times = dim(correlations)[1]
      ),
      Sigma = correlations
    )
    conflict <- t(
      data[, 1:4]
    )
    dim(conflict) <- NULL
    knowledge <- t(
      data[, 13:16]
    )
    dim(knowledge) <- NULL
    competence <- t(
      data[, 17:20]
    )
    dim(competence) <- NULL
    id <- sapply(
      X = 1:n,
      FUN = function(i) {
        rep(x = i, times = 4)
      }
    )
    dim(id) <- NULL
    data <- as.data.frame(
      cbind(
        id = id,
        time = 0:3,
        conflict = conflict,
        knowledge = knowledge,
        competence = competence
      )
    )
    varnames <- c(
      "conflict",
      "knowledge",
      "competence"
    )
    data <- dynUtils::InsertNA(
      data = data,
      id = "id",
      time = "time",
      observed = varnames,
      delta_t = 0.10,
      ncores = parallel::detectCores()
    )
    n_manifest <- 3
    n_latent <- 3
    # starting values
    phi_11 <- 0
    phi_12 <- 0
    phi_13 <- 0
    phi_21 <- 0
    phi_22 <- 0
    phi_23 <- 0
    phi_31 <- 0
    phi_32 <- 0
    phi_33 <- 0
    sigma_11 <- .10
    sigma_12 <- 0
    sigma_13 <- 0
    sigma_22 <- .10
    sigma_23 <- 0
    sigma_33 <- .10
    theta_11 <- .10
    theta_22 <- .10
    theta_33 <- .10
    sigma <- matrix(
      data = c(
        sigma_11, sigma_12, sigma_13,
        sigma_12, sigma_22, sigma_23,
        sigma_13, sigma_23, sigma_33
      ),
      nrow = n_latent
    )
    theta <- diag(
      c(
        theta_11,
        theta_22,
        theta_33
      ),
      nrow = n_latent
    )
    library(dynr)
    dynr_data <- dynr::dynr.data(
      dataframe = data,
      id = "id",
      time = "time",
      observed = varnames
    )
    data_0 <- data[which(data[, "time"] == 0), ]
    dynr_initial <- dynr::prep.initial(
      values.inistate = colMeans(data_0)[varnames],
      params.inistate = rep(x = "fixed", times = n_latent),
      values.inicov = cov(data_0)[varnames, varnames],
      params.inicov = matrix(
        data = "fixed",
        nrow = n_latent,
        ncol = n_latent
      )
    )
    dynr_measurement <- dynr::prep.measurement(
      values.load = diag(n_manifest),
      params.load = matrix(
        data = "fixed",
        nrow = n_manifest,
        ncol = n_manifest
      ),
      state.names = paste0(
        "eta_",
        varnames
      ),
      obs.names = varnames
    )
    dynr_dynamics <- dynr::prep.formulaDynamics(
      formula = list(
        eta_conflict ~ (phi_11 * eta_conflict) + (phi_12 * eta_knowledge) + (phi_13 * eta_competence),
        eta_knowledge ~ (phi_21 * eta_conflict) + (phi_22 * eta_knowledge) + (phi_23 * eta_competence),
        eta_competence ~ (phi_31 * eta_conflict) + (phi_32 * eta_knowledge) + (phi_33 * eta_competence)
      ),
      startval = c(
        phi_11 = phi_11,
        phi_12 = phi_12,
        phi_13 = phi_13,
        phi_21 = phi_21,
        phi_22 = phi_22,
        phi_23 = phi_23,
        phi_31 = phi_31,
        phi_32 = phi_32,
        phi_33 = phi_33
      ),
      isContinuousTime = TRUE
    )
    dynr_noise <- dynr::prep.noise(
      values.latent = sigma,
      params.latent = matrix(
        data = c(
          "sigma_11", "sigma_12", "sigma_13",
          "sigma_12", "sigma_22", "sigma_23",
          "sigma_13", "sigma_23", "sigma_33"
        ),
        nrow = n_latent
      ),
      values.observed = theta,
      params.observed = matrix(
        data = c(
          "theta_11", "fixed", "fixed",
          "fixed", "theta_22", "fixed",
          "fixed", "fixed", "theta_33"
        ),
        nrow = n_manifest,
        ncol = n_manifest
      )
    )
    model <- dynr::dynr.model(
      data = dynr_data,
      initial = dynr_initial,
      measurement = dynr_measurement,
      dynamics = dynr_dynamics,
      noise = dynr_noise,
      outfile = file.path(
        tempdir(),
        "example-ct-dynr.c"
      )
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
    ] <- -10
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
    ] <- 10
    ub[
      c(
        "phi_11",
        "phi_22",
        "phi_33"
      )
    ] <- 0
    lb[
      c(
        "sigma_11",
        "sigma_22",
        "sigma_33"
      )
    ] <- .Machine$double.xmin
    lb[
      c(
        "theta_11",
        "theta_22",
        "theta_33"
      )
    ] <- .Machine$double.xmin
    model$lb <- lb
    model$ub <- ub
    fit <- dynr::dynr.cook(
      model
    )
    saveRDS(
      fit,
      file = fit_example_ct,
      compress = "xz"
    )
  }
}
data_process_example_ct(n = 100)
data_process_example_ct(n = 500)
rm(data_process_example_ct)
