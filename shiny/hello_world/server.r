shinyServer(
  function(input, output) {
    output$summaries <- renderText(paste("derp", input$n_samples))
    output$samplePlot <- renderPlot(hist(rnorm(input$n_samples)))
  }
)