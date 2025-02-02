# Reative - tembel (lazy)
library(shiny)

ui <- fluidPage(
  textOutput("text"),
  textOutput("text22")
)

server <- function(input, output, session) {

  text_ifadesi <- reactive({
    message("reactive calisiyor")
    "Lorem"
  })

  output$text <- renderText({
    message("text renderText calisiyor")
    text_ifadesi()
  })

  output$text_22 <- renderText({
    message("text_22 renderText calisiyor")
    text_ifadesi()
  })

}

shinyApp(ui, server)
