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
  ci_beta_file <- root$find_file(
    ".setup",
    "data-raw",
    "ci-empirical-beta.Rds"
  )
  fit_empirical_ct_summary <- root$find_file(
    ".setup",
    "data-raw",
    "fit-empirical-ct-summary.Rds"
  )
  empirical_table_coef <- root$find_file(
    ".setup",
    "data-raw",
    "empirical-table-coef.Rds"
  )
  if (
    !all(
      file.exists(
        c(
          med_file,
          ci_file,
          ci_beta_file,
          empirical_table_coef
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
    delta_t <- sort(
      unique(
        c(
          0:15,
          seq(
            from = 0,
            to = 15,
            length.out = 1000
          )
        )
      )
    )
    beta_delta <- summary(
      DeltaBeta(
        phi = phi,
        vcov_phi_vec = vcov_phi_vec,
        delta_t = delta_t,
        ncores = parallel::detectCores()
      )
    )
    beta_mc <- summary(
      MCBeta(
        phi = phi,
        vcov_phi_vec = vcov_phi_vec,
        delta_t = delta_t,
        R = 20000L,
        test_phi = TRUE,
        ncores = parallel::detectCores(),
        seed = 42
      )
    )
    beta <- list(
      delta = beta_delta,
      mc = beta_mc
    )
    med <- Med(
      phi = phi,
      from = "phy",
      to = "est",
      med = "neg",
      delta_t = delta_t
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
      delta_t = delta_t,
      ncores = parallel::detectCores()
    )
    mc <- MCMed(
      phi = phi,
      vcov_phi_vec = vcov_phi_vec,
      from = "phy",
      to = "est",
      med = "neg",
      delta_t = delta_t,
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
    delta <- delta[, c("interval", "est", "se", "ll", "ul", "effect", "method")]
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
    mc <- mc[, c("interval", "est", "se", "ll", "ul", "effect", "method")]
    ci <- rbind(
      delta,
      mc
    )
    saveRDS(
      ci,
      file = ci_file,
      compress = "xz"
    )
    saveRDS(
      beta,
      file = ci_beta_file,
      compress = "xz"
    )
    # Table of coefficients
    fit_summary <- readRDS(fit_empirical_ct_summary)$Coefficients
    phi <- cbind(
      est = fit_summary[varnames, "Estimate"],
      se = fit_summary[varnames, "Std. Error"],
      ll = fit_summary[varnames, "ci.lower"],
      ul = fit_summary[varnames, "ci.upper"]
    )
    beta_delta <- beta_delta[
      which(beta_delta[, "interval"] == 1),
      c("est", "se", "2.5%", "97.5%")
    ]
    colnames(beta_delta) <- paste0(
      "beta_delta_",
      c("est", "se", "ll", "ul")
    )
    beta_mc <- beta_mc[
      which(beta_mc[, "interval"] == 1),
      c("est", "se", "2.5%", "97.5%")
    ]
    colnames(beta_mc) <- paste0(
      "beta_mc_",
      c("est", "se", "ll", "ul")
    )
    coefs <- cbind(
      phi,
      beta_delta,
      beta_mc
    )
    coefs <- data.frame(
      parameters = c(
        "Negative affect to negative affect ($M \\to M$)", # 1 - 5
        "Negative affect to self-esteem ($M \\to Y$)", # 2 - 6
        "Negative affect to physical discomfort ($M \\to X$)", # 3 - 4
        "Self-esteem to negative affect ($Y \\to M$)", # 4 - 8
        "Self-esteem to self-esteem ($Y \\to Y$)", # 5 - 9
        "Self-esteem to physical discomfort ($Y \\to X$)", # 6 - 7
        "Physical discomfort to negative affect ($X \\to M$)", # 7 - 2
        "Physical discomfort to self-esteem ($X \\to Y$)", # 8 - 3
        "Physical discomfort to physical discomfort ($X \\to X$)" # 9 - 1
      ),
      coefs
    )
    coefs <- coefs[c(9, 7, 8, 3, 1, 2, 6, 4, 5), ]
    saveRDS(
      coefs,
      file = empirical_table_coef,
      compress = "xz"
    )
  }
}
data_process_empirical_med()
rm(data_process_empirical_med)
