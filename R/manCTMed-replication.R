#' Simulation Replication
#'
#' Performs a single simulation replication involving the following:
#' - Data generation using the `simStateSpace` package.
#' - Model fitting using the `dynr` package.
#' - Model fitting using the `ctsem` package.
#' - Generate delta method confidence intervals
#'   using the [cTMed::DeltaMed()] function.
#' - Generate Monte Carlo method confidence intervals
#'   using the [cTMed::MCMed()] function.
#' - Generate credible intervals
#'   based on the posterior distribution of the drift matrix
#'   using the [cTMed::PosteriorMed()] function.
#'
#' @author Ivan Jacob Agaloos Pesigan
#'
#' @param i Positive integer.
#'   Replication ID.
#' @param n Positive integer.
#'   Sample size.
#' @param write Logical.
#'   If `write = TRUE`, write results into a file.
#'   If `write = FALSE`, return results.
#' @param wd Working directory.   
#'   Needed for output files if `write = TRUE`
#'   and for temporary files.
#'
#' @examples
#' Replication(i = 1, n = 50, wd = tempdir())
#'
#' @family Simulation Functions
#' @keywords manCTMed
#' @importFrom stats coef vcov 
#' @import dynr
#' @export
Replication <- function(i,
                        n,
                        write = FALSE,
                        wd = getwd()) {
  # path
  path <- file.path(
    wd,
    paste0(
      "n",
      "-",
      sprintf(
        "%05d",
        n
      )
    )
  )
  dir.create(
    path,
    showWarnings = FALSE,
    recursive = TRUE
  )
  # files
  fn_root <- file.path(
    path,
    paste0(
      "manCTMed",
      "-",
      "n",
      "-",
      sprintf(
        "%05d",
        n
      ),
      "-",
      "rep",
      "-",
      sprintf(
        "%05d",
        i
      )
    )
  )
  fn <- paste0(
    fn_root,
    ".Rds"
  )
  on.exit(
    unlink(
      c(
        paste0(fn_root, ".c"),
        paste0(fn_root, ".o"),
        paste0(fn_root, ".so")
      )
    )
  )
  if (file.exists(fn)) {
    run <- tryCatch(
      expr = {
        readRDS(fn)
        return(FALSE)
      },
      error = function(e) {
        return(TRUE)
      }
    )
  } else {
    run <- TRUE
  }
  if (run) {
    # parameters
    seed <- .Machine$integer.max - n - i
    set.seed(seed)
    time <- 721
    delta_t <- 1 / 24
    k <- p <- 3
    iden <- diag(k)
    null_vec <- rep(x = 0, times = k)
    mu0 <- null_vec
    sigma0 <- matrix(
      data = c(
        1.0,
        0.2,
        0.2,
        0.2,
        1.0,
        0.2,
        0.2,
        0.2,
        1.0
      ),
      nrow = 3
    )
    sigma0_l <- t(chol(sigma0))
    mu <- null_vec
    phi <- matrix(
      data = c(
        -0.357,
        0.771,
        -0.450,
        0.0,
        -0.511,
        0.729,
        0,
        0,
        -0.693
      ),
      nrow = k
    )
    sigma <- matrix(
      data = c(
        0.24455556,
        0.02201587,
        -0.05004762,
        0.02201587,
        0.07067800,
        0.01539456,
        -0.05004762,
        0.01539456,
        0.07553061
      ),
      nrow = p
    )
    sigma_l <- t(chol(sigma))
    nu <- null_vec
    lambda <- iden
    theta <- 0.2 * iden
    theta_l <- t(chol(theta))
    # data
    sim <- simStateSpace::SimSSMOUFixed(
      n = n,
      time = time,
      delta_t = delta_t,
      mu0 = mu0,
      sigma0_l = sigma0_l,
      mu = mu,
      phi = phi,
      sigma_l = sigma_l,
      nu = nu,
      lambda = lambda,
      theta_l = theta_l,
      type = 0
    )
    data <- as.data.frame(sim)
    colnames(data) <- c(
      "id",
      "time",
      "x",
      "m",
      "y"
    )
    data <- dynUtils::SubsetByID(
      data = data,
      id = "id",
      time = "time",
      observed = c("x", "m", "y"),
      ncores = NULL
    )
    data <- lapply(
      X = data,
      FUN = function(x) {
        idx <- c(
          1,
          sort(
            sample(
              x = 2:time,
              size = 199,
              replace = FALSE
            )
          )
        )
        return(x[idx, ])
      }
    )
    data <- do.call(
      what = "rbind",
      args = data
    )
    # dynr
    data <- dynUtils::InsertNA(
      data = data,
      id = "id",
      time = "time",
      observed = c("x", "m", "y"),
      delta_t = delta_t,
      ncores = NULL
    )
    dynr_data <- dynr::dynr.data(
      dataframe = data,
      id = "id",
      time = "time",
      observed = c("x", "m", "y")
    )
    dynr_initial <- dynr::prep.initial(
      values.inistate = rep(x = 0, times = 3),
      params.inistate = mu0,
      values.inicov = sigma0,
      params.inicov = matrix(
        data = c(
          "sigma0_11", "sigma0_12", "sigma0_13",
          "sigma0_12", "sigma0_22", "sigma0_23",
          "sigma0_13", "sigma0_23", "sigma0_33"
        ),
        nrow = 3
      )
    )
    dynr_measurement <- dynr::prep.measurement(
      values.load = lambda,
      params.load = matrix(data = "fixed", nrow = 3, ncol = 3),
      state.names = c("eta_x", "eta_m", "eta_y"),
      obs.names = c("x", "m", "y")
    )
    dynr_dynamics <- dynr::prep.formulaDynamics(
      formula = list(
        eta_x ~ phi_11 * eta_x + phi_12 * eta_m + phi_13 * eta_y,
        eta_m ~ phi_21 * eta_x + phi_22 * eta_m + phi_23 * eta_y,
        eta_y ~ phi_31 * eta_x + phi_32 * eta_m + phi_33 * eta_y
      ),
      startval = c(
        phi_11 = phi[1, 1], phi_12 = phi[1, 2], phi_13 = phi[1, 3],
        phi_21 = phi[2, 1], phi_22 = phi[2, 2], phi_23 = phi[2, 3],
        phi_31 = phi[3, 1], phi_32 = phi[3, 2], phi_33 = phi[3, 3]
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
        nrow = 3
      ),
      values.observed = theta,
      params.observed = matrix(
        data = c(
          "theta_11", "fixed", "fixed",
          "fixed", "theta_22", "fixed",
          "fixed", "fixed", "theta_33"
        ),
        nrow = 3
      )
    )
    model <- dynr::dynr.model(
      data = dynr_data,
      initial = dynr_initial,
      measurement = dynr_measurement,
      dynamics = dynr_dynamics,
      noise = dynr_noise,
      outfile = paste0(
        fn_root,
        ".c"
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
    model$lb <- lb
    model$ub <- ub
    dynr_fit <- dynr::dynr.cook(
      model,
      debug_flag = TRUE,
      verbose = FALSE
    )
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
    # ctsem
    model <- ctsem::ctModel(
      type = "stanct",
      manifestNames = c("x", "m", "y"),
      latentNames = c("eta_x", "eta_m", "eta_y"),
      LAMBDA = diag(3),
      DRIFT = "auto",
      MANIFESTMEANS = matrix(data = 0, nrow = 3, ncol = 1),
      MANIFESTVAR = diag(0, 3),
      CINT = "auto",
      DIFFUSION = "auto"
    )
    ctsem_fit <- ctsem::ctStanFit(
      datalong = data,
      ctstanmodel = model,
      optimize = TRUE,
      cores = 1
    )
    posterior <- ctsem::ctExtract(ctsem_fit)$pop_DRIFT
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
    vcov_phi_vec <- stats::cov(
      do.call(what = "rbind", args = posterior_phi_vec)
    )
    ctsem <- list(
      posterior = posterior,
      posterior_phi = posterior_phi,
      phi = phi,
      vcov = vcov_phi_vec
    )
    delta_dynr <- cTMed::DeltaMed(
      phi = dynr$phi,
      vcov_phi_vec = dynr$vcov,
      delta_t = c(5, 10, 15, 20),
      from = "x",
      to = "y",
      med = "m",
      ncores = NULL
    )
    mc_dynr <- cTMed::MCMed(
      phi = dynr$phi,
      vcov_phi_vec = dynr$vcov,
      delta_t = c(5, 10, 15, 20),
      from = "x",
      to = "y",
      med = "m",
      R = 1000L,
      ncores = NULL,
      seed = seed
    )
    delta_ctsem <- cTMed::DeltaMed(
      phi = ctsem$phi,
      vcov_phi_vec = ctsem$vcov,
      delta_t = c(5, 10, 15, 20),
      from = "x",
      to = "y",
      med = "m",
      ncores = NULL
    )
    mc_ctsem <- cTMed::MCMed(
      phi = ctsem$phi,
      vcov_phi_vec = ctsem$vcov,
      delta_t = c(5, 10, 15, 20),
      from = "x",
      to = "y",
      med = "m",
      R = 1000L,
      ncores = NULL,
      seed = seed
    )
    posterior <- cTMed::PosteriorMed(
      phi = posterior_phi,
      delta_t = c(5, 10, 15, 20),
      from = "x",
      to = "y",
      med = "m",
      ncores = NULL
    )
    output <- list(
      sim = sim,
      data = data,
      dynr_fit = dynr_fit,
      ctsem_fit = ctsem_fit,
      delta_dynr = delta_dynr,
      mc_dynr = mc_dynr,
      delta_ctsem = delta_ctsem,
      mc_ctsem = mc_ctsem,
      posterior = posterior
    )
    if (write) {
      saveRDS(
        output,
        file = fn,
        compress = "xz"
      )
    } else {
      return(output)
    }
  }
}
