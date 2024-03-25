#' Plot Results
#'
#' @author Ivan Jacob Agaloos Pesigan
#'
#' @param x R object.
#'   Output of the [Summarize()] function.
#'
#' @family Simulation Functions
#' @keywords manCTMed
#' @export
Plot <- function(x) {
  interval <- hit_05 <- Method <- NULL
  x$Method <- x$method
  x$n_label <- paste0(
    "n:",
    x$n
  )
  x$n_label <- factor(
    x$n_label,
    levels = c(
      paste0(
        "n:",
        sort(unique(x$n))
      )
    )
  )
  p <- ggplot2::ggplot(
    data = x,
    ggplot2::aes(
      x = interval,
      y = hit_05,
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
      alpha = 0.75,
      xmin = -Inf,
      xmax = Inf,
      ymin = 0.925,
      ymax = 0.975
    ) +
    ggplot2::geom_point() +
    ggplot2::geom_line() +
    ggplot2::facet_grid(
      n_label ~ effect
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
  return(p)
}
