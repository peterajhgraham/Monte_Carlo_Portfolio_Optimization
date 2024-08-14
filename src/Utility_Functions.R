library(quantmod)
library(data.table)

# Function to get historical stock data
get_stock_data <- function(ticker, start_date, end_date) {
  # Fetch historical stock data
  stock_data <- getSymbols(ticker, src = "yahoo", from = start_date, to = end_date, auto.assign = FALSE)
  
  # Convert to data frame
  stock_data_df <- as.data.table(stock_data)
  stock_data_df[, Date := index(stock_data)]
  
  # Return the data frame with date
  stock_data_df
}

# Function to clean and prepare data for analysis
prepare_data_for_analysis <- function(data) {
  data[, .(Date, Adjusted = Ad)]
}
