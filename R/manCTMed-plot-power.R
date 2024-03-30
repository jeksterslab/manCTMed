#' Plot Statistical Power
#'
#' @author Ivan Jacob Agaloos Pesigan
#'
#' @param x Summary results data frame.
#'
#' @family Simulation Functions
#' @keywords manCTMed
#' @export
PlotPower <- function(x) {
  interval <- zero_hit <- NULL
  x <- x[which(x$xmy), ]
  Method <- as.character(
    x$method
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
  x$Method <- Method
  effect_label <- as.character(
    x$effect
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
  x$effect_label <- effect_label
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
      y = 1 - zero_hit,
      shape = Method,
      color = Method,
      group = Method,
      linetype = Method
    )
  ) +
    ggplot2::geom_hline(
      yintercept = 0.80,
      alpha = 0.5
    ) +
    ggplot2::geom_point() +
    ggplot2::geom_line() +
    ggplot2::facet_grid(
      n_label ~ effect_label
    ) +
    ggplot2::xlab(
      "Time-Interval"
    ) +
    ggplot2::ylab(
      "Statistical Power"
    ) +
    ggplot2::theme_bw() +
    ggplot2::scale_color_brewer(palette = "Set1") +
    ggplot2::scale_shape()
  return(p)
}
