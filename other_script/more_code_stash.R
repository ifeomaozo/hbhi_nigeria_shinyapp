ui <- fluidPage(titlePanel("Malaria Intervention Scenarios and Outcomes in Nigerian LGAs"),
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



tm_shape(DSshape) + #this is the health district shapefile with test result info
  tm_polygons(col = colname, textNA = "No data", 
              title = legtitle, palette = "seq", breaks=c(0, 0.1, 0.2, 
                                                          0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 1.0))+
  tm_layout(title=maintitle, aes.palette = list(seq="-RdYlBu")

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


data(mtcars)
head(mtcars)
