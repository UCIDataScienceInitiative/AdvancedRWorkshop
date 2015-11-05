library(ggplot2)

summary.price <- summary(diamonds$price)

shinyUI(fluidPage(
  titlePanel("Diamonds"),
  
  sidebarLayout(
    sidebarPanel(
      helpText("Diamond filter"),
      sliderInput("price",
                  label = "Minimum price:",
                  min = summary.price[1], max = summary.price[6], value = c(summary.price[2],summary.price[4])),
      checkboxInput("alpha", label = "Transperancy?", value = FALSE)
    ),
    
    mainPanel(
      tabsetPanel(
        tabPanel("Scatterplot", mainPanel(plotOutput("diamond.plot"))), 
        tabPanel("Summary", verbatimTextOutput("summary")), 
        tabPanel("Table", tableOutput("table")),
        tabPanel("Data Table", dataTableOutput("data.table"))
      )
    )
  )
))