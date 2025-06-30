#' Summary (DynrDeltaStdYMX)
#'
#' @details This function is executed via the `Sum` function.
#'
#' @author Ivan Jacob Agaloos Pesigan
#'
#' @return The output is saved as an external file in `output_folder`.
#'
#' @inheritParams TemplateIllustration
#' @export
#' @import cTMed
#' @keywords manCTMed summary simulation
SumDynrDeltaStdYMX <- function(taskid,
                               reps,
                               output_folder,
                               overwrite,
                               integrity) {
  # Do not include default arguments here.
  # Do not run on its own. Use the `IllustrationSum` function.
  fn_output <- SimFN(
    output_type = "summary-dynr-delta-std-ymx",
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
        output_type = "dynr-delta-std-ymx",
        output_folder = output_folder,
        suffix = suffix
      )
      raw <- summary(
        readRDS(fn_input),
        alpha = 0.05
      )
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
      colnames(phi) <- rownames(phi) <- c(
        "x",
        "m",
        "y"
      )
      parameter <- cTMed::MedStd(
        phi = phi,
        sigma = sigma,
        delta_t = unique(raw$interval),
        from = "y",
        to = "x",
        med = "m"
      )$output
      parameter <- t(parameter[, -4])
      dim(parameter) <- NULL
      df <- data.frame(
        est = raw$est,
        se = raw$se,
        z = raw$z,
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
      attr(df, "effect") <- raw$effect
      attr(df, "interval") <- raw$interval
      attr(df, "parameter") <- parameter
      attr(df, "method") <- "delta"
      attr(df, "xmy") <- FALSE
      attr(df, "std") <- TRUE
      attr(df, "dynamics") <- param$dynamics
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
      effect = attr(i[[1]], "effect"),
      interval = attr(i[[1]], "interval"),
      dynamics = attr(i[[1]], "dynamics"),
      parameter = attr(i[[1]], "parameter"),
      method = attr(i[[1]], "method"),
      xmy = attr(i[[1]], "xmy"),
      std = attr(i[[1]], "std"),
      n = attr(i[[1]], "n"),
      est = means$est,
      se = means$se,
      z = means$z,
      p = means$p,
      R = NA,
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
      effect = attr(i[[1]], "effect"),
      interval = attr(i[[1]], "interval"),
      dynamics = attr(i[[1]], "dynamics"),
      parameter = attr(i[[1]], "parameter"),
      method = attr(i[[1]], "method"),
      xmy = attr(i[[1]], "xmy"),
      std = attr(i[[1]], "std"),
      n = attr(i[[1]], "n"),
      est = vars$est,
      se = vars$se,
      z = vars$z,
      p = vars$p,
      R = NA,
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
      effect = attr(i[[1]], "effect"),
      interval = attr(i[[1]], "interval"),
      dynamics = attr(i[[1]], "dynamics"),
      parameter = attr(i[[1]], "parameter"),
      method = attr(i[[1]], "method"),
      xmy = attr(i[[1]], "xmy"),
      std = attr(i[[1]], "std"),
      n = attr(i[[1]], "n"),
      est = sds$est,
      se = sds$se,
      z = sds$z,
      p = sds$p,
      R = NA,
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
