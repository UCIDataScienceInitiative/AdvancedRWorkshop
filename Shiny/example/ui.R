library(shinythemes)

shinyUI(fluidPage(theme=shinytheme('readable'),
  fluidRow(align='center',
    h2('Nicolas Cage Movies'),
    plotOutput(outputId='movies')
  ),
  fluidRow(
    column(3, 
           selectInput('color', label='Color', 
                       choices=list('black', 'red', 'blue'), 
                       selected='black'),
           offset=1
           ),
    column(4,
           sliderInput('year', label="Year", 
                       min=1980, max=2016, value=c(1980, 2016))
           )
    )
))

