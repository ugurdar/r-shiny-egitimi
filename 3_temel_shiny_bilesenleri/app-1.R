library(shiny)
library(bslib)

ui <- page_fluid(
  textInput(
    inputId = "text",
    "Text input",
    placeholder = "Enter text..."
  ),
  textOutput("text2"),
  textOutput("text3"),
  actionButton("update", "Show Time",class = "btn-success")

)

server <- function(input, output, session) {

  observe({
    message("input$text")
    print(input$text)
  })

  observe({
    message("input$update")
    print(input$update)
  })

 output$text2 <- renderText({
   input$text
  })

 output$text3 <- renderText({
   paste(input$text,"- shiny")
 })

}

shinyApp(ui, server)
