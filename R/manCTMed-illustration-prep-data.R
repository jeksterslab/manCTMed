#' Prepare Data Before Model Fitting (Illustration)
#'
#' The function converts the output of [IllustrationGenData()]
#' into a data frame.
#'
#' @inheritParams TemplateIllustration
#'
#' @examples
#' \dontrun{
#' sim <- IllustrationGenData(seed = 42)
#' data <- IllustrationPrepData(sim)
#' head(data)
#' dim(data)
#' }
#' @family Model Fitting Functions
#' @keywords manCTMed gendata illustration
#' @import dynr
#' @importFrom stats coef
#' @export
IllustrationPrepData <- function(sim) {
  data <- as.data.frame(sim)
  colnames(data) <- c(
    "id",
    "time",
    "x",
    "m",
    "y"
  )
  data
}
