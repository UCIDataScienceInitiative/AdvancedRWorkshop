library(shiny)
library(ggplot2)

shinyServer(function(input, output) {
   
  Paintings <- read.csv("Paintings.csv")
  Paintings <- Paintings[Paintings$Height..cm.<500,]
  Paintings <- Paintings[Paintings$Width..cm.<1000,]
  Paintings <- Paintings[!is.na(Paintings$Height..cm.),]
  Paintings <- Paintings[!is.na(Paintings$Width..cm.),]
  Paintings$landscape <- Paintings$Width..cm. > Paintings$Height..cm.
  Paintings$YearAcquired <- as.numeric(sapply(Paintings$DateAcquired, function(x) substr(x, 1, 4)))
  
  output$painting <- renderPlot({
    if (input$picasso) {
      dat = Paintings[Paintings$Artist=='Pablo Picasso',]
    } else {
      dat = Paintings
    }
    dat <- dat[dat$YearAcquired >= input$year[1],]
    dat <- dat[dat$YearAcquired <= input$year[2],]
    ggplot(data=dat, 
           aes(x=Width..cm., y=Height..cm.)) + geom_point(colour=input$color) +
      coord_cartesian(xlim = ranges$x, ylim = ranges$y)
  })
  
  output$click_info <- renderPrint({
    str(input$plot_click)
  })
  
  ranges <- reactiveValues(x = NULL, y = NULL)
  
  observeEvent(input$plot_dblclick, {
    brush <- input$plot_brush
    if (!is.null(brush)) {
      ranges$x <- c(brush$xmin, brush$xmax)
      ranges$y <- c(brush$ymin, brush$ymax)
      
    } else {
      ranges$x <- NULL
      ranges$y <- NULL
    }
  })
})
