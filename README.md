
# avaols

<!-- badges: start -->
[![Codecov test coverage](https://codecov.io/gh/bhvieira/avaols/branch/main/graph/badge.svg)](https://app.codecov.io/gh/bhvieira/avaols?branch=main)
[![Lifecycle: experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://lifecycle.r-lib.org/articles/stages.html#experimental)
[![check-standard](https://github.com/bhvieira/avaols/actions/workflows/check-standard.yaml/badge.svg)](https://github.com/bhvieira/avaols/actions/workflows/check-standard.yaml)
[![test-coverage](https://github.com/bhvieira/avaols/actions/workflows/test-coverage.yaml/badge.svg)](https://github.com/bhvieira/avaols/actions/workflows/test-coverage.yaml)
<!-- badges: end -->

`avaols` provides a simple interface to efficiently estimate ordinary least squares models relating each column of a data frame to all the others.
This situation corresponds to a (weighted) complete digraph Gaussian linear model with `k` nodes.

## Installation

You can install the development version of `avaols` from [GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("bhvieira/avaols")
```

## Example

This is a basic example which shows you how to estimate a linear model relating each column of a data frame to the others: 

``` r
library(avaols)

X <- data.frame(matrix(rnorm(100), ncol = 5))
avaols(X)
```

