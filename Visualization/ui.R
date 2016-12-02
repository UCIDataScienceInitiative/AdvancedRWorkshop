library(shiny)
library(shinythemes)

shinyUI(fluidPage(theme = shinytheme("readable"),
                  h2('MoMA Painting Dimensions'),
                  
                  plotOutput('painting', click = "plot_click",
                             dblclick = "plot_dblclick",
                             hover = "plot_hover",
                             brush = brushOpts(
                               id = "plot_brush",
                               resetOnNew = TRUE)),
                  
                  hr(),
                  
                  fluidRow(
                    column(3,
                           selectInput('color', label = 'Point color', 
                                       choices = list('black', 'red', 'blue'), 
                                       selected = 'black')
                    ),
                    column(4, offset = 1,
                           sliderInput('year', label="Year acquired", 
                                       min=1930, max=2016, value=c(1930, 2016)),
                           checkboxInput('picasso', label="Only Picasso", value = FALSE)
                    ),
                    column(4,
                           verbatimTextOutput("click_info")
                    )
                  )

))
