

library(shiny)
library(datasets)
library(caret)
library(quantmod)
library(dplyr)

shinyServer(function(input, output) {

  from.dat <- as.Date("01/01/17", format="%m/%d/%y")
  
  to.dat <- as.Date("01/01/21", format="%m/%d/%y")
  
  getSymbols(c("GOOG","AAPL","FB","BA","C"), src="yahoo", from = from.dat, to = to.dat)
  
  GOOG <- GOOG %>% as.data.frame()
  AAPL <- AAPL %>% as.data.frame()
  FB <- FB %>% as.data.frame()
  BA <- BA %>% as.data.frame()
  C <- C %>% as.data.frame()
  
  fecha <- rownames(FB) 
  
  stocks <- data.frame(Fecha=fecha[-1],AAPL=diff(log(AAPL$AAPL.Close),1),
                       GOOG=diff(log(GOOG$GOOG.Close),1),
                       FB=diff(log(FB$FB.Close),1),
                       BA=diff(log(BA$BA.Close),1),
                       C=diff(log(C$C.Close),1))

  model <- reactive({
    s <- input$slider_Size
    stocks4corr <- stocks %>% select("AAPL","GOOG","FB","BA","C") 
    round(cor(tail(stocks4corr[,c(input$GOOG_,input$FB_,input$AAPL_,input$BA_,input$C_)],s)),2)
  })
  
  output$table <- renderTable({
    model()
  })
})