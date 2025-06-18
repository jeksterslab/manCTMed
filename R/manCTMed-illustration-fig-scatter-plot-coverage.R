#' Illustration Plot Coverage Probabilities
#'
#' Coverage probabilities for the model \eqn{X \to M \to Y}.
#'
#' @author Ivan Jacob Agaloos Pesigan
#'
#' @param illustration_results Summary results data frame.
#'
#' @examples
#' data(illustration_results, package = "manCTMed")
#' IllustrationFigScatterPlotCoverage(illustration_results)
#'
#' @family Figure Functions
#' @keywords manCTMed figure illustration
#' @export
IllustrationFigScatterPlotCoverage <- function(illustration_results) {
  interval <- coverage <- NULL
  Method <- as.character(
    illustration_results$method
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
    test = Method == "pbbc",
    yes = "PBBC",
    no = Method
  )
  Method <- ifelse(
    test = Method == "pbpc",
    yes = "PBPC",
    no = Method
  )
  illustration_results$Method <- Method
  effect_label <- as.character(
    illustration_results$effect
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
  illustration_results$effect_label <- effect_label
  Std <- illustration_results$std
  Std <- ifelse(
    test = Std == TRUE,
    yes = "Standardized",
    no = "Unstandardized"
  )
  illustration_results$Std <- Std
  ggplot2::ggplot(
    data = illustration_results,
    ggplot2::aes(
      x = interval,
      y = coverage,
      shape = Method,
      color = Method,
      group = Method,
      linetype = Method
    )
  ) +
    ggplot2::geom_hline(
      yintercept = 0.95,
      alpha = 0.5
    ) +
    ggplot2::geom_hline(
      yintercept = 0.925,
      alpha = 0.5
    ) +
    ggplot2::geom_hline(
      yintercept = 0.975,
      alpha = 0.5
    ) +
    ggplot2::annotate(
      geom = "rect",
      fill = "grey",
      alpha = 0.50,
      xmin = -Inf,
      xmax = Inf,
      ymin = 0.925,
      ymax = 0.975
    ) +
    ggplot2::geom_point(
      na.rm = TRUE
    ) +
    ggplot2::geom_line(
      na.rm = TRUE
    ) +
    ggplot2::facet_grid(
      Std ~ effect_label
    ) +
    ggplot2::xlab(
      "Time-Interval"
    ) +
    ggplot2::ylab(
      "Coverage Probability"
    ) +
    ggplot2::theme_bw() +
    ggplot2::scale_color_brewer(palette = "Set1") +
    ggplot2::scale_shape()
}
