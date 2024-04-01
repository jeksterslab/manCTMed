#' Plot Total, Direct, and Indirect Effects
#'
#' Effects for the model \eqn{X \to M \to Y}.
#'
#' @author Ivan Jacob Agaloos Pesigan
#'
#' Total, direct, and indirect effects for the drift matrix
#' \deqn{
#'     \left(
#'     \begin{array}{ccc}
#'          -0.357 & 0 & 0 \\
#'          0.771 & -0.511 & 0 \\
#'          -0.450 & 0.729 & -0.693 \\
#'     \end{array}
#'     \right)
#' }
#'
#' @examples
#' FigPlotEffects()
#'
#' @family Figure Functions
#' @keywords manCTMed figure
#' @import cTMed
#' @export
FigPlotEffects <- function() {
  phi <- model$phi
  colnames(phi) <- rownames(phi) <- c(
    "x",
    "m",
    "y"
  )
  plot(
    cTMed::Med(
      phi = phi,
      from = "x",
      to = "y",
      med = "m",
      delta_t = seq(
        from = 0,
        to = 30,
        length.out = 1000
      )
    )
  )
}
