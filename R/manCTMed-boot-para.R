#' Parametric Bootstrap
#'
#' The function generates simulated datasets
#' based on a fitted model and refits the model
#' to each generated dataset using the `dynr` package.
#'
#' @inheritParams Template
#' @inheritParams bootStateSpace::PBSSMOUFixed
#'
#' @examples
#' \dontrun{
#' set.seed(42)
#' library(dynr)
#' sim <- GenData(taskid = 1)
#' data <- RandomMeasurement(sim)
#' fit <- FitDynr(data, taskid = 1)
#' BootPara(
#'   fit = fit,
#'   path = getwd(),
#'   prefix = "pb",
#'   taskid = 1,
#'   B = 1000L
#' )
#' }
#' @family Confidence Interval Functions
#' @keywords manCTMed ci
#' @export
BootPara <- function(fit,
                     path,
                     prefix,
                     taskid,
                     B = 1000L,
                     ncores = NULL,
                     seed = NULL,
                     clean = TRUE) {
  param <- params[taskid, ]
  n <- param$n
  est <- coef(fit)
  mu0 <- est[
    c(
      "mu0_1",
      "mu0_2",
      "mu0_3"
    )
  ]
  sigma0_l <- t(
    chol(
      matrix(
        data = est[
          c(
            "sigma0_11", "sigma0_12", "sigma0_13",
            "sigma0_12", "sigma0_22", "sigma0_23",
            "sigma0_13", "sigma0_23", "sigma0_33"
          )
        ],
        nrow = 3,
        ncol = 3
      )
    )
  )
  phi <- matrix(
    data = est[
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
    ],
    nrow = 3,
    ncol = 3
  )
  sigma_l <- t(
    chol(
      matrix(
        data = est[
          c(
            "sigma_11", "sigma_12", "sigma_13",
            "sigma_12", "sigma_22", "sigma_23",
            "sigma_13", "sigma_23", "sigma_33"
          )
        ],
        nrow = 3,
        ncol = 3
      )
    )
  )
  theta_l <- t(
    chol(
      matrix(
        data = c(
          est["theta_11"], 0, 0,
          0, est["theta_22"], 0,
          0, 0, est["theta_33"]
        ),
        nrow = 3,
        ncol = 3
      )
    )
  )
  bootStateSpace::PBSSMOUFixed(
    R = B,
    path = path,
    prefix = prefix,
    n = n,
    time = model$time,
    delta_t = model$delta_t,
    mu0 = mu0,
    sigma0_l = sigma0_l,
    mu = model$mu,
    phi = phi,
    sigma_l = sigma_l,
    nu = model$nu,
    lambda = model$lambda,
    theta_l = theta_l,
    type = 0,
    ncores = ncores,
    seed = seed,
    clean = clean
  )
}
