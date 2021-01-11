library(shiny)
data(mtcars)

ui <- fluidPage(
  
  
  titlePanel("MTCARS"),
  selectInput("Columns","Columns",
              names(mtcars), multiple = TRUE),
  verbatimTextOutput("dfStr")
  
  
)


server <- function(input, output) {
  
  
  Dataframe2 <- reactive({
    mtcars[,input$Columns] 
  })
  output$dfStr <- renderPrint({
    str(Dataframe2())
  })
  
  
  
}

shinyApp(ui = ui, server = server)