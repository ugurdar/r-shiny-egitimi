table_penguins <- function(df){
  reactable(
    df,
    filterable = TRUE,
    searchable = TRUE,
    highlight = TRUE, # Satır vurgulama
    bordered = TRUE, # Kenarlık ekleme
    striped = TRUE, # Çizgili arka plan
    defaultColDef = colDef(
      align = "center", # Hücrelerin merkezde hizalanması
      headerStyle = list(
        background = "#ff7403", # Başlık arka plan rengi
        color = "#ffffff", # Başlık metin rengi
        fontWeight = "bold",
        fontSize = "14px"
      )
    ),
    columns = list(
      species = colDef(
        name = "Species",
        cell = function(value) {
          species_colors <- list(
            "Adelie" = "#b951c4",
            "Chinstrap" = "#0b6764",
            "Gentoo" = "#ff7403"
          )
          color <- species_colors[[value]]
          div(
            style = list(
              backgroundColor = color,
              color = "white",
              padding = "5px",
              borderRadius = "5px",
              fontWeight = "bold"
            ),
            value
          )
        }
      ),
      island = colDef(name = "Island"),
      bill_length_mm = colDef(
        name = "Bill Length",
        style = function(value) {
          color <- if (value > 40) "#ff7403" else "#b951c4"
          list(color = color, fontWeight = "bold")
        }
      ),
      bill_depth_mm = colDef(name = "Bill Depth"),
      flipper_length_mm = colDef(
        name = "Flipper Length",
        style = function(value) {
          list(background = ifelse(value > 200, "#0b6764", "transparent"),
               color = ifelse(value > 200, "white", "black"),
               fontWeight = "bold")
        }
      ),
      body_mass_g = colDef(name = "Body Mass"),
      sex = colDef(
        name = "Sex",
        cell = function(value) {
          gender_colors <- list("male" = "#0b6764", "female" = "#b951c4")
          color <- gender_colors[[tolower(value)]]
          div(
            style = list(
              backgroundColor = color,
              color = "white",
              padding = "5px",
              borderRadius = "5px",
              fontWeight = "bold"
            ),
            value
          )
        }
      ),
      year = colDef(
        name = "Year",
        style = function(value) {
          list(color = "#ff7403", fontWeight = "bold")
        }
      )
    ),
    theme = reactableTheme(
      borderColor = "#0b6764",
      stripedColor = "#f6f6f6",
      highlightColor = "#ffe6f0",
      cellPadding = "10px",
      style = list(
        fontFamily = "Arial, sans-serif",
        fontSize = "12px"
      )
    )
  )
}
