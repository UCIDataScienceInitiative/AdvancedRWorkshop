shinyServer(
  function(input, output) {
    output$summaries <- renderText(paste("n:", input$n_samples))
    output$samplePlot <- renderPlot(hist(rnorm(input$n_samples)))
  }
)