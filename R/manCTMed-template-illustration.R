#' @param seed Integer.
#'   Random seed.
#' @param n Positive integer.
#'   Sample size.
#' @param m Positive integer.
#'   Measurement occasions.
#' @param delta_t_gen Numeric.
#'   Time interval used to generate data.
#' @param sim R object.
#'   Output of the [IllustrationGenData()] function.
#' @param data R object.
#'   Output of the [IllustrationPrepData()] function.
#' @param fit R object.
#'   Fitted CT-VAR model.
#' @param R Positive integer.
#'   Number of Monte Carlo replications.
#' @param B Positive integer.
#'   Number of bootstrap samples.
#' @param delta_t Numeric vector.
#'   Vector of time intervals.
#'
#' @param taskid Positive integer.
#'   Task ID.
#' @param repid Positive integer.
#'   Replication ID.
#' @param output_folder Character string.
#'   Output folder.
#' @param output_type Character string.
#'   Output type.
#' @param suffix Character string.
#'   Output of `manCTMed:::.SimSuffix()`.
#' @param seed Integer.
#'   Random seed.
#' @param overwrite Logical.
#'   Overwrite existing output in `output_folder`.
#' @param integrity Logical.
#'   If `integrity = TRUE`,
#'   check for the output file integrity when `overwrite = FALSE`.
#' @param ncores Positive integer.
#'   Number of cores to use.
#' @param ci Logical.
#'   Run simulations for confidence intervals.
#' @param pb Logical.
#'   Run simulations for parametric bootstrap confidence intervals.
#' @param tasks Positive integer.
#'   Number of tasks.
#' @param reps Positive integer.
#'   Number of replications.
#'
#' @name TemplateIllustration
NULL
