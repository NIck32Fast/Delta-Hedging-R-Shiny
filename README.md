# Delta Hedging Simulator in R Shiny

![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)
![Built with R](https://img.shields.io/badge/Built%20with-R-276DC3?logo=r)
![Shiny](https://img.shields.io/badge/Interactive-Shiny-orange)
![Finance](https://img.shields.io/badge/Model-Black--Scholes-blue)

This is an interactive application that simulates a delta-hedged portfolio for a European call option using the Black-Scholes model. Built with R and Shiny, the project brings core financial engineering concepts to life through simulation and visualization.

---

## Features

- Accepts user inputs for: initial stock price, strike price, interest rate, time to maturity, volatility, and number of trading days
- Simulates a stock price path using geometric Brownian motion
- Prices the European call option using the Black-Scholes model
- Recalculates delta daily and dynamically rebalances the portfolio
- Visualizes:
  - Hedging error over time
  - Portfolio value versus theoretical option value

---

## How to Run

### 1. Install required packages

```r
install.packages("shiny")
install.packages("ggplot2")
