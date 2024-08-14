# Portfolio Optimization with Monte Carlo Simulations

This repository serves as an investment analysis tool, employing Monte Carlo simulations designed to optimize asset allocation strategies using historical market data to enhance risk-adjusted returns.

## Directory Structure

```
Monte_Carlo_Portfolio_Optimization/
├── src/
│   ├── Monte_Carlo_Simulation.R
│   ├── Portfolio_Optimization.R
│   └── Utility_Functions.R
├── test/
│   ├── test_Monte_Carlo_Simulation.R
│   ├── test_Portfolio_Optimization.R
│   └── test_Utility_Functions.R
├── data/
│   └── Historical_Prices.csv  # This can be used for offline data
├── Project.Rproj
├── LICENSE
├── .gitignore
└── README.md
```

## Usage

1. Install required R packages: `quantmod`, `data.table`, `Matrix`, `ggplot2`, `PerformanceAnalytics`, `testthat`.
2. Load the functions from `src/` as needed.
3. Use the `monte_carlo_simulation()` function to simulate asset returns.
4. Use the `optimize_portfolio()` function to optimize your portfolio based on the simulated returns.
5. Use `get_stock_data()` to load and prepare historical price data.
6. Visualize results using `plot_simulation_results()`.
7. Analyze performance metrics using `calculate_performance_metrics()` and `evaluate_portfolio_performance()`.
