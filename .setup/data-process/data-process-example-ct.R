data_process_example_ct <- function(overwrite = FALSE,
                                    n) {
  cat("\ndata_process_example_ct\n")
  set.seed(42)
  # find root directory
  root <- rprojroot::is_rstudio_project
  data_folder <- root$find_file(
    ".setup",
    "data-raw"
  )
  source(
    root$find_file(
      ".setup",
      "data-process",
      "data-process-example-data.R"
    )
  )
  if (!dir.exists(data_folder)) {
    dir.create(
      data_folder,
      recursive = TRUE
    )
  }
  fit_example_ct <- root$find_file(
    ".setup",
    "data-raw",
    paste0(
      "fit-example-ct-",
      n,
      ".Rds"
    )
  )
  fit_example_ct_summary <- root$find_file(
    ".setup",
    "data-raw",
    paste0(
      "fit-example-ct-summary-",
      n,
      ".Rds"
    )
  )
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
    varnames <- c(
      "conflict",
      "knowledge",
      "competence"
    )
    grundy2007_file <- root$find_file(
      "data",
      "grundy2007.rda"
    )
    load(grundy2007_file)
    data <- grundy2007
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
        paste0(
          "example-ct-dynr-",
          n,
          ".c"
        )
      )
    )
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
      model,
      verbose = FALSE
    )
    # print(summary(fit))
    # coef(model) <- coef(fit)
    # fit <- dynr::dynr.cook(
    #   model,
    #   verbose = FALSE
    # )
    # print(summary(fit))
    saveRDS(
      fit,
      file = fit_example_ct,
      compress = "xz"
    )
    saveRDS(
      summary(fit),
      file = fit_example_ct_summary,
      compress = "xz"
    )
  }
}
data_process_example_ct(n = 133)
rm(data_process_example_ct)
