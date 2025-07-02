# Delta Hedging Simulator in R Shiny  
![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)  
![Built with R](https://img.shields.io/badge/Built%20with-R-276DC3?logo=r) ![Shiny](https://img.shields.io/badge/Interactive-Shiny-orange) ![Finance](https://img.shields.io/badge/Model-Black--Scholes-blue)

> A hands-on project that brings theory to life: dynamic delta hedging of a European call option using the Black-Scholes model and geometric Brownian motion — entirely built in R and Shiny.

---

## What It Does

This interactive app simulates a **delta-hedged trading strategy**.  
It tracks the performance of a portfolio hedging a European call option in real time and visualizes:

- The option price over time (via Black-Scholes)
- The value of the dynamically hedged portfolio
- The **hedging error** from rebalancing daily

---

## 🔧 How It Works

1. Simulate a stock price path using **Geometric Brownian Motion**
2. Calculate the **Black-Scholes option price** and **delta** every day
3. Adjust the portfolio by:
   - Buying or selling delta shares
   - Updating the cash position (interest-bearing)
4. Plot:
   - **Delta Hedging Error**
   - 📊 **Portfolio vs Option Price**

---

## Try It Yourself

### 1. Install R packages:

```r
install.packages("shiny")
install.packages("ggplot2")
