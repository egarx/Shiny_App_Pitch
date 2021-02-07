

library(shiny)

shinyUI(fluidPage(
  titlePanel("Some Stocks Correlation Matrix"),
  sidebarLayout(
    sidebarPanel(
      sliderInput("slider_Size", "What is the sample size?", 100, 1400, value = 1),
      checkboxInput("GOOG_", "GOOGLE", value = TRUE),
      checkboxInput("FB_", "FACEBOOK", value = TRUE),
      checkboxInput("AAPL_", "APPLE", value = TRUE),
      checkboxInput("BA_", "BOEING", value = TRUE),
      checkboxInput("C_", "CITI", value = TRUE)
            ),
    mainPanel(
      h3("Matrix Output:"),
      tableOutput('table'),
      )
  )
))