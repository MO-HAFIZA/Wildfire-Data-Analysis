library(tidyverse)
library(ggplot2)
library(readr)
library(plotly)
library(ggmap)
library(rmarkdown)
library(ggthemes)
library(lubridate)

my_theme_light <- theme_minimal(base_size = 12) +
  theme(
    plot.background = element_rect(
      fill = "#FDF6E3", color = NA
    ),
    panel.background = element_rect(
      fill = "#FDF6E3", color = NA
    ),
    panel.grid.major = element_line(
      color = "#EEE8D5", linewidth = 0.5
    ),
    panel.grid.minor = element_blank(),
    strip.background = element_rect(
      fill = "#EEE8D5", color = NA
    ),
    strip.text = element_text(
      color = "#586E75", face = "bold"
    ),
    plot.title = element_text(
      color = "#073642", face = "bold", size = 17
    ),
    plot.subtitle = element_text(
      color = "#657B83"
    ),
    axis.text = element_text(
      color = "#586E75"
    ),
    axis.title = element_text(
      color = "#073642", face = "bold"
    )
  )

my_theme_dark <- theme_minimal(base_size = 12) +
  theme(
    # Background
    plot.background = element_rect(
      fill = "#002B36", color = NA
    ),
    panel.background = element_rect(
      fill = "#073642", color = NA
    ),
    
    # Grid
    panel.grid.major = element_line(
      color = "#164B56", linewidth = 0.5
    ),
    panel.grid.minor = element_blank(),
    
    # Facets
    strip.background = element_rect(
      fill = "#164B56", color = NA
    ),
    strip.text = element_text(
      color = "#93A1A1",
      face = "bold"
    ),
    
    # Titles
    plot.title = element_text(
      color = "#FDF6E3",
      face = "bold",
      size = 17
    ),
    plot.subtitle = element_text(
      color = "#93A1A1"
    ),
    
    # Axis
    axis.text = element_text(
      color = "#B8C8C8"
    ),
    axis.title = element_text(
      color = "#EEE8D5",
      face = "bold"
    ),
    
    # Legend
    legend.background = element_rect(
      fill = "#073642", color = NA
    ),
    legend.text = element_text(
      color = "#B8C8C8"
    ),
    legend.title = element_text(
      color = "#EEE8D5",
      face = "bold"
    ),
    
    # Borders
    panel.border = element_rect(
      color = "#164B56",
      fill = NA,
      linewidth = 0.5
    )
  )
