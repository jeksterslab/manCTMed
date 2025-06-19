#' Fit the Model using the OpenMx Package  (Illustration)
#'
#' The function fits the model using the [OpenMx] package.
#'
#' @inheritParams TemplateIllustration
#'
#' @examples
#' \dontrun{
#' library(OpenMx)
#' sim <- IllustrationGenData(seed = 42)
#' data <- IllustrationPrepData(sim)
#' fit <- IllustrationFitMx(data)
#' summary(fit)
#' }
#' @family Model Fitting Functions
#' @keywords manCTMed fit illustration
#' @export
IllustrationFitMx <- function(data) {
  phi <- matrix(
    data = c(
      -0.138,
      -0.124,
      -0.057,
      0,
      -0.865,
      0.115,
      0,
      0.434,
      -0.693
    ),
    nrow = 3,
    ncol = 3
  )
  sigma <- theta <- 0.10 * diag(3)
  sigma0 <- simStateSpace::LinSDECov(
    phi = phi,
    sigma = sigma
  )
  sigma0 <- (sigma0 + t(sigma0)) / 2
  ids <- sort(
    unique(data[, "id"])
  )
  lbound <- matrix(
    data = NA,
    nrow = 3,
    ncol = 3
  )
  diag(lbound) <- 0
  mu0 <- OpenMx::mxMatrix(
    type = "Full",
    nrow = 3,
    ncol = 1,
    free = TRUE,
    values = rep(x = 0, times = 3),
    labels = matrix(
      data = c(
        "mu0_1",
        "mu0_2",
        "mu0_3"
      ),
      nrow = 3,
      ncol = 1
    ),
    lbound = NA,
    ubound = NA,
    byrow = FALSE,
    dimnames = list(
      c("eta_x", "eta_m", "eta_y"),
      "mu0"
    ),
    name = "mu0"
  )
  sigma0 <- OpenMx::mxMatrix(
    type = "Symm",
    nrow = 3,
    ncol = 3,
    free = TRUE,
    values = sigma0,
    labels = matrix(
      data = c(
        "sigma0_11", "sigma0_12", "sigma0_13",
        "sigma0_12", "sigma0_22", "sigma0_23",
        "sigma0_13", "sigma0_23", "sigma0_33"
      ),
      nrow = 3,
      ncol = 3
    ),
    lbound = lbound,
    ubound = NA,
    byrow = FALSE,
    dimnames = list(
      c("eta_x", "eta_m", "eta_y"),
      c("eta_x", "eta_m", "eta_y")
    ),
    name = "sigma0"
  )
  phi_lbound <- matrix(
    data = -4,
    nrow = 3,
    ncol = 3
  )
  phi_ubound <- matrix(
    data = 4,
    nrow = 3,
    ncol = 3
  )
  diag(phi_ubound) <- .Machine$double.xmin
  phi <- OpenMx::mxMatrix(
    type = "Full",
    nrow = 3,
    ncol = 3,
    free = TRUE,
    values = phi,
    labels = matrix(
      data = c(
        "phi_11",
        "phi_21",
        "phi_31",
        "phi_12",
        "phi_22",
        "phi_32",
        "phi_13",
        "phi_23",
        "phi_33"
      ),
      nrow = 3,
      ncol = 3
    ),
    lbound = phi_lbound,
    ubound = phi_ubound,
    byrow = FALSE,
    dimnames = list(
      c("eta_x", "eta_m", "eta_y"),
      c("eta_x", "eta_m", "eta_y")
    ),
    name = "phi"
  )
  gamma <- OpenMx::mxMatrix(
    type = "Zero",
    nrow = 3,
    ncol = 1,
    name = "gamma"
  )
  covariate <- OpenMx::mxMatrix(
    type = "Zero",
    nrow = 1,
    ncol = 1,
    name = "covariate"
  )
  sigma <- OpenMx::mxMatrix(
    type = "Symm",
    nrow = 3,
    ncol = 3,
    free = TRUE,
    values = sigma,
    labels = matrix(
      data = c(
        "sigma_11", "sigma_12", "sigma_13",
        "sigma_12", "sigma_22", "sigma_23",
        "sigma_13", "sigma_23", "sigma_33"
      ),
      nrow = 3,
      ncol = 3
    ),
    lbound = lbound,
    ubound = NA,
    byrow = FALSE,
    dimnames = list(
      c("eta_x", "eta_m", "eta_y"),
      c("eta_x", "eta_m", "eta_y")
    ),
    name = "sigma"
  )
  lambda <- OpenMx::mxMatrix(
    type = "Diag",
    nrow = 3,
    ncol = 3,
    free = FALSE,
    values = 1,
    labels = NA,
    lbound = NA,
    ubound = NA,
    byrow = FALSE,
    dimnames = list(
      c("x", "m", "y"),
      c("eta_x", "eta_m", "eta_y")
    ),
    name = "lambda"
  )
  kappa <- OpenMx::mxMatrix(
    type = "Zero",
    nrow = 3,
    ncol = 1,
    name = "kappa"
  )
  theta <- OpenMx::mxMatrix(
    type = "Diag",
    nrow = 3,
    ncol = 3,
    free = TRUE,
    values = theta,
    labels = matrix(
      data = c(
        "theta_11", "fixed", "fixed",
        "fixed", "theta_22", "fixed",
        "fixed", "fixed", "theta_33"
      ),
      nrow = 3,
      ncol = 3
    ),
    lbound = lbound,
    ubound = NA,
    byrow = FALSE,
    dimnames = list(
      c("x", "m", "y"),
      c("x", "m", "y")
    ),
    name = "theta"
  )
  time <- OpenMx::mxMatrix(
    type = "Full",
    nrow = 1,
    ncol = 1,
    free = FALSE,
    labels = "data.time",
    name = "time"
  )
  model <- OpenMx::mxModel(
    model = "CTVAR",
    phi,
    gamma,
    lambda,
    kappa,
    sigma,
    theta,
    mu0,
    sigma0,
    covariate,
    time,
    OpenMx::mxExpectationStateSpaceContinuousTime(
      A = "phi",
      B = "gamma",
      C = "lambda",
      D = "kappa",
      Q = "sigma",
      R = "theta",
      x0 = "mu0",
      P0 = "sigma0",
      u = "covariate",
      t = "time",
      dimnames = c("x", "m", "y")
    ),
    OpenMx::mxFitFunctionML(),
    OpenMx::mxData(
      observed = data,
      type = "raw"
    )
  )
  model_id <- function(i,
                       data,
                       model) {
    OpenMx::mxModel(
      name = paste0("CTVAR", "_", i),
      model = model,
      OpenMx::mxData(
        observed = data[
          which(
            data[, "id"] == i
          ), ,
          drop = FALSE
        ],
        type = "raw"
      )
    )
  }
  model_i <- lapply(
    X = ids,
    FUN = model_id,
    data = data,
    model = model
  )
  fit <- OpenMx::mxTryHardctsem(
    model = OpenMx::mxModel(
      name = "CTVAR",
      model_i,
      OpenMx::mxFitFunctionMultigroup(
        paste0(
          "CTVAR",
          "_",
          ids
        )
      )
    ),
    extraTries = 1000
  )
  if (fit@output[["status"]][["code"]] > 1) {
    fit <- OpenMx::mxTryHardctsem(
      model = fit,
      extraTries = 1000
    )
  }
  fit
}
