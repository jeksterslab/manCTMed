#' Summary (FitDynr)
#'
#' @details This function is executed via the `Sum` function.
#'
#' @author Ivan Jacob Agaloos Pesigan
#'
#' @return The output is saved as an external file in `output_folder`.
#'
#' @inheritParams Template
#' @export
#' @import dynr
#' @keywords manCTMed summary simulation
SumFitDynr <- function(taskid,
                       reps,
                       output_folder,
                       overwrite,
                       integrity) {
  # Do not include default arguments here.
  # Do not run on its own. Use the `Sum` function.
  fn_output <- SimFN(
    output_type = "summary-fit-dynr",
    output_folder = output_folder,
    suffix = paste0(
      sprintf(
        "%05d",
        taskid
      ),
      "-",
      sprintf(
        "%05d",
        reps
      ),
      ".Rds"
    )
  )
  run <- .SimCheck(
    fn = fn_output,
    overwrite = overwrite,
    integrity = integrity
  )
  if (run) {
    replication <- function(repid,
                            taskid) {
      suffix <- .SimSuffix(
        taskid = taskid,
        repid = repid
      )
      fn_input <- SimFN(
        output_type = "fit-dynr",
        output_folder = output_folder,
        suffix = suffix
      )
      raw <- summary(
        readRDS(fn_input)
      )$Coefficients
      colnames(raw) <- c(
        "est",
        "se",
        "t",
        "2.5%",
        "97.5%",
        "p"
      )
      raw <- raw[
        c(
          "phi_11",
          "phi_21",
          "phi_31",
          "phi_12",
          "phi_22",
          "phi_32",
          "phi_13",
          "phi_23",
          "phi_33",
          "sigma_11",
          "sigma_12",
          "sigma_13",
          "sigma_22",
          "sigma_23",
          "sigma_33",
          "theta_11",
          "theta_22",
          "theta_33",
          "mu0_1",
          "mu0_2",
          "mu0_3",
          "sigma0_11",
          "sigma0_12",
          "sigma0_13",
          "sigma0_22",
          "sigma0_23",
          "sigma0_33"
        ),
      ]
      param <- params[taskid, ]
      n <- param$n
      if (param$dynamics == 0) {
        phi <- model$phi_zero
        sigma <- model$sigma_zero
      }
      if (param$dynamics == 1) {
        phi <- model$phi_pos
        sigma <- model$sigma_pos
      }
      if (param$dynamics == -1) {
        phi <- model$phi_neg
        sigma <- model$sigma_neg
      }
      theta <- model$theta
      mu0 <- model$mu0
      sigma0 <- model$sigma0
      parameter <- c(
        .Vec(phi),
        .Vech(sigma),
        diag(theta),
        mu0,
        .Vech(sigma0)
      )
      df <- data.frame(
        est = raw$est,
        se = raw$se,
        t = raw$t,
        p = raw$p,
        ll = raw[["2.5%"]],
        ul = raw[["97.5%"]],
        sig = as.integer(
          raw$p < 0.05
        ),
        zero_hit = as.integer(
          (
            raw[["2.5%"]] <= 0
          ) & (
            0 <= raw[["97.5%"]]
          )
        ),
        theta_hit = as.integer(
          (
            raw[["2.5%"]] <= parameter
          ) & (
            parameter <= raw[["97.5%"]]
          )
        ),
        sq_error = (parameter - raw$est)^2
      )
      attr(df, "taskid") <- taskid
      attr(df, "n") <- n
      attr(df, "parnames") <- rownames(raw)
      attr(df, "parameter") <- parameter
      attr(df, "method") <- "dynr"
      df
    }
    i <- parallel::mclapply(
      X = seq_len(reps),
      FUN = replication,
      taskid = taskid
    )
    means <- (
      1 / reps
    ) * Reduce(
      f = `+`,
      x = i
    )
    sq_errors <- parallel::mclapply(
      X = i,
      FUN = function(x, means) {
        (means - x)^2
      },
      means = means
    )
    vars <- (
      1 / (reps - 1)
    ) * Reduce(
      f = `+`,
      x = sq_errors
    )
    sds <- sqrt(vars)
    means <- data.frame(
      taskid = attr(i[[1]], "taskid"),
      replications = reps,
      parnames = attr(i[[1]], "parnames"),
      parameter = attr(i[[1]], "parameter"),
      method = attr(i[[1]], "method"),
      n = attr(i[[1]], "n"),
      est = means$est,
      se = means$se,
      t = means$t,
      p = means$p,
      ll = means$ll,
      ul = means$ul,
      sig = means$sig,
      zero_hit = means$zero_hit,
      theta_hit = means$theta_hit,
      sq_error = means$sq_error
    )
    vars <- data.frame(
      taskid = attr(i[[1]], "taskid"),
      replications = reps,
      parnames = attr(i[[1]], "parnames"),
      parameter = attr(i[[1]], "parameter"),
      method = attr(i[[1]], "method"),
      n = attr(i[[1]], "n"),
      est = vars$est,
      se = vars$se,
      t = vars$t,
      p = vars$p,
      ll = vars$ll,
      ul = vars$ul,
      sig = vars$sig,
      zero_hit = vars$zero_hit,
      theta_hit = vars$theta_hit,
      sq_error = vars$sq_error
    )
    sds <- data.frame(
      taskid = attr(i[[1]], "taskid"),
      replications = reps,
      parnames = attr(i[[1]], "parnames"),
      parameter = attr(i[[1]], "parameter"),
      method = attr(i[[1]], "method"),
      n = attr(i[[1]], "n"),
      est = sds$est,
      se = sds$se,
      t = sds$t,
      p = sds$p,
      ll = sds$ll,
      ul = sds$ul,
      sig = sds$sig,
      zero_hit = sds$zero_hit,
      theta_hit = sds$theta_hit,
      sq_error = sds$sq_error
    )
    means$se_bias <- sds$est - means$se
    means$coverage <- means$theta_hit
    means$power <- 1 - means$zero_hit
    output <- list(
      replications = i,
      means = means,
      vars = vars,
      sds = sds
    )
    saveRDS(
      object = output,
      file = fn_output,
      compress = "xz"
    )
    .SimChMod(fn_output)
  }
}
