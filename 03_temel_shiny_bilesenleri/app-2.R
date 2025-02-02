library(shiny)
library(bslib)
library(ggplot2)
ui <- page_fluid(plotOutput("plot", click = "plot_click"),
                 textOutput("coords"))

server <- function(input, output) {
  output$plot <- renderPlot({
    mpg |>
      ggplot(aes(hwy, cty)) +
      geom_point() +
      labs(title = "Click anywhere on the plot")
  })

  observe({
    print(input$plot_click)
  })

  # output$coords <- renderText({
  #   input$plot_click
  # })
}

shinyApp(ui, server)
