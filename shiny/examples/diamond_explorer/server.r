library(ggplot2)

shinyServer(
  function(input, output) {
    output$diamond.plot <- renderPlot({
      sub.diamonds <- diamonds[diamonds$price > input$price[1],]
      sub.diamonds <- sub.diamonds[sub.diamonds$price < input$price[2],]
      alpha <- if(input$alpha) 0.2 else 1
      ggplot(sub.diamonds, aes(carat, price)) + geom_point(alpha=alpha)
    })
    
    output$summary <- renderText({
      sub.diamonds <- diamonds[diamonds$price > input$price[1],]
      sub.diamonds <- sub.diamonds[sub.diamonds$price < input$price[2],]
      summary(sub.diamonds$price)
    })
  
    output$table <- renderTable({
#      browser(expr=input$price > 2000)
      sub.diamonds <- diamonds[diamonds$price > input$price[1],]
      sub.diamonds <- sub.diamonds[sub.diamonds$price < input$price[2],]
      head(sub.diamonds)
    })
    
    output$data.table <- renderDataTable({
      sub.diamonds <- diamonds[diamonds$price > input$price[1],]
      sub.diamonds <- sub.diamonds[sub.diamonds$price < input$price[2],]
      sub.diamonds
    })
  }
)