data_process_empirical_dt <- function(overwrite = FALSE) {
  cat("\ndata_process_empirical_dt\n")
  set.seed(42)
  # find root directory
  root <- rprojroot::is_rstudio_project
  data_folder <- root$find_file(
    "data"
  )
  data_empirical_dt <- root$find_file(
    ".setup",
    "data-raw",
    "ESMdata.csv"
  )
  fit_empirical_dt <- root$find_file(
    ".setup",
    "data-raw",
    "fit-empirical-dt.Rds"
  )
  fit_empirical_dt_summary <- root$find_file(
    ".setup",
    "data-raw",
    "fit-empirical-dt-summary.Rds"
  )
  if (!dir.exists(data_folder)) {
    dir.create(
      data_folder,
      recursive = TRUE
    )
  }
  if (!file.exists(fit_empirical_dt)) {
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
      data_empirical_dt,
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
    # mislabeled time intervals
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
        eta_neg ~ (beta_11 * eta_neg) + (beta_12 * eta_est) + (beta_13 * eta_phy),
        eta_est ~ (beta_21 * eta_neg) + (beta_22 * eta_est) + (beta_23 * eta_phy),
        eta_phy ~ (beta_31 * eta_neg) + (beta_32 * eta_est) + (beta_33 * eta_phy)
      ),
      startval = c(
        beta_11 = 0,
        beta_12 = 0,
        beta_13 = 0,
        beta_21 = 0,
        beta_22 = 0,
        beta_23 = 0,
        beta_31 = 0,
        beta_32 = 0,
        beta_33 = 0
      ),
      isContinuousTime = FALSE
    )
    dynr_noise <- dynr::prep.noise(
      values.latent = diag(n_latent),
      params.latent = matrix(
        data = c(
          "psi_11", "psi_12", "psi_13",
          "psi_12", "psi_22", "psi_23",
          "psi_13", "psi_23", "psi_33"
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
        "empirical-dt-dynr.c"
      )
    )
    model@options$maxeval <- 100000
    lb <- ub <- rep(NA, times = length(model$xstart))
    names(ub) <- names(lb) <- names(model$xstart)
    lb[
      c(
        "beta_11",
        "beta_21",
        "beta_31",
        "beta_12",
        "beta_22",
        "beta_32",
        "beta_13",
        "beta_23",
        "beta_33"
      )
    ] <- -10
    ub[
      c(
        "beta_11",
        "beta_21",
        "beta_31",
        "beta_12",
        "beta_22",
        "beta_32",
        "beta_13",
        "beta_23",
        "beta_33"
      )
    ] <- 10
    lb[
      c(
        "psi_11",
        "psi_22",
        "psi_33"
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
      file = fit_empirical_dt,
      compress = "xz"
    )
    saveRDS(
      summary(fit),
      file = fit_empirical_dt_summary,
      compress = "xz"
    )
  }
}
data_process_empirical_dt()
rm(data_process_empirical_dt)
