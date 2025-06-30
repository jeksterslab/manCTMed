#' Plot Type I Error
#'
#' Type I error for the model \eqn{Y \to M \to X}.
#'
#' @author Ivan Jacob Agaloos Pesigan
#'
#' @inheritParams FigScatterPlotCoverage
#'
#' @examples
#' data(results, package = "manCTMed")
#' FigScatterPlotType1(results)
#' FigScatterPlotType1(results, delta_t = 1:14)
#' FigScatterPlotType1(results, delta_t = 15:30)
#'
#' @family Figure Functions
#' @keywords manCTMed figure
#' @export
FigScatterPlotType1 <- function(results,
                                delta_t = NULL,
                                dynamics = 0,
                                std = FALSE) {
  results <- results[which(results$dynamics == dynamics), ]
  results <- results[which(results$std == std), ]
  if (!is.null(delta_t)) {
    results <- results[which(results$interval %in% delta_t), ]
  }
  interval <- theta_hit <- NULL
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
      y = 1 - theta_hit,
      shape = Method,
      color = Method,
      group = Method,
      linetype = Method
    )
  ) +
    ggplot2::geom_hline(
      yintercept = 1 - 0.95,
      alpha = 0.5
    ) +
    ggplot2::geom_hline(
      yintercept = 1 - 0.925,
      alpha = 0.5
    ) +
    ggplot2::geom_hline(
      yintercept = 1 - 0.975,
      alpha = 0.5
    ) +
    ggplot2::annotate(
      geom = "rect",
      fill = "grey",
      alpha = 0.50,
      xmin = -Inf,
      xmax = Inf,
      ymin = 1 - 0.975,
      ymax = 1 - 0.925
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
      "Type I Error"
    ) +
    ggplot2::theme_bw() +
    ggplot2::scale_color_brewer(palette = "Set1") +
    ggplot2::scale_shape()
}
