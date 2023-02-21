#' Add corner logo
#'
#' @param plot ..
#' @param logo ..
#' @param alpha ..
#' @param position ..
#' @param size ..
#'
#' @return gg.
#' @export
#' @examples
#'
#' library(ggProfessional)
#'
#' ggplot(iris, aes(Sepal.Length, Petal.Width)) +
#' geom_point() -
#' corner_logo
#'

corner_logo <- function(plot = ggplot2::last_plot(), logo = NULL, alpha = 1, position = "bottom-right", size = 1){
  logo_dir <- paste0(path.package("ggProfessional"), "/logos")

  if (is.null(logo)) {
    logo <- list.files(logo_dir, full.names = T) |>
      file.info() |>
      dplyr::pull(mtime) |>
      (\(x) list.files(logo_dir)[which(x == max(x))]) ()
  } else {
    logo <- paste0(logo, ".png")
  }

  img <- png::readPNG(paste0(logo_dir, "/", logo), FALSE, FALSE)

  img_fade <- matrix(grDevices::rgb(img[,,1], img[,,2], img[,,3], alpha), nrow=dim(img)[1])
  tryCatch({
    img_fade <- matrix(grDevices::rgb(img[,,1], img[,,2], img[,,3], img[,,4] * alpha), nrow=dim(img)[1])
  }, error = \(e) {})

  g <- grid::rasterGrob(img_fade, interpolate=TRUE)

  plot_axis <- ggplot2::ggplot_build(plot) |>
    purrr::pluck(1) |>
    purrr::pluck(1)

  if (position == "bottom-right") {

    xmax <- max(plot_axis$x, na.rm = TRUE)
    xmin <- xmax - (max(plot_axis$x, na.rm = TRUE) - min(plot_axis$x, na.rm = TRUE)) * .1 * size
    ymax <- min(plot_axis$y, na.rm = TRUE) - (max(plot_axis$x, na.rm = TRUE) - min(plot_axis$x, na.rm = TRUE)) * .2
    plot <- plot + ggplot2::annotation_custom(grob = g, xmin = xmin, xmax = xmax, ymax = ymax) +
      coord_cartesian(clip = "off") +
      theme(plot.margin = unit(c(1, 2, 2.5, 1), "lines"))
  }

  if (position == "bottom-left") {
    xmin <- min(plot_axis$x, na.rm = TRUE)
    xmax <- xmin + (max(plot_axis$x, na.rm = TRUE) - min(plot_axis$x, na.rm = TRUE)) * .1 * size
    ymax <- min(plot_axis$y, na.rm = TRUE) - (max(plot_axis$x, na.rm = TRUE) - min(plot_axis$x, na.rm = TRUE)) * .2
    plot <- plot + ggplot2::annotation_custom(grob = g, xmin = xmin, xmax = xmax, ymax = ymax) +
      coord_cartesian(clip = "off") +
      theme(plot.margin = unit(c(1, 1, 2.5, 2), "lines"))
  }

  if (position == "top-right") {
    xmax <- max(plot_axis$x, na.rm = TRUE)
    xmin <- xmax - (max(plot_axis$x, na.rm = TRUE) - min(plot_axis$x, na.rm = TRUE)) * .1 * size
    ymin <- max(plot_axis$y, na.rm = TRUE) + (max(plot_axis$x, na.rm = TRUE) - min(plot_axis$x, na.rm = TRUE)) * .15
    plot <- plot + ggplot2::annotation_custom(grob = g, xmin = xmin, xmax = xmax, ymin = ymin) +
      coord_cartesian(clip = "off") +
      theme(plot.margin = unit(c(2, 2, 1, 1), "lines"))
  }

  if (position == "top-left") {
    xmin <- min(plot_axis$x, na.rm = TRUE)
    xmax <- xmin + (max(plot_axis$x, na.rm = TRUE) - min(plot_axis$x, na.rm = TRUE)) * .1 * size
    ymin <- max(plot_axis$y, na.rm = TRUE) + (max(plot_axis$x, na.rm = TRUE) - min(plot_axis$x, na.rm = TRUE)) * .15
    plot <- plot + ggplot2::annotation_custom(grob = g, xmin = xmin, xmax = xmax, ymin = ymin) +
      coord_cartesian(clip = "off") +
      theme(plot.margin = unit(c(2, 1, 1, 2), "lines"))
  }
  plot

}
