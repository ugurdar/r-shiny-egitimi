library(tidyverse)
library(ggimage)
library(hrbrthemes)

plot_penguins <- function(penguins_data,variable ){
  variable <- rlang::sym(as.character(variable))

  df_main <- na.omit(penguins_data)
  df <- df_main %>%
    drop_na(!!variable) %>%
    group_by(species) %>%
    summarize(
      minimum = min(!!variable, na.rm = TRUE),
      maksimum = max(!!variable, na.rm = TRUE),
      ort = mean(!!variable, na.rm = TRUE)
    )


  df$image <- ifelse(df$species == "Adelie",
                     "https://images2.imgbox.com/e7/b8/p5PaM2OS_o.png",
                     ifelse(df$species == "Chinstrap",
                            "https://images2.imgbox.com/1a/bc/OKefZBKI_o.png",
                            ifelse(df$species == "Gentoo",
                                   "https://images2.imgbox.com/86/89/Zm2fJwTA_o.png",
                                   NA)))




  # df$image <- c(
  #   "https://images2.imgbox.com/e7/b8/p5PaM2OS_o.png",  # Adelie
  #   "https://images2.imgbox.com/1a/bc/OKefZBKI_o.png",  # Chinstrap
  #   "https://images2.imgbox.com/86/89/Zm2fJwTA_o.png"   # Gentoo
  # )

  df$color <- ifelse(df$species == "Adelie",
                     "#b951c4",
                     NA)
  df$color <- ifelse(df$species == "Chinstrap",
                     "#0b6764",
                     NA)
  df$color <- ifelse(df$species == "Chinstrap",
                     "#ff7403",
                     NA)



  # df$color <- c("#b951c4", "#0b6764", "#ff7403")

  ggplot(df_main, aes(x = species, y = !!variable, color = species)) +

    geom_segment(
      data = df,
      aes(
        x = species, xend = species,
        y = minimum, yend = maksimum,
        color = color
      ),
      linewidth = 0.3, inherit.aes = FALSE
    ) +
    geom_image(
      data = df,
      aes(x = species, y = ort, image = image),
      size = 0.25, inherit.aes = FALSE
    ) +
    geom_jitter(alpha = 0.3, size = 1, width = 0.2) +
    scale_color_manual(values = c("Adelie" = "#b951c4", "Chinstrap" = "#0b6764", "Gentoo" = "#ff7403")) +
    scale_y_continuous(name = "") +
    scale_x_discrete(name = "") +
    theme_ipsum() +
    theme(
      text = element_text(size = 12),
      legend.position = "none",
      plot.title = element_text(hjust = 0.5, size = 16, face = "bold"),
      panel.grid.major.x = element_blank(),
      panel.grid.minor.x = element_blank()
    )

}
