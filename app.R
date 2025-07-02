# Load required packages
library(shiny)
library(ggplot2)

# Black-Scholes Call Option Pricing Formula
black_scholes_call <- function(S, K, r, T, sigma) {
  d1 <- (log(S / K) + (r + 0.5 * sigma^2) * T) / (sigma * sqrt(T))
  d2 <- d1 - sigma * sqrt(T)
  return(S * pnorm(d1) - K * exp(-r * T) * pnorm(d2))
}

# Black-Scholes Delta
black_scholes_delta <- function(S, K, r, T, sigma) {
  d1 <- (log(S / K) + (r + 0.5 * sigma^2) * T) / (sigma * sqrt(T))
  return(pnorm(d1))
}

#  UI: Inputs + Plots
ui <- fluidPage(
  titlePanel("Delta Hedging Simulation (Black-Scholes)"),
  sidebarLayout(
    sidebarPanel(
      numericInput("S0", "Initial Stock Price (S₀):", value = 100),
      numericInput("K", "Strike Price (K):", value = 100),
      numericInput("r", "Risk-Free Rate (r) (2% = 0.2):", value = 0.01, step = 0.001),
      numericInput("T", "Time to Maturity (T in years):", value = 1),
      numericInput("sigma", "Volatility (σ):", value = 0.2, step = 0.01),
      numericInput("n_days", "Number of Trading Days:", value = 252),
      actionButton("run", "Run Simulation ")
    ),
    mainPanel(
      plotOutput("errorPlot"),
      plotOutput("portfolioPlot")
    )
  )
)

# Server Logic
server <- function(input, output) {
  observeEvent(input$run, {
    # 1. Extract user inputs
    S0 <- input$S0
    K <- input$K
    r <- input$r
    T <- input$T
    sigma <- input$sigma
    n_days <- input$n_days
    dt <- T / n_days
    
    # 2. Simulate stock price path (Geometric Brownian Motion)
    set.seed(42)  # reproducibility
    Z <- rnorm(n_days)
    S <- numeric(n_days)
    S[1] <- S0
    for (t in 2:n_days) {
      S[t] <- S[t-1] * exp((r - 0.5 * sigma^2) * dt + sigma * sqrt(dt) * Z[t-1])
    }
    
    # 3. Initialize vectors
    option_prices <- numeric(n_days)
    delta_hedge <- numeric(n_days)
    cash_account <- numeric(n_days)
    portfolio_value <- numeric(n_days)
    
    # 4. Initial hedge
    delta_hedge[1] <- black_scholes_delta(S[1], K, r, T, sigma)
    option_prices[1] <- black_scholes_call(S[1], K, r, T, sigma)
    cash_account[1] <- option_prices[1] - delta_hedge[1] * S[1]
    portfolio_value[1] <- delta_hedge[1] * S[1] + cash_account[1]
    
    # 5. Daily rebalancing
    for (t in 2:n_days) {
      tau <- (n_days - t + 1) * dt  # time remaining
      option_prices[t] <- black_scholes_call(S[t], K, r, tau, sigma)
      new_delta <- black_scholes_delta(S[t], K, r, tau, sigma)
      delta_change <- new_delta - delta_hedge[t-1]
      cash_account[t] <- cash_account[t-1] * exp(r * dt) - delta_change * S[t]
      delta_hedge[t] <- new_delta
      portfolio_value[t] <- delta_hedge[t] * S[t] + cash_account[t]
    }
    
    # 6. Build dataframe for plotting
    df <- data.frame(
      Day = 1:n_days,
      HedgingError = portfolio_value - option_prices,
      PortfolioValue = portfolio_value,
      OptionValue = option_prices
    )
    
    # 7. Plot: Hedging Error Over Time
    output$errorPlot <- renderPlot({
      ggplot(df, aes(x = Day, y = HedgingError)) +
        geom_line(color = "red", linewidth = 1) +
        labs(title = "Delta Hedging Error Over Time", x = "Day", y = "Error") +
        theme_minimal()
    })
    
    # 8. Plot: Portfolio Value vs. Option Price
    output$portfolioPlot <- renderPlot({
      ggplot(df, aes(x = Day)) +
        geom_line(aes(y = PortfolioValue), color = "green", linetype = "dashed", linewidth = 1) +
        geom_line(aes(y = OptionValue), color = "blue", linewidth = 1) +
        labs(title = "Hedged Portfolio vs. Option Value", x = "Day", y = "Value") +
        theme_minimal()
    })
  })
}

# Launch the app
shinyApp(ui = ui, server = server)
