


#make a slider

ui <- fluidPage(
  fluidRow(
    column(4,
           sliderInput("obs", "Number of observations:",
                       min = 1, max = 1000, value = 500)
    ),
    column(8,
           plotOutput("distPlot")
    )
  )
)

server <- function(input, output) {
  output$distPlot <- renderPlot({
    hist(rnorm(input$obs))
  })
}


# UI demonstrating column layouts
ui <- fluidPage(
  title = "Hello Shiny!",
  fluidRow(
    column(width = 4,
           "4"
    ),
    column(width = 3, offset = 2,
           "3 offset 2"
    )
  )
)

shinyApp(ui, server = function(input, output) { })




