mod_UI <- function(id) {
  ns <- NS(id)
  tagList(
    textOutput(ns("text_ifadesi"))
  )
}

mod_Server <- function(id, x = 10, y = NULL) {
  moduleServer(
    id,
    function(input, output, session) {
      print(is.reactive(x))
      print(is.reactive(y))

      output$text_ifadesi <- renderText({
        if(is.null(y)){
          paste(id, 5 + x(), x())
        }else{
          paste(id, 5 + y(), y())
        }
      })

      reactive({
        if(is.null(y)){
          5 + x()
        }else{
          5 + y()
        }
      })

    }
  )
}


library(shiny)

ui <- fluidPage(
  numericInput("num",label = "Numeric", value = 0),
  mod_UI("a"),
  mod_UI("b"),
  mod_UI("c")

)

server <- function(input, output, session) {

  # mod_Server("a", x = 20)
  rv <- reactiveVal(0)
  observe({
    y_mod <- mod_Server("b", x = reactive({ input$num }) )
    rv(y_mod)
  })
  #
  # print(y_mod)
  #
  observe({
    mod_Server("c", x = 20, y = rv())
  })

}

shinyApp(ui, server)
