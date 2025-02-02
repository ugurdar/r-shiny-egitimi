library(shiny)
library(bslib)
library(readr)

# Yöntem - 1
df <- read.csv("4_veri_okuma/veri.csv")

ui <- page_fluid(
  textOutput("boyut")

)

server <- function(input, output, session) {
  # Yöntem - 2
  # df <- read.csv("4_veri_okuma/veri.csv")

  output$boyut <- renderText({
    dim(df())
  })

  # Yöntem - 3
  df <- reactive({
    read.csv("4_veri_okuma/veri.csv")
  })

}

shinyApp(ui, server)
