library(shiny)
library(bslib)

# navset_pill, navset_pill_list, navset_tab, navset_card_tab
ui <- page_fillable(
  navset_pill(
    nav_panel("A", "Page A content"),
    nav_panel("B", "Page B content"),
    nav_panel("C", "Page C content"),
    nav_menu(
      "Other links",
      nav_panel("D", "Panel D content"),
      "----",
      "Description:",
      nav_item(
        a("Shiny", href = "https://shiny.posit.co", target = "_blank")
      ),
    ),
  ),
  id = "tab"
)

server <- function(input, output) {

}

shinyApp(ui = ui, server = server)
