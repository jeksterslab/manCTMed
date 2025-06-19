data_process_example_med_std <- function(overwrite = FALSE,
                                         n) {
  cat("\ndata_process_example_med_std\n")
  set.seed(42)
  # find root directory
  root <- rprojroot::is_rstudio_project
  data_folder <- root$find_file(
    ".setup",
    "data-raw"
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
    "manCTMed-illustration-fit-dynr-00001-00001.Rds"
  )
  med_xmy_file <- root$find_file(
    ".setup",
    "data-raw",
    paste0(
      "med-example-std-xmy-",
      n,
      ".Rds"
    )
  )
  med_xym_file <- root$find_file(
    ".setup",
    "data-raw",
    paste0(
      "med-example-std-xym-",
      n,
      ".Rds"
    )
  )
  delta_xmy_file <- root$find_file(
    ".setup",
    "data-raw",
    paste0(
      "delta-example-std-xmy-",
      n,
      ".Rds"
    )
  )
  mc_xmy_file <- root$find_file(
    ".setup",
    "data-raw",
    paste0(
      "mc-example-std-xmy-",
      n,
      ".Rds"
    )
  )
  pb_pc_xmy_file <- root$find_file(
    ".setup",
    "data-raw",
    paste0(
      "pb-pc-example-std-xmy-",
      n,
      ".Rds"
    )
  )
  pb_bc_xmy_file <- root$find_file(
    ".setup",
    "data-raw",
    paste0(
      "pb-bc-example-std-xmy-",
      n,
      ".Rds"
    )
  )
  delta_xym_file <- root$find_file(
    ".setup",
    "data-raw",
    paste0(
      "delta-example-std-xym-",
      n,
      ".Rds"
    )
  )
  mc_xym_file <- root$find_file(
    ".setup",
    "data-raw",
    paste0(
      "mc-example-std-xym-",
      n,
      ".Rds"
    )
  )
  pb_pc_xym_file <- root$find_file(
    ".setup",
    "data-raw",
    paste0(
      "pb-pc-example-std-xym-",
      n,
      ".Rds"
    )
  )
  pb_bc_xym_file <- root$find_file(
    ".setup",
    "data-raw",
    paste0(
      "pb-bc-example-std-xym-",
      n,
      ".Rds"
    )
  )
  ci_file <- root$find_file(
    ".setup",
    "data-raw",
    paste0(
      "ci-example-std-",
      n,
      ".Rds"
    )
  )
  ci_beta_file <- root$find_file(
    ".setup",
    "data-raw",
    paste0(
      "ci-example-std-",
      n,
      "-beta",
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
  example_table_coef <- root$find_file(
    ".setup",
    "data-raw",
    paste0(
      "example-std-table-coef-",
      n,
      ".Rds"
    )
  )
  example_table_ci <- root$find_file(
    ".setup",
    "data-raw",
    paste0(
      "example-std-table-ci-",
      n,
      ".Rds"
    )
  )
  if (
    !all(
      file.exists(
        c(
          med_xmy_file,
          med_xym_file,
          delta_xmy_file,
          mc_xmy_file,
          pb_pc_xmy_file,
          pb_bc_xmy_file,
          delta_xym_file,
          mc_xym_file,
          pb_pc_xym_file,
          pb_bc_xym_file,
          ci_file,
          ci_beta_file,
          example_table_coef,
          example_table_ci,
          fit_example_ct_summary
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
    library(cTMed)
    library(simStateSpace)
    library(bootStateSpace)
    fit <- readRDS(
      root$find_file(
        ".setup",
        "data-raw",
        "manCTMed-illustration-fit-dynr-00001-00001.Rds"
      )
    )
    saveRDS(
      summary(fit),
      file = fit_example_ct_summary,
      compress = "xz"
    )
    coefs <- coef(fit)
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
      data = coefs[varnames],
      nrow = 3,
      ncol = 3
    )
    colnames(phi) <- rownames(phi) <- c(
      "conflict",
      "knowledge",
      "competence"
    )
    vcov_phi_vec <- vcov(fit)[varnames, varnames]
    varnames <- c(
      "sigma_11",
      "sigma_12",
      "sigma_13",
      "sigma_12",
      "sigma_22",
      "sigma_23",
      "sigma_13",
      "sigma_23",
      "sigma_33"
    )
    sigma <- matrix(
      data = coefs[varnames],
      nrow = 3,
      ncol = 3
    )
    varnames <- c(
      "theta_11",
      "theta_22",
      "theta_33"
    )
    theta <- diag(3)
    diag(theta) <- coefs[varnames]
    sigma0 <- simStateSpace::LinSDECov(
      phi = phi,
      sigma = sigma
    )
    sigma0 <- (sigma0 + t(sigma0)) / 2
    varnames <- c(
      "phi_11",
      "phi_21",
      "phi_31",
      "phi_12",
      "phi_22",
      "phi_32",
      "phi_13",
      "phi_23",
      "phi_33",
      "sigma_11",
      "sigma_12",
      "sigma_13",
      "sigma_22",
      "sigma_23",
      "sigma_33"
    )
    vcov_theta <- vcov(fit)[varnames, varnames]
    delta_t <- sort(
      unique(
        c(
          0:10,
          seq(
            from = 0,
            to = 10,
            length.out = 1000
          )
        )
      )
    )
    beta_delta <- summary(
      DeltaBetaStd(
        phi = phi,
        sigma = sigma,
        vcov_theta = vcov_theta,
        delta_t = delta_t,
        ncores = parallel::detectCores()
      )
    )
    beta_mc <- summary(
      MCBetaStd(
        phi = phi,
        sigma = sigma,
        vcov_theta = vcov_theta,
        delta_t = delta_t,
        R = 20000L,
        test_phi = TRUE,
        ncores = parallel::detectCores(),
        seed = 42
      )
    )
    pb <- readRDS(
      root$find_file(
        ".setup",
        "data-raw",
        "manCTMed-illustration-dynr-boot-para-00001-00001.Rds"
      )
    )
    beta_pb <- BootBetaStd(
      phi = extract(object = pb, what = "phi"),
      sigma = extract(object = pb, what = "sigma"),
      phi_hat = phi,
      sigma_hat = sigma,
      delta_t = delta_t,
      ncores = parallel::detectCores()
    )
    beta_pb_pc <- summary(
      beta_pb,
      type = "pc"
    )
    beta_pb_bc <- summary(
      beta_pb,
      type = "bc"
    )
    beta <- list(
      delta = beta_delta,
      mc = beta_mc,
      pb_pc = beta_pb_pc,
      pb_bc = beta_pb_bc
    )
    med_xmy <- MedStd(
      phi = phi,
      sigma = sigma,
      from = "conflict",
      to = "competence",
      med = "knowledge",
      delta_t = delta_t
    )
    saveRDS(
      med_xmy,
      file = med_xmy_file,
      compress = "xz"
    )
    med_xym <- MedStd(
      phi = phi,
      sigma = sigma,
      from = "conflict",
      to = "knowledge",
      med = "competence",
      delta_t = delta_t
    )
    saveRDS(
      med_xym,
      file = med_xym_file,
      compress = "xz"
    )
    delta_xmy <- summary(
      DeltaMedStd(
        phi = phi,
        sigma = sigma,
        vcov_theta = vcov_theta,
        from = "conflict",
        to = "competence",
        med = "knowledge",
        delta_t = 0:4,
        ncores = parallel::detectCores()
      )
    )
    saveRDS(
      delta_xmy,
      file = delta_xmy_file,
      compress = "xz"
    )
    mc_xmy <- summary(
      MCMedStd(
        phi = phi,
        sigma = sigma,
        vcov_theta = vcov_theta,
        from = "conflict",
        to = "competence",
        med = "knowledge",
        delta_t = 0:4,
        ncores = parallel::detectCores(),
        R = 20000L,
        seed = 42
      )
    )
    saveRDS(
      mc_xmy,
      file = mc_xmy_file,
      compress = "xz"
    )
    pb_xmy <- BootMedStd(
      phi = extract(object = pb, what = "phi"),
      sigma = extract(object = pb, what = "sigma"),
      phi_hat = phi,
      sigma_hat = sigma,
      delta_t = 0:4,
      from = "conflict",
      to = "competence",
      med = "knowledge",
      ncores = parallel::detectCores()
    )
    pb_pc_xmy <- summary(pb_xmy, type = "pc")
    pb_bc_xmy <- summary(pb_xmy, type = "bc")
    saveRDS(
      pb_pc_xmy,
      file = pb_pc_xmy_file,
      compress = "xz"
    )
    saveRDS(
      pb_bc_xmy,
      file = pb_bc_xmy_file,
      compress = "xz"
    )
    delta_xym <- summary(
      DeltaMedStd(
        phi = phi,
        sigma = sigma,
        vcov_theta = vcov_theta,
        from = "conflict",
        to = "knowledge",
        med = "competence",
        delta_t = 0:4,
        ncores = parallel::detectCores()
      )
    )
    saveRDS(
      delta_xym,
      file = delta_xym_file,
      compress = "xz"
    )
    mc_xym <- summary(
      MCMedStd(
        phi = phi,
        sigma = sigma,
        vcov_theta = vcov_theta,
        from = "conflict",
        to = "knowledge",
        med = "competence",
        delta_t = 0:4,
        ncores = parallel::detectCores(),
        R = 20000L,
        seed = 42
      )
    )
    saveRDS(
      mc_xym,
      file = mc_xym_file,
      compress = "xz"
    )
    pb_xym <- BootMedStd(
      phi = extract(object = pb, what = "phi"),
      sigma = extract(object = pb, what = "sigma"),
      phi_hat = phi,
      sigma_hat = sigma,
      delta_t = 0:4,
      from = "conflict",
      to = "knowledge",
      med = "competence",
      ncores = parallel::detectCores()
    )
    pb_pc_xym <- summary(pb_xym, type = "pc")
    pb_bc_xym <- summary(pb_xym, type = "bc")
    saveRDS(
      pb_pc_xym,
      file = pb_pc_xym_file,
      compress = "xz"
    )
    saveRDS(
      pb_bc_xym,
      file = pb_bc_xym_file,
      compress = "xz"
    )
    delta_xmy <- DeltaMedStd(
      phi = phi,
      sigma = sigma,
      vcov_theta = vcov_theta,
      from = "conflict",
      to = "competence",
      med = "knowledge",
      delta_t = delta_t,
      ncores = parallel::detectCores()
    )
    delta_xym <- DeltaMedStd(
      phi = phi,
      sigma = sigma,
      vcov_theta = vcov_theta,
      from = "conflict",
      to = "knowledge",
      med = "competence",
      delta_t = delta_t,
      ncores = parallel::detectCores()
    )
    mc_xmy <- MCMedStd(
      phi = phi,
      sigma = sigma,
      vcov_theta = vcov_theta,
      from = "conflict",
      to = "competence",
      med = "knowledge",
      delta_t = delta_t,
      ncores = parallel::detectCores(),
      R = 20000L,
      seed = 42
    )
    mc_xym <- MCMedStd(
      phi = phi,
      sigma = sigma,
      vcov_theta = vcov_theta,
      from = "conflict",
      to = "knowledge",
      med = "competence",
      delta_t = delta_t,
      ncores = parallel::detectCores(),
      R = 20000L,
      seed = 42
    )
    pb_xmy <- BootMedStd(
      phi = extract(object = pb, what = "phi"),
      sigma = extract(object = pb, what = "sigma"),
      phi_hat = phi,
      sigma_hat = sigma,
      delta_t = delta_t,
      from = "conflict",
      to = "competence",
      med = "knowledge",
      ncores = parallel::detectCores()
    )
    pb_xym <- BootMedStd(
      phi = extract(object = pb, what = "phi"),
      sigma = extract(object = pb, what = "sigma"),
      phi_hat = phi,
      sigma_hat = sigma,
      delta_t = delta_t,
      from = "conflict",
      to = "knowledge",
      med = "competence",
      ncores = parallel::detectCores()
    )
    delta_xmy <- cTMed:::.DeltaCI(
      object = delta_xmy,
      alpha = 0.05
    )
    delta_xmy <- do.call(
      what = "rbind",
      args = delta_xmy
    )
    colnames(delta_xmy) <- c(
      "interval",
      "est",
      "se",
      "z",
      "p",
      "ll",
      "ul"
    )
    effect <- rownames(delta_xmy)
    delta_xmy <- as.data.frame(
      delta_xmy
    )
    delta_xmy$effect <- effect
    rownames(delta_xmy) <- NULL
    delta_xmy$method <- "delta"
    delta_xmy$n <- n
    delta_xmy$model <- "xmy"
    delta_xmy <- delta_xmy[, c("interval", "est", "se", "ll", "ul", "effect", "method", "n", "model")]
    delta_xym <- cTMed:::.DeltaCI(
      object = delta_xym,
      alpha = 0.05
    )
    delta_xym <- do.call(
      what = "rbind",
      args = delta_xym
    )
    colnames(delta_xym) <- c(
      "interval",
      "est",
      "se",
      "z",
      "p",
      "ll",
      "ul"
    )
    effect <- rownames(delta_xym)
    delta_xym <- as.data.frame(
      delta_xym
    )
    delta_xym$effect <- effect
    rownames(delta_xym) <- NULL
    delta_xym$method <- "delta"
    delta_xym$n <- n
    delta_xym$model <- "xym"
    delta_xym <- delta_xym[, c("interval", "est", "se", "ll", "ul", "effect", "method", "n", "model")]
    delta <- rbind(
      delta_xmy,
      delta_xym
    )
    mc_xmy <- cTMed:::.MCCI(
      object = mc_xmy,
      alpha = 0.05
    )
    mc_xmy <- do.call(
      what = "rbind",
      args = mc_xmy
    )
    colnames(mc_xmy) <- c(
      "interval",
      "est",
      "se",
      "R",
      "ll",
      "ul"
    )
    effect <- rownames(mc_xmy)
    mc_xmy <- as.data.frame(
      mc_xmy
    )
    mc_xmy$effect <- effect
    rownames(mc_xmy) <- NULL
    mc_xmy$method <- "mc"
    mc_xmy$n <- n
    mc_xmy$model <- "xmy"
    mc_xmy <- mc_xmy[, c("interval", "est", "se", "ll", "ul", "effect", "method", "n", "model")]
    mc_xym <- cTMed:::.MCCI(
      object = mc_xym,
      alpha = 0.05
    )
    mc_xym <- do.call(
      what = "rbind",
      args = mc_xym
    )
    colnames(mc_xym) <- c(
      "interval",
      "est",
      "se",
      "R",
      "ll",
      "ul"
    )
    effect <- rownames(mc_xym)
    mc_xym <- as.data.frame(
      mc_xym
    )
    mc_xym$effect <- effect
    rownames(mc_xym) <- NULL
    mc_xym$method <- "mc"
    mc_xym$n <- n
    mc_xym$model <- "xym"
    mc_xym <- mc_xym[, c("interval", "est", "se", "ll", "ul", "effect", "method", "n", "model")]
    mc <- rbind(
      mc_xmy,
      mc_xym
    )
    pb_pc_xmy <- cTMed:::.BootCI(
      object = pb_xmy,
      alpha = 0.05,
      type = "pc"
    )
    pb_pc_xmy <- do.call(
      what = "rbind",
      args = pb_pc_xmy
    )
    colnames(pb_pc_xmy) <- c(
      "interval",
      "est",
      "se",
      "R",
      "ll",
      "ul"
    )
    effect <- rownames(pb_pc_xmy)
    pb_pc_xmy <- as.data.frame(
      pb_pc_xmy
    )
    pb_pc_xmy$effect <- effect
    rownames(pb_pc_xmy) <- NULL
    pb_pc_xmy$method <- "pb_pc"
    pb_pc_xmy$n <- n
    pb_pc_xmy$model <- "xmy"
    pb_pc_xmy <- pb_pc_xmy[, c("interval", "est", "se", "ll", "ul", "effect", "method", "n", "model")]
    pb_pc_xym <- cTMed:::.BootCI(
      object = pb_xym,
      alpha = 0.05,
      type = "pc"
    )
    pb_pc_xym <- do.call(
      what = "rbind",
      args = pb_pc_xym
    )
    colnames(pb_pc_xym) <- c(
      "interval",
      "est",
      "se",
      "R",
      "ll",
      "ul"
    )
    effect <- rownames(pb_pc_xym)
    pb_pc_xym <- as.data.frame(
      pb_pc_xym
    )
    pb_pc_xym$effect <- effect
    rownames(pb_pc_xym) <- NULL
    pb_pc_xym$method <- "pb_pc"
    pb_pc_xym$n <- n
    pb_pc_xym$model <- "xym"
    pb_pc_xym <- pb_pc_xym[, c("interval", "est", "se", "ll", "ul", "effect", "method", "n", "model")]
    pb_pc <- rbind(
      pb_pc_xmy,
      pb_pc_xym
    )
    pb_bc_xmy <- cTMed:::.BootCI(
      object = pb_xmy,
      alpha = 0.05,
      type = "bc"
    )
    pb_bc_xmy <- do.call(
      what = "rbind",
      args = pb_bc_xmy
    )
    colnames(pb_bc_xmy) <- c(
      "interval",
      "est",
      "se",
      "R",
      "ll",
      "ul"
    )
    effect <- rownames(pb_bc_xmy)
    pb_bc_xmy <- as.data.frame(
      pb_bc_xmy
    )
    pb_bc_xmy$effect <- effect
    rownames(pb_bc_xmy) <- NULL
    pb_bc_xmy$method <- "pb_bc"
    pb_bc_xmy$n <- n
    pb_bc_xmy$model <- "xmy"
    pb_bc_xmy <- pb_bc_xmy[, c("interval", "est", "se", "ll", "ul", "effect", "method", "n", "model")]
    pb_bc_xym <- cTMed:::.BootCI(
      object = pb_xym,
      alpha = 0.05,
      type = "bc"
    )
    pb_bc_xym <- do.call(
      what = "rbind",
      args = pb_bc_xym
    )
    colnames(pb_bc_xym) <- c(
      "interval",
      "est",
      "se",
      "R",
      "ll",
      "ul"
    )
    effect <- rownames(pb_bc_xym)
    pb_bc_xym <- as.data.frame(
      pb_bc_xym
    )
    pb_bc_xym$effect <- effect
    rownames(pb_bc_xym) <- NULL
    pb_bc_xym$method <- "pb_bc"
    pb_bc_xym$n <- n
    pb_bc_xym$model <- "xym"
    pb_bc_xym <- pb_bc_xym[, c("interval", "est", "se", "ll", "ul", "effect", "method", "n", "model")]
    pb_bc <- rbind(
      pb_bc_xmy,
      pb_bc_xym
    )
    ci <- rbind(
      delta,
      mc,
      pb_pc,
      pb_bc
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
    fit_summary <- readRDS(fit_example_ct_summary)$Coefficients
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
    beta_pb_pc <- beta_pb_pc[
      which(beta_pb_pc[, "interval"] == 1),
      c("est", "se", "2.5%", "97.5%")
    ]
    colnames(beta_pb_pc) <- paste0(
      "beta_pb_pc_",
      c("est", "se", "ll", "ul")
    )
    beta_pb_bc <- beta_pb_bc[
      which(beta_pb_bc[, "interval"] == 1),
      c("est", "se", "2.5%", "97.5%")
    ]
    colnames(beta_pb_bc) <- paste0(
      "beta_pb_bc_",
      c("est", "se", "ll", "ul")
    )
    coefs <- cbind(
      phi,
      beta_delta,
      beta_mc,
      beta_pb_pc,
      beta_pb_bc
    )
    coefs <- data.frame(
      parameters = c(
        "Conflict to conflict ($X \\to X$)",
        "Conflict to knowledge ($X \\to M$)",
        "Conflict to competence ($X \\to Y$)",
        "Knowledge to conflict ($M \\to X$)",
        "Knowledge to knowledge ($M \\to M$)",
        "Knowledge to competence ($M \\to Y$)",
        "Competence to conflict ($Y \\to X$)",
        "Competence to knowledge ($Y \\to M$)",
        "Competence to competence ($Y \\to Y$)"
      ),
      coefs
    )
    saveRDS(
      coefs,
      file = example_table_coef,
      compress = "xz"
    )
    # Table of confidence intervals for direct, indirect, and total effects
    # delta_t of 1, 2, and 3
    foo <- function(interval) {
      mc <- mc_xmy[
        which(mc_xmy[, "interval"] == interval),
        c("effect", "est", "se", "ll", "ul")
      ]
      rownames(mc) <- gsub(
        pattern = "(^[[:alpha:]])",
        replacement = "\\U\\1",
        x = mc[, "effect"],
        perl = TRUE
      )
      mc <- mc[
        c("Direct", "Indirect", "Total"),
        c("est", "se", "ll", "ul")
      ]
      mc <- data.frame(
        effect = c("Direct", "Indirect", "Total"),
        mc
      )
      colnames(mc) <- c(
        "effect",
        paste0(
          "mc_",
          c("est", "se", "ll", "ul")
        )
      )
      delta <- delta_xmy[
        which(delta_xmy[, "interval"] == interval),
        c("effect", "est", "se", "ll", "ul")
      ]
      rownames(delta) <- gsub(
        pattern = "(^[[:alpha:]])",
        replacement = "\\U\\1",
        x = delta[, "effect"],
        perl = TRUE
      )
      delta <- delta[
        c("Direct", "Indirect", "Total"),
        c("est", "se", "ll", "ul")
      ]
      delta <- data.frame(
        effect = c("Direct", "Indirect", "Total"),
        delta
      )
      colnames(delta) <- c(
        "effect",
        paste0(
          "delta_",
          c("est", "se", "ll", "ul")
        )
      )
      pb_pc <- pb_pc_xmy[
        which(pb_pc_xmy[, "interval"] == interval),
        c("effect", "est", "se", "ll", "ul")
      ]
      rownames(pb_pc) <- gsub(
        pattern = "(^[[:alpha:]])",
        replacement = "\\U\\1",
        x = pb_pc[, "effect"],
        perl = TRUE
      )
      pb_pc <- pb_pc[
        c("Direct", "Indirect", "Total"),
        c("est", "se", "ll", "ul")
      ]
      pb_pc <- data.frame(
        effect = c("Direct", "Indirect", "Total"),
        pb_pc
      )
      colnames(pb_pc) <- c(
        "effect",
        paste0(
          "pb_pc_",
          c("est", "se", "ll", "ul")
        )
      )
      pb_bc <- pb_bc_xmy[
        which(pb_bc_xmy[, "interval"] == interval),
        c("effect", "est", "se", "ll", "ul")
      ]
      rownames(pb_bc) <- gsub(
        pattern = "(^[[:alpha:]])",
        replacement = "\\U\\1",
        x = pb_bc[, "effect"],
        perl = TRUE
      )
      pb_bc <- pb_bc[
        c("Direct", "Indirect", "Total"),
        c("est", "se", "ll", "ul")
      ]
      pb_bc <- data.frame(
        effect = c("Direct", "Indirect", "Total"),
        pb_bc
      )
      colnames(pb_bc) <- c(
        "effect",
        paste0(
          "pb_bc_",
          c("est", "se", "ll", "ul")
        )
      )
      return(
        cbind(
          delta,
          mc,
          pb_pc,
          pb_bc
        )
      )
    }
    ci <- do.call(
      what = "rbind",
      args = lapply(
        X = 1:3,
        FUN = foo
      )
    )[, c(1, 2, 3, 4, 5, 7, 8, 9, 10, 12, 13, 14, 15, 17, 18, 19, 20)]
    saveRDS(
      ci,
      file = example_table_ci,
      compress = "xz"
    )
  }
}
data_process_example_med_std(n = 133)
rm(data_process_example_med_std)
