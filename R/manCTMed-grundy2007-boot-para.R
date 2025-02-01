#' Parametric Bootstrap (Grundy, et al. 2007)
#'
#' The function generates simulated datasets
#' based on a fitted model and refits the model
#' to each generated dataset using the `dynr` package.
#'
#' @param fit R object.
#'   Output of the [FitDynr()] function.
#' @inheritParams Grundy2007FitDynr
#' @inheritParams BootPara
#'
#' @examples
#' \dontrun{
#' library(dynr)
#' data <- Grundy2007GenData(taskid = 1)
#' fit <- Grundy2007FitDynr(data)
#' GrundyBootPara(
#'   fit = fit,
#'   data = data,
#'   path = getwd(),
#'   prefix = "pb",
#'   B = 1000L
#' )
#' }
#' @family Confidence Interval Functions
#' @keywords manCTMed ci grundy
#' @export
Grundy2007BootPara <- function(fit,
                               data,
                               path,
                               prefix,
                               B = 1000L,
                               ncores = NULL,
                               seed = NULL) {
  n <- length(
    unique(data$id)
  )
  est <- coef(fit)
  data_0 <- data[which(data[, "time"] == 0), ]
  mu0 <- colMeans(data_0)[
    c("x", "m", "y")
  ]
  sigma0_l <- t(
    chol(
      stats::cov(data_0)[
        c("x", "m", "y"),
        c("x", "m", "y")
      ],
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
  output <- bootStateSpace::PBSSMOUFixed(
    R = B,
    path = path,
    prefix = prefix,
    n = n,
    time = 30,
    delta_t = 0.10,
    mu0 = mu0,
    sigma0_l = sigma0_l,
    mu = c(0, 0, 0),
    phi = phi,
    sigma_l = sigma_l,
    nu = c(0, 0, 0),
    lambda = diag(3),
    theta_l = theta_l,
    type = 0,
    ncores = ncores,
    seed = seed
  )
  return(
    output
  )
}
