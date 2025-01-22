library(shiny)
library(bslib)
library(readr)
library(dplyr)

ui <- page_fluid(
  layout_sidebar(
    sidebar = sidebar(
      "Sidebar",
      sliderInput(
        "slider",
        "Slider",
        min = 10,
        max = 30,
        value = c(15, 25)
      ),
      textInput("baslik", label = "Baslik")

    ),
    "Main contents",
    plotOutput("grafik")
  )
)
# ui <- page_fluid(
#   sliderInput(
#     "slider", "Slider",
#     min = 10, max = 30,
#     value = c(15, 25)
#   ),
#   plotOutput("grafik")
# )

server <- function(input, output, session) {
  df <- reactive({
    message("reactive veri okunuyor")
    read.csv("4_veri_okuma/veri.csv")
  })

  output$grafik <- renderPlot({
    message("grafik olusturuluyor")
    temp <-
      df() |> filter(mpg > input$slider[1] & mpg < input$slider[2])

    # isolate({
    #   # bunun içerisinde yazılan reaktifler tetiklemez
    # })

    plot(x = temp$mpg,
         y = temp$cyl,
         main =   isolate(input$baslik))


  })



}

shinyApp(ui, server)
