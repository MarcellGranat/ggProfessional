plot_to_plotly <- function(plot = ggplot2::last_plot(), tooltip = c("text"), bgcolor = "#2DA2BF") {

  if (knitr::is_latex_output() | knitr::pandoc_to("gfm-yaml_metadata_block") | knitr::pandoc_to("docx")) {
    plot # static renders
  } else {
    font = list(family = "Alright Sans Regular", size = 15, color = "black")
    label = list(bgcolor = bgcolor, bordercolor = "transparent", font = font)

    plotly::ggplotly(plot, tooltip = tooltip) |>
      plotly::style(hoverlabel = label) |>
      plotly::layout(font = font) |>
      plotly::config(displayModeBar = FALSE)
  }
}


