library(bslib)
library(shiny)
library(lubridate)

ui <- page_fixed(
  dateRangeInput(inputId = "date", label = "Date Range"),
  hr(),
  verbatimTextOutput("date"),
  verbatimTextOutput("date1"),
  verbatimTextOutput("date2"),

  verbatimTextOutput("date1_class"),
  verbatimTextOutput("date1_year")
)

server <- function(input, output, session) {
  # You can access the value of the widget with input$date
  output$date <- renderPrint({ input$date })

  output$date1 <- renderPrint({ input$date[[1]] })
  output$date2 <- renderPrint({ input$date[[2]] })

  output$date1_class <- renderPrint({ class(input$date[[1]]) })
  output$date1_year <- renderPrint({ year(input$date[[1]]) })
}

shinyApp(ui, server)
