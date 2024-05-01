data_process_empirical_med <- function(overwrite = FALSE) {
  cat("\ndata_process_empirical_med\n")
  set.seed(42)
  # find root directory
  root <- rprojroot::is_rstudio_project
  data_folder <- root$find_file(
    "data"
  )
  source(
    root$find_file(
      ".setup",
      "data-process",
      "data-process-empirical-ct.R"
    )
  )
  fit_empirical <- root$find_file(
    ".setup",
    "data-raw",
    "fit-empirical-ct.Rds"
  )
  if (!dir.exists(data_folder)) {
    dir.create(
      data_folder,
      recursive = TRUE
    )
  }
  med_file <- root$find_file(
    ".setup",
    "data-raw",
    "med-empirical.Rds"
  )
  ci_file <- root$find_file(
    ".setup",
    "data-raw",
    "ci-empirical.Rds"
  )
  if (
    !all(
      file.exists(
        c(
          med_file,
          ci_file
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
    library(dynr)
    fit <- readRDS(
      file = fit_empirical
    )
    varnames <- c(
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
    phi <- matrix(
      data = coef(fit)[varnames],
      nrow = 3
    )
    colnames(phi) <- rownames(phi) <- c(
      "neg",
      "est",
      "phy"
    )
    vcov_phi_vec <- vcov(fit)[varnames, varnames]
    library(cTMed)
    med <- Med(
      phi = phi,
      from = "phy",
      to = "est",
      med = "neg",
      delta_t = seq(from = 0, to = 15, length.out = 1000)
    )
    saveRDS(
      med,
      file = med_file,
      compress = "xz"
    )
    delta <- DeltaMed(
      phi = phi,
      vcov_phi_vec = vcov_phi_vec,
      from = "phy",
      to = "est",
      med = "neg",
      delta_t = seq(from = 0, to = 15, length.out = 1000),
      ncores = parallel::detectCores()
    )
    mc <- MCMed(
      phi = phi,
      vcov_phi_vec = vcov_phi_vec,
      from = "phy",
      to = "est",
      med = "neg",
      delta_t = seq(from = 0, to = 15, length.out = 1000),
      ncores = parallel::detectCores(),
      R = 20000L,
      seed = 42
    )
    delta <- cTMed:::.DeltaCI(
      object = delta,
      alpha = 0.05
    )
    delta <- do.call(
      what = "rbind",
      args = delta
    )
    colnames(delta) <- c(
      "interval",
      "est",
      "se",
      "z",
      "p",
      "ll",
      "ul"
    )
    effect <- rownames(delta)
    delta <- as.data.frame(
      delta
    )
    delta$effect <- effect
    rownames(delta) <- NULL
    delta$method <- "delta"
    delta <- delta[, c("interval", "est", "ll", "ul", "effect", "method")]
    mc <- cTMed:::.MCCI(
      object = mc,
      alpha = 0.05
    )
    mc <- do.call(
      what = "rbind",
      args = mc
    )
    colnames(mc) <- c(
      "interval",
      "est",
      "se",
      "R",
      "ll",
      "ul"
    )
    effect <- rownames(mc)
    mc <- as.data.frame(
      mc
    )
    mc$effect <- effect
    rownames(mc) <- NULL
    mc$method <- "mc"
    mc <- mc[, c("interval", "est", "ll", "ul", "effect", "method")]
    ci <- rbind(
      delta,
      mc
    )
    saveRDS(
      ci,
      file = ci_file,
      compress = "xz"
    )
  }
}
data_process_empirical_med()
rm(data_process_empirical_med)
