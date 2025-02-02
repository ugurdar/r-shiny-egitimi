# Observe ve ObserveEvent - hevesli (eager)
# Bir API ile iletişim kurarken
# inputları update ederken
# sürekli gözlemlemek gerektiğinde
library(shiny)

ui <- fluidPage(
  textInput("text_i", "Text girdisi"),
  actionButton("btn", "Buton"),
  actionButton("btn2", "Buton2"),
  textOutput("text"),
  textOutput("text22")
)

server <- function(input, output, session) {
  text_ifadesi <- reactive({
    message("reactive calisiyor")
    "Lorem"
  })

  output$text_22 <- renderText({
    text_ifadesi()
  })

  # observe({
  #   text_ifadesi()
  # })

  # observe({
  #   message("observe calisiyor")
  #   # text_ifadesi()
  #   # input$text_i
  #   input$btn
  #   isolate({
  #     input$text_i
  #
  #     print(input$btn + input$btn2)
  #
  #   })
  # })
  #
  # #
  observeEvent(input$btn,{
    print(5 + 5)

  })
  #
  # observe({
  #   input$btn
  #   isolate({
  #     input$btn2
  #     print(5+5)
  #   })
  # })




}

shinyApp(ui, server)
