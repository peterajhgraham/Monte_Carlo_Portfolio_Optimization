library(quantmod)
library(data.table)
library(Matrix)
library(ggplot2)
library(PerformanceAnalytics)

# Function to perform Monte Carlo simulation
monte_carlo_simulation <- function(returns, num_simulations = 1000, num_days = 252) {
  num_assets <- ncol(returns)
  results <- matrix(nrow = num_simulations, ncol = num_assets)
  
  for (i in 1:num_simulations) {
    simulated_returns <- matrix(rnorm(num_days * num_assets), nrow = num_days, ncol = num_assets)
    results[i, ] <- colMeans(simulated_returns)
  }
  
  colnames(results) <- colnames(returns)
  results
}

# Function to plot Monte Carlo simulation results
plot_simulation_results <- function(results) {
  results_df <- as.data.table(results)
  results_melted <- melt(results_df, variable.name = "Asset", value.name = "Return")
  
  ggplot(results_melted, aes(x = Return, fill = Asset)) +
    geom_density(alpha = 0.5) +
    theme_minimal() +
    labs(title = "Monte Carlo Simulation Results",
         x = "Simulated Return",
         y = "Density")
}

# Function to calculate performance metrics
calculate_performance_metrics <- function(returns) {
  return_table <- table.Stats(returns)
  return(return_table)
}
