globalVariables(c(".",
                  ".SD",
                  "aem",
                  "boundary",
                  "Brier_score",
                  "count",
                  "coverage_deviation",
                  "CRPS",
                  "DSS",
                  "identif",
                  "Interval_Score",
                  "overprediction",
                  "underprediction",
                  "quantile_coverage",
                  "LogS",
                  "calibration",
                  "coverage",
                  "hist",
                  "id",
                  "log_score",
                  "lower",
                  "metric",
                  "metrics_select",
                  "model",
                  "pit_p_val",
                  "prediction",
                  "quantile",
                  "rn",
                  "true_value",
                  "type",
                  "upper",
                  "value",
                  "value_scaled",
                  "variable",
                  "x",
                  "y",
                  "g"))


list_of_avail_metrics <- function() {
  available_metrics <- c("ae", "log_score", "sharpness", "bias", "dss", "crps",
                         "coverage", "coverage_deviation", "quantile_coverage",
                         "pit_p_val", "pit_sd","interval_score",
                         "underprediction", "overprediction")

  return(available_metrics)
}
