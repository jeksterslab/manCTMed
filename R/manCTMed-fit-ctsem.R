#' Fit the Model using the ctsem Package
#'
#' The function fits the model using the [ctsem] package.
#'
#' @param x R object.
#'   Output of the [Data()] function.
#'
#' @examples
#' library(ctsem)
#' data <- Data(i = 1, n = 50)
#' fit <- FitCtsem(x = data)
#'
#' @family Simulation Functions
#' @keywords manCTMed
#' @export
FitCtsem <- function(x) {
  set.seed(x$args$seed)
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
    datalong = x$data,
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
  phi_vec <- colMeans(
    do.call(
      what = "rbind",
      args = posterior_phi_vec
    )
  )
  phi <- matrix(
    data = phi_vec,
    nrow = 3
  )
  colnames(phi) <- rownames(phi) <- c("x", "m", "y")
  vcov <- stats::cov(
    do.call(
      what = "rbind",
      args = posterior_phi_vec
    )
  )
  return(
    list(
      type = "ctsem",
      fit = ctsem_fit,
      phi = phi,
      vcov = vcov,
      posterior = posterior,
      posterior_phi = posterior_phi,
      seed = x$args$seed
    )
  )
}
