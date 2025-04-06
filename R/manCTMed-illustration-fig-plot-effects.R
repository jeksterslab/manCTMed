#' Plot Total, Direct, and Indirect Effects (Illustration)
#'
#' Effects for the model \eqn{X \to M \to Y}.
#'
#' @author Ivan Jacob Agaloos Pesigan
#'
#' @param std Logical.
#'   If `std = TRUE`, standardized total, direct, and indirect effects.
#'   If `std = FALSE`, unstandardized total, direct, and indirect effects.
#' @param max_delta_t Numeric.
#'   Maximum time interval.
#'
#' @examples
#' IllustrationFigPlotEffects(std = FALSE)
#' IllustrationFigPlotEffects(std = TRUE)
#'
#' @family Figure Functions
#' @keywords manCTMed figure
#' @import cTMed
#' @export
IllustrationFigPlotEffects <- function(std = FALSE,
                                       max_delta_t = 30) {
  phi <- matrix(
    data = c(
      -0.138,
      -0.124,
      -0.057,
      0,
      -0.865,
      0.115,
      0,
      0.434,
      -0.693
    ),
    nrow = 3,
    ncol = 3
  )
  sigma <- 0.10 * diag(3)
  legend_pos <- "bottomright"
  colnames(phi) <- rownames(phi) <- c(
    "x",
    "m",
    "y"
  )
  if (std) {
    cat("\nphi:\n")
    print(phi)
    cat("\nsigma:\n")
    print(sigma)
    plot(
      cTMed::MedStd(
        phi = phi,
        sigma = sigma,
        from = "x",
        to = "y",
        med = "m",
        delta_t = seq(
          from = 0,
          to = max_delta_t,
          length.out = 1000
        )
      ),
      legend_pos = legend_pos
    )
  } else {
    cat("\nphi:\n")
    print(phi)
    plot(
      cTMed::Med(
        phi = phi,
        from = "x",
        to = "y",
        med = "m",
        delta_t = seq(
          from = 0,
          to = max_delta_t,
          length.out = 1000
        )
      ),
      legend_pos = legend_pos
    )
  }
}
