#' Simulate Random Measurement
#'
#' The function randomly selects 100 observations from the generated data
#' and replaces the unselected observations with `NA`.
#'
#' @inheritParams Template
#'
#' @examples
#' \dontrun{
#' set.seed(42)
#' sim <- GenData(taskid = 1)
#' RandomMeasurement(sim)
#' }
#' @family Data Generation Functions
#' @keywords manCTMed gendata
#' @import simStateSpace
#' @export
RandomMeasurement <- function(sim) {
  data <- as.data.frame(sim)
  id <- "id"
  time <- "time"
  observed <- c("x", "m", "y")
  colnames(data) <- c(
    id,
    time,
    observed
  )
  dynUtils::InsertNA(
    data = do.call(
      what = "rbind",
      args = lapply(
        X = dynUtils::SubsetByID(
          data = data,
          id = id,
          time = time,
          observed = observed,
          ncores = NULL
        ),
        FUN = function(x) {
          idx <- c(
            1,
            sort(
              sample(
                x = 2:model$time,
                size = 99,
                replace = FALSE
              )
            )
          )
          x[idx, ]
        }
      )
    ),
    id = id,
    time = time,
    observed = observed,
    delta_t = model$delta_t,
    ncores = NULL
  )
}
