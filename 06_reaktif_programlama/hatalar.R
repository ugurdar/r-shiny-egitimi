# Reative - tembel (lazy)
library(shiny)

ui <- fluidPage(
  actionButton("btn","buton"),
  textOutput("text")
)

server <- function(input, output, session) {

  text_ifadesi <- reactive({
    message("reactive calisiyor")
    "Lorem"
  })

  output$text <- renderText({
    req(input$btn)
    message("text renderText calisiyor")
    text_ifadesi()
  })

  observeEvent(input$btn,{
    output$text <- renderText({
      # req(input$btn)
      message("text renderText calisiyor")
      text_ifadesi()
    })
  })

  # observeEvent({
  #   observe({
  #
  #   })
  # })

  # eventReactive
  # a <- observeEvent(input$btn,{
  #   5
  # })

}

shinyApp(ui, server)
