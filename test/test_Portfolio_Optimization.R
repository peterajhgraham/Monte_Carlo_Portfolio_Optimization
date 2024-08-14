library(testthat)
source("Monte_Carlo_Portfolio_Optimization/src/Portfolio_Optimization.R")

test_that("Portfolio optimization works correctly", {
  returns <- matrix(rnorm(252 * 5), nrow = 252, ncol = 5)
  optimal_weights <- optimize_portfolio(returns)
  
  expect_equal(length(optimal_weights), 5)
  expect_equal(sum(optimal_weights), 1, tolerance = 1e-6)
})

test_that("Portfolio performance evaluation works correctly", {
  set.seed(123)
  returns <- matrix(rnorm(252 * 5), nrow = 252, ncol = 5)
  weights <- rep(1/5, 5)
  performance <- evaluate_portfolio_performance(returns, weights)
  
  expect_true(is.list(performance))
  expect_true("performance" %in% names(performance))
  expect_true("risk" %in% names(performance))
})
