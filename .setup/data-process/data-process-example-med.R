data_process_example_med <- function(overwrite = FALSE,
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
  source(
    root$find_file(
      ".setup",
      "data-process",
      "data-process-example-ct.R"
    )
  )
  if (!dir.exists(data_folder)) {
    dir.create(
      data_folder,
      recursive = TRUE
    )
  }
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
    delta_t <- seq(from = 0, to = 10, length.out = 1000)
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
    delta_xmy <- delta_xmy[, c("interval", "est", "ll", "ul", "effect", "method", "n", "model")]
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
    delta_xym <- delta_xym[, c("interval", "est", "ll", "ul", "effect", "method", "n", "model")]
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
    mc_xmy <- mc_xmy[, c("interval", "est", "ll", "ul", "effect", "method", "n", "model")]
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
    mc_xym <- mc_xym[, c("interval", "est", "ll", "ul", "effect", "method", "n", "model")]
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
  }
}
data_process_example_med(n = 100)
data_process_example_med(n = 500)
rm(data_process_example_med)
