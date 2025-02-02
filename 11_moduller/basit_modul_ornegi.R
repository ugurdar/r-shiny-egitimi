bill_length_UI <- function(id) {
  ns <- NS(id)
  tagList(
    textOutput(ns("text_ifadesi"))
  )
}

bill_length_Server <- function(id, x = 10) {
  moduleServer(
    id,
    function(input, output, session) {

      output$text_ifadesi <- renderText({
        5 + x
      })
    }
  )
}


library(shiny)

ui <- fluidPage(
  bill_length_UI("a"),
  bill_length_UI("b")

)

server <- function(input, output, session) {

  bill_length_Server("a", x = 20)

  bill_length_Server("b", x = 50)


}

shinyApp(ui, server)
