library(shiny)
library(bslib)
library(bsicons)
library(dplyr)
library(reactable)
library(palmerpenguins)

df <- na.omit(palmerpenguins::penguins)

source("penguin_plot.R")
source("penguin_table.R")

ui <- page_navbar(
  position = "fixed-top",
  tags$style(type = "text/css", "body {padding-top: 60px !important;}"),
  title = tagList(
    tags$img(
      src = "penguins.png",
      width = "40px",
      height = 20,
      style = "margin-left: 5px; margin-right: 10px"
    ),
    "Penguins"
  ),
  window_title = "Penguins",
  nav_panel(
    "Summary",
    icon = bs_icon("search"),
    layout_sidebar(
      fillable = FALSE,
      sidebar = sidebar(
        bs_icon("toggles"),
        uiOutput("island_species_ui"),

        sliderInput(
          "bill_length",
          label = "Bill Length (mm)",
          min = min(df$bill_length_mm, na.rm = TRUE),
          max =  max(df$bill_length_mm, na.rm = TRUE),
          value = c(
            min(df$bill_length_mm, na.rm = TRUE),
            max(df$bill_length_mm, na.rm = TRUE)
          )
        ),
        sliderInput(
          "bill_depth",
          label = "Bill Depth (mm)",
          min = min(df$bill_depth_mm, na.rm = TRUE),
          max =  max(df$bill_depth_mm, na.rm = TRUE),
          value = c(
            min(df$bill_depth_mm, na.rm = TRUE),
            max(df$bill_depth_mm, na.rm = TRUE)
          )
        ),
        sliderInput(
          "flipper_length",
          label = "Flipper Length (mm)",
          min = min(df$flipper_length_mm, na.rm = TRUE),
          max =  max(df$flipper_length_mm, na.rm = TRUE),
          value = c(
            min(df$flipper_length_mm, na.rm = TRUE),
            max(df$flipper_length_mm, na.rm = TRUE)
          )
        ),
        sliderInput(
          "body_mass",
          label = "Body Mass (g)",
          min = min(df$body_mass_g, na.rm = TRUE),
          max =  max(df$body_mass_g, na.rm = TRUE),
          value = c(
            min(df$body_mass_g, na.rm = TRUE),
            max(df$body_mass_g, na.rm = TRUE)
          )
        ),
        selectInput(
          "sex",
          "Sex",
          choices = c("All",
                      "Male" = "male",
                      "Famale" = "female")
        ),
        selectInput("year",
                    "Year",
                    choices = c("All", unique(df$year))),
      ),
      # Kartlar
      layout_columns(
        layout_columns(
          card(tags$img(src = "culmen_depth.png"))
        ),
        layout_columns(
          value_box(
            title = "Average Bill Length (mm)",
            value = textOutput("bill_length_mean"),
            showcase = bs_icon("arrows"),
            theme = value_box_theme(bg = "#b951c4", fg = "white"),
            p(
              "Max:" ,
              textOutput("bill_length_max", inline = TRUE),
              "Min:",
              textOutput("bill_length_min", inline = TRUE)
            )
          ),
          value_box(
            title = "Average Bill Depth (mm)",
            value = textOutput("bill_depth_mean"),
            showcase = bs_icon("arrows-vertical"),
            theme = value_box_theme(bg = "#0b6764", fg = "white"),
            p(
              "Max:" ,
              textOutput("bill_depth_max", inline = TRUE),
              "Min:",
              textOutput("bill_depth_min", inline = TRUE)
            )
          ),
          value_box(
            title = "Average Flipper Length (mm)",
            value = textOutput("flipper_length_mean"),
            showcase = bs_icon("water"),
            theme = value_box_theme(bg = "#ff7403", fg = "white"),
            p(
              "Max:" ,
              textOutput("flipper_length_max", inline = TRUE),
              "Min:",
              textOutput("flipper_length_min", inline = TRUE)
            )
          ),
          value_box(
            title = "Average Body mass (g)",
            value = textOutput("body_mass_mean"),
            showcase = bs_icon("arrows-move"),
            theme = value_box_theme(bg = "#f4d03f", fg = "white"),
            p(
              "Max:" ,
              textOutput("body_mass_max", inline = TRUE),
              "Min:",
              textOutput("body_mass_min", inline = TRUE)
            )
          ),
          col_widths = 3
        ),
        col_widths = c(2, 10)
      ), # kartların bitişi
      # grafik ve tablo
      layout_columns(
        layout_columns(
          selectInput(
            "variable",
            "Variable",
            choices = c(
              "Bill Length (mm)" = "bill_length_mm",
              "Bill Depth (mm)" = "bill_depth_mm",
              "Flipper Length (mm)" = "flipper_length_mm",
              "Body Mass (g)" = "body_mass_g"
            )
          ),
          plotOutput("plot"),
          col_widths =12
        ),
        reactableOutput("table"),
        col_widths = c(5, 7)
      )
    )
  ) #nav_panel bitisi
)

server <- function(input, output, session) {

  observe({
    showModal(
      modalDialog(
        h1("welcome")
      )
    )
  })

  observe({
    updateSelectInput(session = session, inputId = "species",
                      choices = c("All", as.character(unique(
                        df$species
                      )))
                      )
  })

  output$island_species_ui <- renderUI({
    tagList(
      selectInput("species",
                  "Species",
                  choices = c("All", as.character(unique(
                    df$species
                  )))),
      selectInput("island",
                  "Island",
                  choices = NULL)
    )
  })

  observe({
    updateSelectInput(session = session, inputId = "island",
                      choices = c("All", as.character(unique(
                        df$island
                      )))
    )
  })


  data_r <- reactive({
    df_filtered <- df |>
      filter(bill_length_mm > input$bill_length[1]  &
               bill_length_mm < input$bill_length[2]) |>
      filter(bill_depth_mm > input$bill_depth[1]  &
               bill_depth_mm < input$bill_depth[2]) |>
      filter(
        flipper_length_mm > input$flipper_length[1]  &
          flipper_length_mm < input$flipper_length[2]
      ) |>
      filter(body_mass_g > input$body_mass[1]  &
               body_mass_g < input$body_mass[2])

    if (input$species != "All") {
      df_filtered <-  df_filtered |> filter(species %in% input$species)
    }
    if (input$island != "All") {
      df_filtered <-  df_filtered |> filter(island %in% input$island)
    }
    if (input$sex != "All") {
      df_filtered <-  df_filtered |> filter(sex %in% input$sex)
    }
    if (input$year != "All") {
      df_filtered <-  df_filtered |> filter(year %in% input$year)
    }
    df_filtered
  })


  output$plot <- renderPlot({
    req(data_r())
    validate(
      need(nrow(data_r()) > 0, "No record found by search criterias.")
    )
    plot_penguins(data_r(), input$variable)
  })

  output$table <- renderReactable({
    req(data_r())
    validate(
      need(nrow(data_r()) > 0, "")
    )
    table_penguins(data_r())
  })


  output$bill_length_max <- renderText({
    validate(need(nrow(data_r()) > 0, "No record found."))
    round(max(data_r()$bill_length_mm, na.rm = TRUE), 2)
  })
  output$bill_length_min <- renderText({
    validate(need(nrow(data_r()) > 0, "No record found."))
    round(min(data_r()$bill_length_mm, na.rm = TRUE), 2)
  })
  output$bill_length_mean <- renderText({
    validate(need(nrow(data_r()) > 0, "No record found."))
    round(mean(data_r()$bill_length_mm, na.rm = TRUE), 2)
  })

  output$bill_depth_max <- renderText({
    validate(need(nrow(data_r()) > 0, "No record found."))
    round(max(data_r()$bill_depth_mm, na.rm = TRUE), 2)
  })
  output$bill_depth_min <-  renderText({
    validate(need(nrow(data_r()) > 0, "No record found."))
    round(min(data_r()$bill_depth_mm, na.rm = TRUE), 2)
  })
  output$bill_depth_mean <- renderText({
    validate(need(nrow(data_r()) > 0, "No record found."))
    round(mean(data_r()$bill_depth_mm, na.rm = TRUE), 2)
  })

  output$flipper_length_max <- renderText({
    validate(need(nrow(data_r()) > 0, "No record found."))
    round(max(data_r()$flipper_length_mm, na.rm = TRUE), 2)
  })
  output$flipper_length_min <-  renderText({
    validate(need(nrow(data_r()) > 0, "No record found."))
    round(min(data_r()$flipper_length_mm, na.rm = TRUE), 2)
  })
  output$flipper_length_mean <- renderText({
    validate(need(nrow(data_r()) > 0, "No record found."))
    round(mean(data_r()$flipper_length_mm, na.rm = TRUE), 2)
  })

  output$body_mass_max <- renderText({
    validate(need(nrow(data_r()) > 0, "No record found."))
    round(max(data_r()$body_mass_g, na.rm = TRUE), 2)
  })
  output$body_mass_min <- renderText({
    validate(need(nrow(data_r()) > 0, "No record found."))
    round(min(data_r()$body_mass_g, na.rm = TRUE), 2)
  })
  output$body_mass_mean <- renderText({
    validate(need(nrow(data_r()) > 0, "No record found."))
    round(mean(data_r()$body_mass_g, na.rm = TRUE), 2)
  })
  # Shiny module?


}

shinyApp(ui, server)
