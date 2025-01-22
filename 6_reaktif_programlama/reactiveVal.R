# reactiveValues,reactiveVal, eventReactive
# Bir değişkenin birden fazla yerden güncellenmesi
library(shiny)

ui <- fluidPage(
  "Toplam:",
  textOutput("total", inline = TRUE),
  actionButton("add1", "1 Ekle"),
  actionButton("add5", "5 Ekle"),
  textOutput("textr1")
)

server <- function(input, output, session) {
  values <- reactiveValues(total = 0, total2 = 5)

  r1 <- reactiveVal(5)

  observeEvent(input$add1, {
    r1(r1() + 5)
  })

  output$textr1 <- renderText({
    message("textr1 calisiyor")
    r1()
  })

  observeEvent(input$add1, {
    values$total <- values$total + 1
  })
  observeEvent(input$add5, {
    values$total <- values$total + 5
  })
  output$total <- renderText({
    values$total
  })


  total <- eventReactive(input$add1,{
    total + 999
  })
}

shinyApp(ui = ui, server = server)
