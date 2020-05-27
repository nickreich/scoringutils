

# scoringutils: Utilities for Scoring and Assessing Predictions

![R-CMD-check](https://github.com/epiforecasts/scoringutils/workflows/R-CMD-check/badge.svg)
 [![codecov](https://codecov.io/gh/epiforecasts/scoringutils/branch/master/graphs/badge.svg)](https://codecov.io/gh/epiforecasts/scoringutils/) 
<!-- badges: end -->

This package is designed to help with assessing the quality of predictions. It provides a collection of proper scoring rules and metrics that can be accessed independently or collectively through wrapper functions. Predicitions can be either probabilistic forecasts (generally predictive samples generated by Markov Chain Monte Carlo procedures) or point forecasts. The type of the predictions and the true values can be either continuous, integer, or binary. A collection of different metrics and scoring rules can be accessed through the function `eval_forecasts` with the correct prediction type (probabilistic/point prediction, and continuous/integer/binary) specified.

## Installation

Install the stable version of the package using [`{drat}`](https://epiforecasts.io/drat/):

```r
install.packages("drat")
drat::add("epiforecasts")
install.packages("scoringutils")
```

Install the development version of the package with: 

```r
remotes::install_github("epiforecasts/scoringutils")
```

## Supported scores and metrics

### Probabilistic

* `pit_int`/ `pit`
* `bias`
* `sharpness`
* `crps`
* `dss`
* `brier_score`

