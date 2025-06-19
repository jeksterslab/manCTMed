.ResultsTable <- function(results,
                          value = "theta_hit",
                          effect = "direct",
                          dynamics = 0,
                          xmy = TRUE,
                          n = c(100, 200, 300, 400),
                          interval = c(1, 10, 20, 30)) {
  # Helper function to filter data by n, dynamics, and interval
  filter_data <- function(data,
                          n_value,
                          dynamics_value,
                          intervals) {
    filtered <- data[
      data$n == n_value &
        data$xmy == xmy &
        data$dynamics == dynamics_value &
        data$interval %in% intervals,
    ]
    filtered
  }

  # Helper function to extract subgroups
  extract_group <- function(data,
                            effect_type,
                            method_type,
                            std_value) {
    group <- data[
      data$effect == effect_type &
        data$method == method_type &
        data$std == std_value,
    ]
    group[, c("interval", value)]
  }

  # List to hold results for all n values
  combined_list <- list()

  for (n_val in n) {
    n_data <- filter_data(
      results,
      n_val,
      dynamics,
      interval
    )

    # Extract subgroups
    delta_unstd <- extract_group(n_data, effect, "delta", FALSE)
    delta_std <- extract_group(n_data, effect, "delta", TRUE)
    mc_unstd <- extract_group(n_data, effect, "mc", FALSE)
    mc_std <- extract_group(n_data, effect, "mc", TRUE)

    # Add extracted groups to the combined list
    combined_list <- c(
      combined_list,
      list(
        delta_unstd,
        mc_unstd,
        delta_std,
        mc_std
      )
    )
  }

  # Combine all results into a single data frame
  combined <- suppressWarnings(
    Reduce(
      function(x, y) {
        merge(x, y, by = "interval")
      },
      combined_list
    )
  )

  # Sort the combined data by interval
  combined <- combined[order(combined$interval), ]

  combined
}
