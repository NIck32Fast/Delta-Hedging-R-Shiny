# Delta Hedging Simulation App (Black-Scholes)

This Shiny web app simulates a dynamically delta-hedged portfolio for a European call option using the Black-Scholes model. It demonstrates the power of quantitative finance techniques in managing directional risk.

## Features

-  Interactive user input for stock price, volatility, strike, maturity, etc.
-  Live Black-Scholes pricing and delta computation
-  Dynamic delta hedging and portfolio rebalancing
-  Real-time visualization of hedging error and portfolio value

## How It Works

1. Simulate a stock path using geometric Brownian motion
2. Price the call option and calculate delta each day
3. Construct a hedge portfolio (long delta shares, short option, cash position)
4. Rebalance daily to stay delta-neutral
5. Track and visualize hedging performance

## Visual Output

- **Hedging Error Plot**: Difference between the portfolio value and option price
- **Portfolio vs Option Plot**: How closely the hedge tracks the theoretical option

## Getting Started

Install required packages:

```r
install.packages("shiny")
install.packages("ggplot2")
