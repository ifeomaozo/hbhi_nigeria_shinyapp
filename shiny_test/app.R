library(shiny)
library(ggplot2)
library(tidyverse)

bc1 <- read.csv("bc1-data.csv")



ui <- fluidPage(titlePanel("BC Liquor Store prices"),
                sidebarLayout(
                  sidebarPanel(sliderInput("priceInput", "Price", min = 0, max = 100,
                                           value = c(25, 40), pre = "$"),
                  radioButtons("typeInput", "Product type",
                               choices = c("BEER", "REFRESHMENT", "SPIRITS", "WINE"),
                               selected = "WINE"),
                  selectInput("countryInput", "Country",
                              choices = c("CANADA", "FRANCE", "ITALY"))),
                  mainPanel(
                    plotOutput("coolplot"), 
                    br(), br(),
                    tableOutput("results"))
                )
)


server <- function(input, output) {
  output$coolplot <- renderPlot({
    filtered <-
      bc1 %>%
      filter(Price >= input$priceInput[1],
             Price <= input$priceInput[2],
             Type == input$typeInput,
             Country == input$countryInput
      )
    ggplot(filtered, aes(Alcohol_Content)) +
      geom_histogram()
  })
  
  output$results <- renderTable({
    filtered <-
      bc1 %>%
      filter(Price >= input$priceInput[1],
             Price <= input$priceInput[2],
             Type == input$typeInput,
             Country == input$countryInput
      )
    filtered
  })
}

shinyApp(ui = ui, server = server)







