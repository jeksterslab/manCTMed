#' @param n Positive integer.
#'   Sample size.
#' @param sim R object.
#'   Output of the [GenData()] function.
#' @param data R object.
#'   Output of the [RandomMeasurement()] function.
#' @param fit R object.
#'   Output of the [FitDynr()] function.
#' @param phi_hat R object.
#'   Output of the [PhiHat()] function.
#' @param delta_t Numeric vector.
#'   Vector of time intervals.
#' @param R Positive integer.
#'   Number of random drift matrices to generate.
#' @param output_type Character string.
#'   Output type.
#'   Valid values include
#'   `"data"`,
#'   `"fit-dynr"`,
#'   `"dynr-delta-xmy"`,
#'   `"dynr-delta-ymx"`,
#'   `"dynr-mc-xmy"`, and
#'   `"dynr-mc-ymx"`
#' @param suffix Character string.
#'   Output of `manCTMed:::.SimSuffix()`.
#' @param output_folder Character string.
#'   Output folder.
#' @param overwrite Logical.
#'   Overwrite existing output in `output_folder`.
#' @param integrity Logical.
#'   If `integrity = TRUE`,
#'   check for the output file integrity when `overwrite = FALSE`.
#' @param seed Integer.
#'   Random seed.
#' @param params_taskid Data frame with a single row.
#'   Simulation parameters for a specific `taskid`.
#' @param taskid Positive integer.
#'   Task ID.
#' @param repid Positive integer.
#'   Replication ID.
#'
#' @name Template
NULL
