library(shiny)
library(ggplot2)
library(tidyverse)
library(sf)

# Data 
cm_scen1 <- read.csv("HS_placeholder_2020_2030.csv")
cm_scen1_split <- split(cm_scen1, cm_scen1$year)
LGAsf <- st_read("LGA_shape/NGA_LGAs.shp")
LGAsf_list <- list(LGAsf)
join<- map2(LGAsf_list, cm_scen1_split, left_join)
variable <- read.csv("variable.csv")


#map function 

map_fun <- function(shpfile, map_val) {
  year <- unique(na.omit(shpfile$year))
  tm_shape(shpfile) + #this is the health district shapfile with LLIn info
    tm_polygons(col = map_val, textNA = "No data", 
                title = "", palette = "seq", breaks=c(0, 0.1, 0.2, 
                                                      0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 1.0))+
    tm_layout(title = paste0(year),
              aes.palette = list(seq="RdYlBu")) 
}

#shiny script 

ui <- fluidPage(titlePanel("Malaria Intervention Scenarios and Outcomes in Nigerian LGAs"), br(), br(), 
                sidebarLayout(
                  sidebarPanel(selectInput("scenarioInput", "Scenarios",
                                           choices = c( "", "Scenario 1", "Scenario 2", "Scenario 3", "Scenario 4", "Scenario 5",
                                                       "Scenario 6", "Scenario 7")),
                               selectInput("yearInput", "Year",
                                                        choices = c("", "2020", "2021", "2022", "2023", "2024",
                                                                    "2025", "2026", "2027", "2028", "2029", "2030")),
                               selectInput("variableInput", "Variable to visualize",
                                           choices = variable$variable),
                                selectInput("varType", "Options",
                                            choices = variable$input, multiple = TRUE)),
                              
                              
                  mainPanel(
                    plotOutput("coolplot"), 
                    br(), br(),
                    tableOutput("results"))
                )
)
server <- function(input, output, session) {
  observe({
    updateSelectInput(session, "varType", choices = variable[variable$variable==input$variableInput, "input"])
  })
}

shinyApp(ui = ui, server = server)










