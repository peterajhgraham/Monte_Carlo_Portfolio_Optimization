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

## Installation

To get started with this portfolio optimization tool in R, follow these steps:

1. **Clone the repository**:
   ```bash
   git clone https://github.com/peterajhgraham/Monte_Carlo_Portfolio_Optimization.git
   ```
2. **Navigate to the repository's directory**:
   ```bash
   cd Monte_Carlo_Portfolio_Optimization
   ```
3. **Install the required R packages**:
   ```bash
   "install.packages(c('quantmod', 'data.table', 'Matrix', 'ggplot2', 'PerformanceAnalytics', 'testthat'))"
   ```
## Usage

1. **Run the Monte Carlo Simulation**:
  ```bash
  source("src/Monte_Carlo_Simulation.R")
  ```

2. **Optomize the portfolio**:
  ```bash
  source("src/Portfolio_Optimization.R")
  ```

3. **Visualize the results**:
  ```bash
  source("src/Visualization.R")
  ```
