library(shiny)
library(ggplot2)

shinyServer(function(input, output) {
  
  imdb <- read.csv("~/Downloads/movie_metadata.csv")
  
  cage <- imdb[imdb$actor_1_name == 'Nicolas Cage', ]
  cage$actor_1_name <- as.character(cage$actor_1_name)
  
  output$movies <- renderPlot({
    temp <- cage[cage$title_year >= input$year[1] & cage$title_year <= input$year[2], ]
    ggplot(data=temp, aes(x=title_year, y=imdb_score, label=movie_title)) +
      geom_point(alpha=0.5, colour=input$color) + 
      geom_text(fontface='italic', size=6, vjust=1, nudge_y=0.1, colour=input$color) + 
      labs(x='Year', y='IMDB Score') +
      geom_smooth()
  })
})