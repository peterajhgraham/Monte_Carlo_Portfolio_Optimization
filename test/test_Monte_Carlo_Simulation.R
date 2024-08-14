library(testthat)
source("Monte_Carlo_Portfolio_Optimization/src/Monte_Carlo_Simulation.R")

test_that("Monte Carlo simulation works correctly", {
  set.seed(123)
  returns <- matrix(rnorm(252 * 5), nrow = 252, ncol = 5)
  result <- monte_carlo_simulation(returns, num_simulations = 10, num_days = 252)
  
  expect_equal(nrow(result), 10)
  expect_equal(ncol(result), 5)
})

test_that("Monte Carlo simulation plotting works", {
  set.seed(123)
  returns <- matrix(rnorm(252 * 5), nrow = 252, ncol = 5)
  result <- monte_carlo_simulation(returns, num_simulations = 10, num_days = 252)
  
  expect_silent(plot_simulation_results(result))
})

test_that("Performance metrics calculation works", {
  set.seed(123)
  returns <- matrix(rnorm(252 * 5), nrow = 252, ncol = 5)
  metrics <- calculate_performance_metrics(returns)
  
  expect_true(is.list(metrics))
  expect_true("Mean" %in% names(metrics))
})
