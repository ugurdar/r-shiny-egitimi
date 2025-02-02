library(shiny)
library(bslib)

################################################################################
card(
  full_screen = TRUE,
  card_header(
    "This is the header"
  ),
  card_body(
    p("This is the body."),
    p("This is still the body.")
  ),
  card_footer(
    "This is the footer"
  )
)

################################################################################
# Bootstrap 12 birimlik grid sistemine sahip.

# layout_column_wrap
ui <- page_fillable(
  "layout_columns",
  layout_column_wrap(
    width =  1/4, #"300px", # 1/n
    card("Card 1"),
    card("Card 2"),
    card("Card 3")
  )
)

server <- function(input, output) {

}

shinyApp(ui = ui, server = server)

################################################################################
# layout_columns
# col_widths ile gridlerin genislikleri belirlenebilir
ui <- page_fillable(
  "layout_columns",
  layout_columns(
    # width = 1/4,
    card("Card 1"),
    card("Card 2"),
    card("Card 3")
    # col_widths = c(2, 4, 6)
    # col_widths = c(4, -2, 4)
    # col_widths = breakpoints(sm = 1, md=3, lg = c(4,4,4))
  )
)

server <- function(input, output) {

}

shinyApp(ui = ui, server = server)

################################################################################
# Nested

ui <- page_fillable(
  layout_columns(
    card("Card 1"),
    card(
      "Card 2",
      layout_columns(
        card("Card 2.1"),
        card("Card 2.2"),
        col_widths = c(2, 10)
      )
    ),
    col_widths = c(4, 8)
  )
)

server <- function(input, output) {

}

shinyApp(ui = ui, server = server)

################################################################################

library(ggplot2)

ui <- page_fluid(
  layout_sidebar(
    sidebar = sidebar(
      sliderInput("n", "N", 0, 100, 20),
      #
      #
      open = "desktop"), # desktop, open, closed
    plotOutput("histogram")
  )
)

server <- function(input, output) {
  output$histogram <- renderPlot({
    data.frame((x = 100 + 15 * rnorm(n = 500))) |>
      ggplot(aes(x)) +
      geom_histogram()
  })
}

shinyApp(ui = ui, server = server)
