data_process_example_med <- function(overwrite = FALSE,
                                     n) {
  cat("\ndata_process_example_med\n")
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
    paste0(
      "fit-example-ct-",
      n,
      ".Rds"
    )
  )
  source(
    root$find_file(
      ".setup",
      "data-process",
      "data-process-example-ct.R"
    )
  )
  med_xmy_file <- root$find_file(
    ".setup",
    "data-raw",
    paste0(
      "med-example-xmy-",
      n,
      ".Rds"
    )
  )
  med_xym_file <- root$find_file(
    ".setup",
    "data-raw",
    paste0(
      "med-example-xym-",
      n,
      ".Rds"
    )
  )
  delta_xmy_file <- root$find_file(
    ".setup",
    "data-raw",
    paste0(
      "delta-example-xmy-",
      n,
      ".Rds"
    )
  )
  mc_xmy_file <- root$find_file(
    ".setup",
    "data-raw",
    paste0(
      "mc-example-xmy-",
      n,
      ".Rds"
    )
  )
  delta_xym_file <- root$find_file(
    ".setup",
    "data-raw",
    paste0(
      "delta-example-xym-",
      n,
      ".Rds"
    )
  )
  mc_xym_file <- root$find_file(
    ".setup",
    "data-raw",
    paste0(
      "mc-example-xym-",
      n,
      ".Rds"
    )
  )
  ci_file <- root$find_file(
    ".setup",
    "data-raw",
    paste0(
      "ci-example-",
      n,
      ".Rds"
    )
  )
  ci_beta_file <- root$find_file(
    ".setup",
    "data-raw",
    paste0(
      "ci-example-",
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
      "example-table-coef-",
      n,
      ".Rds"
    )
  )
  example_table_ci <- root$find_file(
    ".setup",
    "data-raw",
    paste0(
      "example-table-ci-",
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
          delta_xym_file,
          mc_xym_file,
          ci_file,
          ci_beta_file,
          example_table_coef,
          example_table_ci
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
      file = fit_example_ct
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
      "conflict",
      "knowledge",
      "competence"
    )
    vcov_phi_vec <- vcov(fit)[varnames, varnames]
    library(cTMed)
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
    med_xmy <- Med(
      phi = phi,
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
    med_xym <- Med(
      phi = phi,
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
      DeltaMed(
        phi = phi,
        vcov_phi_vec = vcov_phi_vec,
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
      MCMed(
        phi = phi,
        vcov_phi_vec = vcov_phi_vec,
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
    delta_xym <- summary(
      DeltaMed(
        phi = phi,
        vcov_phi_vec = vcov_phi_vec,
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
      MCMed(
        phi = phi,
        vcov_phi_vec = vcov_phi_vec,
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
    delta_xmy <- DeltaMed(
      phi = phi,
      vcov_phi_vec = vcov_phi_vec,
      from = "conflict",
      to = "competence",
      med = "knowledge",
      delta_t = delta_t,
      ncores = parallel::detectCores()
    )
    delta_xym <- DeltaMed(
      phi = phi,
      vcov_phi_vec = vcov_phi_vec,
      from = "conflict",
      to = "knowledge",
      med = "competence",
      delta_t = delta_t,
      ncores = parallel::detectCores()
    )
    mc_xmy <- MCMed(
      phi = phi,
      vcov_phi_vec = vcov_phi_vec,
      from = "conflict",
      to = "competence",
      med = "knowledge",
      delta_t = delta_t,
      ncores = parallel::detectCores(),
      R = 20000L,
      seed = 42
    )
    mc_xym <- MCMed(
      phi = phi,
      vcov_phi_vec = vcov_phi_vec,
      from = "conflict",
      to = "knowledge",
      med = "competence",
      delta_t = delta_t,
      ncores = parallel::detectCores(),
      R = 20000L,
      seed = 42
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
    fit_summary <- readRDS(fit_example_ct_summary)$Coefficients
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
      return(
        cbind(
          delta,
          mc
        )
      )
    }
    ci <- do.call(
      what = "rbind",
      args = lapply(
        X = 1:3,
        FUN = foo
      )
    )[, c(1, 2, 3, 4, 5, 7, 8, 9, 10)]
    saveRDS(
      ci,
      file = example_table_ci,
      compress = "xz"
    )
  }
}
data_process_example_med(n = 100)
data_process_example_med(n = 200)
data_process_example_med(n = 500)
data_process_example_med(n = 1000)
rm(data_process_example_med)
