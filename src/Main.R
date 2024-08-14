# Load required libraries
library(quantmod)
library(ggplot2)
library(PerformanceAnalytics)
library(data.table)
library(Matrix)

# Define constants
ASSETS <- c('AAPL', 'MSFT', 'AGG', 'GLD', 'AMD', 'NVDA', 'TGT')
START_DATE <- '2020-01-01'
END_DATE <- '2023-01-01'
MARKET_REPRESENTATION <- 'SPY'
NUM_PORTFOLIOS <- 100000
RISK_FREE_RATE <- 0  # Assuming risk-free rate is 0 for simplicity

# Data Collection for Assets
get_data <- function(tickers, start_date, end_date) {
  data <- lapply(tickers, function(ticker) {
    stock_data <- getSymbols(ticker, src = "yahoo", from = start_date, to = end_date, auto.assign = FALSE)
    Ad(stock_data)
  })
  do.call(merge, data)
}
data <- get_data(ASSETS, START_DATE, END_DATE)

# Data Collection for Market (SPY)
market_data <- getSymbols(MARKET_REPRESENTATION, src = "yahoo", from = START_DATE, to = END_DATE, auto.assign = FALSE)
market_data <- Ad(market_data)

# Calculate daily returns
daily_returns <- na.omit(Return.calculate(data, method = "log"))

# Create a covariance matrix
cov_matrix <- cov(daily_returns)

# Calculating Market Performance (SPY)
market_daily_returns <- na.omit(Return.calculate(market_data, method = "log"))
market_return <- mean(market_daily_returns) * 252  # Annualized return
market_volatility <- sd(market_daily_returns) * sqrt(252)  # Annualized volatility
market_sharpe_ratio <- (market_return - RISK_FREE_RATE) / market_volatility  # Sharpe ratio

# Monte Carlo Simulation
results <- matrix(0, nrow = 4, ncol = NUM_PORTFOLIOS)
weights_record <- matrix(0, nrow = length(ASSETS), ncol = NUM_PORTFOLIOS)

set.seed(123)  # For reproducibility
for (i in 1:NUM_PORTFOLIOS) {
  # Random weights
  weights <- runif(length(ASSETS))
  weights <- weights / sum(weights)
  weights_record[, i] <- weights
  
  # Annualized portfolio return
  portfolio_return <- sum(weights * colMeans(daily_returns)) * 252
  
  # Annualized portfolio volatility
  portfolio_stddev <- sqrt(t(weights) %*% cov_matrix %*% weights) * sqrt(252)
  
  # Sharpe ratio (assuming risk-free rate is 0 for simplicity)
  sharpe_ratio <- (portfolio_return - RISK_FREE_RATE) / portfolio_stddev
  
  results[, i] <- c(portfolio_return, portfolio_stddev, sharpe_ratio, i)
}

# Convert results to a DataFrame
simulated_portfolios <- as.data.table(t(results))
setnames(simulated_portfolios, c('Return', 'Volatility', 'Sharpe Ratio', 'Simulation'))

# Find the portfolio with the highest Sharpe ratio
optimal_idx <- which.max(simulated_portfolios$`Sharpe Ratio`)
optimal_portfolio <- simulated_portfolios[optimal_idx]
optimal_weights <- weights_record[, optimal_idx]

# Visualization
ggplot(simulated_portfolios, aes(x = Volatility, y = Return, color = `Sharpe Ratio`)) +
  geom_point(alpha = 0.5) +
  scale_color_gradient(low = "yellow", high = "blue") +
  geom_point(aes(x = market_volatility, y = market_return), color = 'red', size = 3, shape = 21, fill = 'red') +  # Market performance
  geom_point(aes(x = optimal_portfolio$Volatility, y = optimal_portfolio$Return), color = 'green', size = 3, shape = 8) +  # Optimal portfolio
  labs(title = "Efficient Frontier",
       x = "Volatility",
       y = "Return",
       color = "Sharpe Ratio") +
  theme_minimal() +
  annotate("text", x = market_volatility, y = market_return, label = sprintf("Market (%s)\nReturn: %.2f%%\nVolatility: %.2f%%\nSharpe Ratio: %.2f", MARKET_REPRESENTATION, market_return * 100, market_volatility * 100, market_sharpe_ratio), color = "red", size = 3, hjust = 0) +
  annotate("text", x = optimal_portfolio$Volatility, y = optimal_portfolio$Return, label = sprintf("Optimal Portfolio\nReturn: %.2f%%\nVolatility: %.2f%%\nSharpe Ratio: %.2f", optimal_portfolio$Return * 100, optimal_portfolio$Volatility * 100, optimal_portfolio$`Sharpe Ratio`), color = "green", size = 3, hjust = 0) +
  theme(plot.title = element_text(hjust = 0.5))
