% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/eval_forecasts.R
\name{eval_forecasts}
\alias{eval_forecasts}
\title{Evaluate forecasts}
\usage{
eval_forecasts(
  data,
  by = NULL,
  summarise_by = by,
  quantiles = c(),
  sd = FALSE,
  pit_plots = FALSE,
  pit_arguments = list(plot = FALSE),
  interval_score_arguments = list(weigh = TRUE),
  summarised = TRUE,
  verbose = TRUE
)
}
\arguments{
\item{data}{A data.frame or data.table with the predictions and observations.
Note: it is easiest to have a look at the example files provided in the
package and in the examples below.
The following columns need to be present:
\itemize{
  \item \code{true_value} - the true observed values
  \item \code{prediction} - predictions or predictive samples for one
  true value. (You only don't need to provide a prediction column if
  you want to score quantile forecasts in a wide range format.)}
For integer and continuous forecasts a \code{sample} column is needed:
\itemize{
  \item \code{sample} - an index to identify the predictive samples in the
  prediction column generated by one model for one true value. Only
  necessary for continuous and integer forecasts, not for
  binary predictions.}
For quantile forecasts the data can be provided in variety of formats. You
can either use a range-based format or a quantile-based format. (You can
convert between formats using \code{\link{quantile_to_range}},
\code{\link{range_to_quantile}},
\code{\link{sample_to_range}},
\code{\link{sample_to_quantile}})
For a quantile-format forecast you should provide:
\itemize{
  \item {prediction} - prediction to the corresponding quantile
  \item {qunaitle} - quantile to which the prediction corresponds}
For a range format (long) forecast you need
\itemize{
  \item \code{prediction} the quantile forecasts
  \item \code{boundary} values should be either "lower" or "upper", depending
  on whether the prediction is for the lower or upper bound of a given range
  \item {range} the range for which a forecast was made. For a 50\% interval
  the range should be 50. The forecast for the 25\% quantile should have
  the value in the \code{prediction} column, the value of \code{range}
  should be 50 and the value of \code{boundary} should be "lower".
  If you want to score the median (i.e. \code{range = 0}), you still
  need to include a lower and an upper estimate, so the median has to
  appear twice.}
Alternatively you can also provide the format in a wide range format.
This format needs
\itemize{
  \item pairs of columns called something like 'upper_90' and 'lower_90',
  or 'upper_50' and 'lower_50', where the number denotes the interval range.
  For the median, you need to proivde columns called 'upper_0' and 'lower_0'}}

\item{by}{character vector of columns to group scoring by. This should be the
lowest level of grouping possible, i.e. the unit of the individual
observation. This is important as many functions work on individual
observations. If you want a different level of aggregation, you should use
\code{summarise_by} to aggregate the individual scores.
Also not that the pit will be computed using \code{summarise_by}
instead of \code{by}}

\item{summarise_by}{character vector of columns to group the summary by. By
default, this is equal to `by` and no summary takes place.
But sometimes you may want to to summarise
over categories different from the scoring.
\code{summarise_by} is also the grouping level used to compute
(and possibly plot) the probability integral transform(pit).}

\item{quantiles}{numeric vector of quantiles to be returned when summarising.
Instead of just returning a mean, quantiles will be returned for the
groups specified through `summarise_by`. By default, no quantiles are
returned.}

\item{sd}{if TRUE (the default is FALSE) the standard deviation of all
metrics will be returned when summarising.}

\item{pit_plots}{if TRUE (not the default), pit plots will be returned. For
details see \code{\link{pit}}.}

\item{pit_arguments}{pass down additional arguments to the \code{\link{pit}}
function.}

\item{interval_score_arguments}{pass down additional arguments to the
\code{\link{interval_score}} function, e.g. \code{weigh = FAlSE}.}

\item{summarised}{Summarise arguments (i.e. take the mean per group
specified in group_by. Default is TRUE.}

\item{verbose}{print out additional helpful messages (default is TRUE)}
}
\value{
A data.table with appropriate scores. For binary predictions,
the Brier Score will be returned, for quantile predictions the interval
score, as well as adapted metrics for calibration, sharpness and bias.
For integer forecasts, Sharpness, Bias, DSS, CRPS, LogS, and
pit_p_val (as an indicator of calibration) are returned. For integer
forecasts, pit_sd is returned (to account for the randomised PIT),
but no Log Score is returned (the internal estimation relies on a
kernel density estimate which is difficult for integer-valued forecasts).
If \code{summarise_by} is specified differently from \code{by},
the average score per summary unit is returned.
If specified, quantiles and standard deviation of scores can also be returned
when summarising.
}
\description{
The function \code{eval_forecasts} is an easy to use wrapper
of the lower level functions in the \code{scoringutils} package.
It can be used to score probabilistic or quantile forecasts of
continuous, integer-valued or binary variables.
}
\details{
the following metrics are used where appropriate:
\itemize{
  \item {Interval Score} for quantile forecasts. Smaller is better. See
  \code{\link{interval_score}} for more information. By default, the
  weighted interval score is used.
  \item {Brier Score} for a probability forecast of a binary outcome.
  Smaller is better. See \code{\link{brier_score}} for more information.
  \item {aem} Absolute error of the median prediction
  \item {Bias} 0 is good, 1 and -1 are bad.
  See \code{\link{bias}} for more information.
  \item {Sharpness} Smaller is better. See \code{\link{sharpness}} for more
  information.
  \item {Calibration} represented through the p-value of the
  Anderson-Darling test for the uniformity of the Probability Integral
  Transformation (PIT). For integer valued forecasts, this p-value also
  has a standard deviation. Larger is better.
  See \code{\link{pit}} for more information.
  \item {DSS} Dawid-Sebastiani-Score. Smaller is better.
  See \code{\link{dss}} for more information.
  \item {CRPS} Continuous Ranked Probability Score. Smaller is better.
  See \code{\link{crps}} for more information.
  \item {Log Score} Smaller is better. Only for continuous forecasts.
  See \code{\link{logs}} for more information.
}
}
\examples{
## Probability Forecast for Binary Target
binary_example <- data.table::setDT(scoringutils::binary_example_data)
eval <- scoringutils::eval_forecasts(binary_example,
                                     by = c("id", "model", "horizon"),
                                     summarise_by = c("model"),
                                     quantiles = c(0.5), sd = TRUE)
eval <- scoringutils::eval_forecasts(binary_example,
                                     by = c("id", "model", "horizon"))

## Quantile Forecasts
# wide format
quantile_example <- data.table::setDT(scoringutils::quantile_example_data_wide)
eval <- scoringutils::eval_forecasts(quantile_example,
                                     by = c("model", "horizon", "id"),
                                     summarise_by = "model",
                                     quantiles = c(0.05, 0.95),
                                     sd = TRUE)
eval <- scoringutils::eval_forecasts(quantile_example,
                                     by = c("model", "horizon", "id"))

#long format

eval <- scoringutils::eval_forecasts(scoringutils::quantile_example_data_long,
                                     by = c("model", "horizon", "id"),
                                     summarise_by = c("model", "range"))

## Integer Forecasts
integer_example <- data.table::setDT(scoringutils::integer_example_data)
eval <- scoringutils::eval_forecasts(integer_example,
                                     by = c("model", "id", "horizon"),
                                     summarise_by = c("model"),
                                     quantiles = c(0.1, 0.9),
                                     sd = TRUE,
                                     pit_plots = TRUE,
                                     pit_arguments = list(n_replicates = 30,
                                                          plot = TRUE))
eval <- scoringutils::eval_forecasts(integer_example)

## Continuous Forecasts
continuous_example <- data.table::setDT(scoringutils::continuous_example_data)
eval <- scoringutils::eval_forecasts(continuous_example,
                                     by = c("model", "id", "horizon"))
eval <- scoringutils::eval_forecasts(continuous_example,
                                     quantiles = c(0.5, 0.9),
                                     sd = TRUE,
                                     summarise_by = c("model"))

}
\references{
Funk S, Camacho A, Kucharski AJ, Lowe R, Eggo RM, Edmunds WJ
(2019) Assessing the performance of real-time epidemic forecasts: A
case study of Ebola in the Western Area region of Sierra Leone, 2014-15.
PLoS Comput Biol 15(2): e1006785.
\url{https://doi.org/10.1371/journal.pcbi.1006785}
}
\author{
Nikos Bosse \email{nikosbosse@gmail.com}
}
