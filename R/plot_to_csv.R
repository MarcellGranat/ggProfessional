#' Saves the plot to a new csv file (numbered).
#'
#' @param plot ..
#' @param folder_name ..
#' @export

plot_to_csv <- function(plot = ggplot2::last_plot(), folder_name = "figures") {
  if (!paste0("./", folder_name) %in% list.dirs()) {
    dir.create(folder_name)
    n_fig <- 0
  } else {
    n_fig <- length(list.files(folder_name))
  }

  out <- ggplot2::ggplot_build(plot) |>
    pluck(1) |>
    pluck(1) |>
    select_if(~ n_distinct(.) > 1)

  write.csv(out, file = paste0(folder_name, "/fig", n_fig + 1, ".csv"))
  plot

}
