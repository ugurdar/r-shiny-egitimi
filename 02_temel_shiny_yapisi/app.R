library(shiny)


ui <- fluidPage(
  h1("Merhaba"),
  h2("Dünya")
)

server <- function(input, output, session) {

}


shinyApp(ui, server)
