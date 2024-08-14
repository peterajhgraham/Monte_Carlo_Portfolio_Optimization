library(testthat)
source("Monte_Carlo_Portfolio_Optimization/src/Utility_Functions.R")

test_that("Utility functions work correctly", {
  # Fetch some sample data
  ticker <- "AAPL"
  start_date <- "2020-01-01"
  end_date <- "2023-01-01"
  
  # Use a smaller time range or different ticker if needed
  apple_data <- get_stock_data(ticker, start_date, end_date)
  
  expect_true(nrow(apple_data) > 0)
  expect_true(ncol(apple_data) > 1)
  
  # Check the data preparation function
  prepared_data <- prepare_data_for_analysis(apple_data)
  expect_true("Date" %in% names(prepared_data))
  expect_true("Adjusted" %in% names(prepared_data))
})
