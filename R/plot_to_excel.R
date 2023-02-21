plot_to_excel <- function(plot = ggplot2::last_plot(), file_name = "figures.xlsx") {
  if (!file_name %in% list.files()) {
    n_sheets <- 0
    wb <- openxlsx::createWorkbook(title = "figures")
  } else {
    wb <- openxlsx::loadWorkbook(xlsxFile = file_name)
    n_sheets <- length(wb$sheet_names)
  }

  out <- ggplot2::ggplot_build(plot) |>
    pluck(1) |>
    pluck(1) |>
    select_if(~ n_distinct(.) > 1)

  sheet_name <- paste0("fig", n_sheets + 1)
  openxlsx::addWorksheet(wb = wb, sheetName = sheet_name)
  openxlsx::writeDataTable(wb, sheet_name, out)
  openxlsx::saveWorkbook(wb, file_name, overwrite = TRUE)
  plot
}
