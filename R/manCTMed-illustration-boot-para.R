#' Parametric Bootstrap (Illustration)
#'
#' The function generates simulated datasets
#' based on a fitted model and refits the model
#' to each generated dataset using the `dynr` package.
#'
#' @inheritParams TemplateIllustration
#' @inheritParams bootStateSpace::PBSSMOUFixed
#'
#' @examples
#' \dontrun{
#' library(dynr)
#' sim <- IllustrationGenData(seed = 42)
#' data <- IllustrationPrepData(sim)
#' fit <- IllustrationFitDynr(data)
#' summary(fit)
#' IllustrationBootPara(
#'   fit = fit,
#'   path = getwd(),
#'   prefix = "pb",
#'   taskid = 1,
#'   B = 1000L,
#'   seed = 42
#' )
#' }
#' @family Confidence Interval Functions
#' @keywords manCTMed ci illustration
#' @export
IllustrationBootPara <- function(fit,
                                 path,
                                 prefix,
                                 taskid,
                                 B = 1000L,
                                 ncores = NULL,
                                 seed = NULL) {
  n <- 133
  m <- 101
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
    time = m,
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
}
