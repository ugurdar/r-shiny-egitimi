library(shiny)
library(bslib)

ui <- page_fluid(
  radioButtons(
    inputId = "radio",
    label = "Radio buttons",
    choices = list(
      "Option 1" = 1,
      "Option 2" = 2,
      "Option 3" = 3
    )
  ),
  textOutput("choice")
)

server <- function(input, output) {
  output$choice <- renderText({input$radio})
}

shinyApp(ui = ui, server = server)
