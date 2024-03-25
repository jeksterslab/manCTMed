#' Simulate Data
#'
#' The function simulates data using
#' the [simStateSpace::SimSSMOUFixed()] function.
#'
#' @param repid Positive integer.
#'   Replication ID.
#' @param n Positive integer.
#'   Sample size.
#'
#' @examples
#' \dontrun{
#' Data(repid = 1, n = 50)
#' }
#' @family Simulation Functions
#' @keywords manCTMed
#' @import simStateSpace
#' @export
Data <- function(repid,
                 n) {
  # parameters
  if (n == 50) {
    seed <- repid
  }
  if (n == 100) {
    seed <- 5000 + repid
  }
  if (n == 150) {
    seed <- 10000 + repid
  }
  if (n == 200) {
    seed <- 15000 + repid
  }
  set.seed(seed)
  time <- 7 * 24
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
  args <- list(
    repid = repid,
    n = n,
    seed = seed,
    time = time,
    delta_t = delta_t,
    k = k,
    p = p,
    mu0 = mu0,
    sigma0 = sigma0,
    sigma0_l = sigma0_l,
    mu = mu,
    phi = phi,
    sigma = sigma,
    sigma_l = sigma_l,
    nu = nu,
    lambda = lambda,
    theta = theta,
    theta_l = theta_l
  )
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
            size = 99,
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
  data <- dynUtils::InsertNA(
    data = data,
    id = "id",
    time = "time",
    observed = c("x", "m", "y"),
    delta_t = delta_t,
    ncores = NULL
  )
  return(
    list(
      args = args,
      sim = sim,
      data = data
    )
  )
}
