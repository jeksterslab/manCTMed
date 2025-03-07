#' Plot Total, Direct, and Indirect Effects
#'
#' Effects for the model \eqn{X \to M \to Y}.
#'
#' @author Ivan Jacob Agaloos Pesigan
#'
#' @param dynamics Integer.
#'   `dynamics = 0` for original drift matrix,
#'   `dynamics = -1` for near-neutral dynamics, and
#'   `dynamics = 1` for stronger damping.
#' @param std Logical.
#'   If `std = TRUE`, standardized total, direct, and indirect effects.
#'   If `std = FALSE`, unstandardized total, direct, and indirect effects.
#' @param max_delta_t Numeric.
#'   Maximum time interval.
#'
#' @examples
#' FigPlotEffects()
#'
#' @family Figure Functions
#' @keywords manCTMed figure
#' @import cTMed
#' @export
FigPlotEffects <- function(dynamics = 0,
                           std = FALSE,
                           max_delta_t = 30) {
  if (dynamics == 0) {
    phi <- model$phi_zero
    sigma <- model$sigma_zero
    legend_pos <- "topright"
  }
  if (dynamics == 1) {
    phi <- model$phi_pos
    sigma <- model$sigma_pos
    legend_pos <- "topright"
  }
  if (dynamics == -1) {
    phi <- model$phi_neg
    sigma <- model$sigma_neg
    legend_pos <- "topleft"
  }
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
