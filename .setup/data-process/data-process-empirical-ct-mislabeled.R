data_process_empirical_ct_mislabeled <- function(overwrite = FALSE) {
  cat("\ndata_process_empirical_ct_mislabeled\n")
  set.seed(42)
  # find root directory
  root <- rprojroot::is_rstudio_project
  data_folder <- root$find_file(
    "data"
  )
  data_empirical_ct_mislabeled <- root$find_file(
    ".setup",
    "data-raw",
    "ESMdata.csv"
  )
  fit_empirical_ct_mislabeled <- root$find_file(
    ".setup",
    "data-raw",
    "fit-empirical-ct-mislabeled.Rds"
  )
  fit_empirical_ct_mislabeled_summary <- root$find_file(
    ".setup",
    "data-raw",
    "fit-empirical-ct-mislabeled-summary.Rds"
  )
  if (!dir.exists(data_folder)) {
    dir.create(
      data_folder,
      recursive = TRUE
    )
  }
  if (
    !all(
      file.exists(
        c(
          fit_empirical_ct_mislabeled,
          fit_empirical_ct_mislabeled_summary
        )
      )
    )
  ) {
    write <- TRUE
  } else {
    if (overwrite) {
      write <- TRUE
    } else {
      write <- FALSE
    }
  }
  if (write) {
    rawdata <- read.csv(
      data_empirical_ct_mislabeled,
      header = TRUE,
      stringsAsFactors = FALSE
    )
    # reverse
    rawdata$pat_concent <- 8 - rawdata$pat_concent
    rawdata$se_ashamed <- 8 - rawdata$se_ashamed
    rawdata$se_selfdoub <- 8 - rawdata$se_selfdoub
    # extract time variable
    t1 <- as.POSIXct(
      paste(
        rawdata$date,
        rawdata$resptime_s
      ),
      format = "%d/%m/%y %H:%M:%S"
    )
    time <- as.numeric(
      difftime(
        t1,
        t1[1],
        units = "hours"
      )
    )
    # select variables
    neg <- c(
      "pat_restl",
      "pat_agitate",
      "pat_worry",
      "pat_concent"
    )
    est <- c(
      "se_selflike",
      "se_ashamed",
      "se_selfdoub",
      "se_handle"
    )
    phy <- c(
      "phy_hungry",
      "phy_tired",
      "phy_pain",
      "phy_dizzy",
      "phy_drymouth",
      "phy_nauseous",
      "phy_headache",
      "phy_sleepy"
    )
    data_esm <- data.frame(
      neg = rowMeans(
        rawdata[, neg]
      ),
      est = rowMeans(
        rawdata[, est]
      ),
      phy = rowMeans(
        rawdata[, phy]
      )
    )
    # scale
    data_esm <- apply(
      X = data_esm,
      MARGIN = 2,
      FUN = scale
    )
    # create ID variable
    id <- rep(
      x = 1,
      times = dim(data_esm)[1]
    )
    # create long form dataset for ctsem
    data <- data.frame(
      id = id,
      time = time,
      data_esm
    )
    data$time <- 0:(length(time) - 1)
    data <- dynUtils::InsertNA(
      data = data,
      id = "id",
      time = "time",
      observed = c(
        "neg",
        "est",
        "phy"
      ),
      delta_t = .10,
      ncores = parallel::detectCores()
    )
    manifest_names <- c(
      "neg",
      "est",
      "phy"
    )
    latent_names <- paste0(
      "eta_",
      manifest_names
    )
    n_manifest <- length(manifest_names)
    n_latent <- length(latent_names)
    library(dynr)
    dynr_data <- dynr::dynr.data(
      dataframe = data,
      id = "id",
      time = "time",
      observed = manifest_names
    )
    dynr_initial <- dynr::prep.initial(
      values.inistate = rep(x = 0, times = n_latent),
      params.inistate = rep(x = "fixed", times = n_latent),
      values.inicov = diag(n_latent),
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
      state.names = paste0("eta_", manifest_names),
      obs.names = manifest_names
    )
    dynr_dynamics <- dynr::prep.formulaDynamics(
      formula = list(
        eta_neg ~ (phi_11 * eta_neg) + (phi_12 * eta_est) + (phi_13 * eta_phy),
        eta_est ~ (phi_21 * eta_neg) + (phi_22 * eta_est) + (phi_23 * eta_phy),
        eta_phy ~ (phi_31 * eta_neg) + (phi_32 * eta_est) + (phi_33 * eta_phy)
      ),
      startval = c(
        phi_11 = 0,
        phi_12 = 0,
        phi_13 = 0,
        phi_21 = 0,
        phi_22 = 0,
        phi_23 = 0,
        phi_31 = 0,
        phi_32 = 0,
        phi_33 = 0
      ),
      isContinuousTime = TRUE
    )
    dynr_noise <- dynr::prep.noise(
      values.latent = diag(n_latent),
      params.latent = matrix(
        data = c(
          "sigma_11", "sigma_12", "sigma_13",
          "sigma_12", "sigma_22", "sigma_23",
          "sigma_13", "sigma_23", "sigma_33"
        ),
        nrow = n_latent
      ),
      values.observed = matrix(
        0,
        nrow = n_manifest,
        ncol = n_manifest
      ),
      params.observed = matrix(
        data = "fixed",
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
        "empirical-ct-dynr.c"
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
    lb[
      c(
        "sigma_11",
        "sigma_22",
        "sigma_33"
      )
    ] <- .Machine$double.xmin
    model$lb <- lb
    model$ub <- ub
    fit <- dynr::dynr.cook(
      model,
      verbose = FALSE
    )
    print(summary(fit))
    coef(model) <- coef(fit)
    fit <- dynr::dynr.cook(
      model,
      verbose = FALSE
    )
    print(summary(fit))
    saveRDS(
      fit,
      file = fit_empirical_ct_mislabeled,
      compress = "xz"
    )
    saveRDS(
      summary(fit),
      file = fit_empirical_ct_mislabeled_summary,
      compress = "xz"
    )
  }
}
data_process_empirical_ct_mislabeled()
rm(data_process_empirical_ct_mislabeled)
