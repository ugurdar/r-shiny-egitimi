library(shiny)
library(bslib)
################################################################################
# page_fixed, page_fluid, page_fillable
ui <- page_fillable(
  "layout_columns",
  layout_columns(
    card("Card 1"),
    card("Card 2"),
    card("Card 3")
  )
)

server <- function(input, output) {

}

shinyApp(ui = ui, server = server)

################################################################################
# page_navbar()


ui <- page_navbar(
  nav_panel("A", "Page A content"),
  nav_panel("B", "Page B content"),
  nav_panel("C", "Page C content"),
  title = "App with navbar",
  id = "page",
  position = "fixed-top"
)

server <- function(input, output) {

}

shinyApp(ui = ui, server = server)

################################################################################
# page_sidebar

library(ggplot2)

ui <- page_sidebar(
  title = "Example dashboard",
  sidebar = sidebar(
    varSelectInput("var", "Select variable", mtcars)
  ),
  card(
    full_screen = TRUE,
    card_header("My plot"),
    plotOutput("p")
  )
)

server <- function(input, output) {
  output$p <- renderPlot({
    ggplot(mtcars) + geom_histogram(aes(!!input$var))
  })
}

shinyApp(ui, server)
