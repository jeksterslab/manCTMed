data_process_deboeck2015phi <- function(overwrite = FALSE) {
  # find root directory
  root <- rprojroot::is_rstudio_project
  deboeck2015_phi_rds <- root$find_file(
    ".setup",
    "data-raw",
    "deboeck2015phi.Rds"
  )
  deboeck2015_phi_rda <- root$find_file(
    "data",
    "deboeck2015phi.rda"
  )
  deboeck2015_ou_ctsem_rds <- root$find_file(
    ".setup",
    "data-raw",
    "deboeck2015_ou_ctsem.Rds"
  )
  deboeck2015_ou_dynr_rds <- root$find_file(
    ".setup",
    "data-raw",
    "deboeck2015_ou_dynr.Rds"
  )
  if (file.exists(deboeck2015_phi_rds)) {
    run <- FALSE
    if (overwrite) {
      run <- TRUE
    }
  } else {
    run <- TRUE
  }
  if (!file.exists(deboeck2015_ou_ctsem_rds)) {
    run <- TRUE
  }
  if (!file.exists(deboeck2015_ou_dynr_rds)) {
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
        "data-process-ou-ctsem.R"
      )
    )
    source(
      root$find_file(
        ".setup",
        "data-process",
        "data-process-ou-dynr.R"
      )
    )
    ctsem_fit <- readRDS(deboeck2015_ou_ctsem_rds)
    dynr_fit <- readRDS(deboeck2015_ou_dynr_rds)
    # ctsem
    posterior <- ctExtract(ctsem_fit)$pop_DRIFT
    posterior_phi <- lapply(
      X = seq_len(dim(posterior)[1]),
      FUN = function(i) {
        phi <- posterior[i, , ]
        colnames(phi) <- rownames(phi) <- c("x", "m", "y")
        return(phi)
      }
    )
    posterior_phi_vec <- lapply(
      X = posterior_phi,
      FUN = function(i) {
        dim(i) <- NULL
        return(i)
      }
    )
    phi_vec <- colMeans(do.call(what = "rbind", args = posterior_phi_vec))
    phi <- matrix(
      data = phi_vec,
      nrow = 3
    )
    colnames(phi) <- rownames(phi) <- c("x", "m", "y")
    vcov_phi_vec <- var(do.call(what = "rbind", args = posterior_phi_vec))
    ctsem <- list(
      posterior = posterior,
      posterior_phi = posterior_phi,
      phi = phi,
      vcov = vcov_phi_vec
    )
    # dynr
    parnames <- c(
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
    phi_vec <- coef(dynr_fit)[parnames]
    phi <- matrix(
      data = phi_vec,
      nrow = 3
    )
    colnames(phi) <- rownames(phi) <- c("x", "m", "y")
    vcov_phi_vec <- vcov(dynr_fit)[parnames, parnames]
    dynr <- list(
      phi = phi,
      vcov = vcov_phi_vec
    )
    deboeck2015phi <- list(
      dynr = dynr,
      ctsem = ctsem
    )
    saveRDS(
      deboeck2015phi,
      file = deboeck2015_phi_rds,
      compress = "xz"
    )
    save(
      deboeck2015phi,
      file = deboeck2015_phi_rda,
      compress = "xz"
    )
  }
}
data_process_deboeck2015phi()
rm(data_process_deboeck2015phi)
