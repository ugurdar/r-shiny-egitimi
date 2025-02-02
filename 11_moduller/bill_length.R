bill_length_UI <- function(id) {
  ns <- NS(id)
  tagList(
    value_box(
      title = "Average Bill Length (mm)",
      value = textOutput(ns("bill_length_mean")),
      showcase = bs_icon("arrows"),
      theme = value_box_theme(bg = "#b951c4", fg = "white"),
      p(
        "Max:" ,
        textOutput(ns("bill_length_max"), inline = TRUE),
        "Min:",
        textOutput(ns("bill_length_min"), inline = TRUE)
      )
    )

  )
}

bill_length_Server <- function(id, data_r) {
  moduleServer(
    id,
    function(input, output, session) {


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
    }
  )
}
