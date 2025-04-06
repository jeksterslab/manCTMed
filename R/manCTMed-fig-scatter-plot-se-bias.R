#' Plot Standard Error Bias
#'
#' Standard Error Bias for the model \eqn{X \to M \to Y}.
#'
#' @author Ivan Jacob Agaloos Pesigan
#'
#' @inheritParams FigScatterPlotCoverage
#'
#' @examples
#' data(results, package = "manCTMed")
#' FigScatterPlotSeBias(results)
#'
#' @family Figure Functions
#' @keywords manCTMed figure
#' @export
FigScatterPlotSeBias <- function(results,
                                 delta_t = NULL,
                                 dynamics = 0,
                                 std = FALSE) {
  results <- results[which(results$dynamics == dynamics), ]
  results <- results[which(results$std == std), ]
  if (!is.null(delta_t)) {
    results <- results[which(results$interval %in% delta_t), ]
  }
  interval <- se_bias <- NULL
  results <- results[which(results$xmy == FALSE), ]
  Method <- as.character(
    results$method
  )
  Method <- ifelse(
    test = Method == "delta",
    yes = "Delta",
    no = Method
  )
  Method <- ifelse(
    test = Method == "mc",
    yes = "MC",
    no = Method
  )
  Method <- ifelse(
    test = results$std,
    yes = paste0(Method, " (std)"),
    no = Method
  )
  results$Method <- Method
  effect_label <- as.character(
    results$effect
  )
  effect_label <- ifelse(
    test = effect_label == "total",
    yes = "Total Effect",
    no = effect_label
  )
  effect_label <- ifelse(
    test = effect_label == "direct",
    yes = "Direct Effect",
    no = effect_label
  )
  effect_label <- ifelse(
    test = effect_label == "indirect",
    yes = "Indirect Effect",
    no = effect_label
  )
  results$effect_label <- effect_label
  results$n_label <- paste0(
    "n = ",
    results$n
  )
  results$n_label <- factor(
    results$n_label,
    levels = c(
      paste0(
        "n = ",
        sort(unique(results$n))
      )
    )
  )
  ggplot2::ggplot(
    data = results,
    ggplot2::aes(
      x = interval,
      y = se_bias,
      shape = Method,
      color = Method,
      group = Method,
      linetype = Method
    )
  ) +
    ggplot2::geom_hline(
      yintercept = 0.0,
      alpha = 0.5
    ) +
    ggplot2::geom_point(
      na.rm = TRUE
    ) +
    ggplot2::geom_line(
      na.rm = TRUE
    ) +
    ggplot2::facet_grid(
      n_label ~ effect_label
    ) +
    ggplot2::xlab(
      "Time-Interval"
    ) +
    ggplot2::ylab(
      "Standard Error Bias"
    ) +
    ggplot2::theme_bw() +
    ggplot2::scale_color_brewer(palette = "Set1") +
    ggplot2::scale_shape()
}
