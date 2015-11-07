shinyUI(fluidPage(
  titlePanel("This is the title of the page"),
  sidebarLayout(
    sidebarPanel("This text will be shown in the sidebar",
                 sliderInput("n_samples", 
                             label = "Number of samples:",
                             min = 1, max = 100, value = c(50)),
                 textInput("a", ""),
                 actionButton("go", "Click go")
    ),
    mainPanel("This text goes in the main part of the page", textOutput("summaries"), plotOutput("samplePlot"))
  )
))