#' Saves plots to one ppt file.
#'
#' @param plot ..
#' @param file_name ..
#' @param width ..
#' @param height ..
#' @export

plot_to_ppt <- function (plot = ggplot2::last_plot(), file_name = "figures.pptx", width = NULL, height = NULL) {
  if (file_name %in% list.files()) {
    doc <- officer::read_pptx(file_name)
  } else {
    doc <- officer::read_pptx()
  }

  x <- rvg::dml(ggobj = plot)
  doc <- officer::add_slide(doc, layout = "Title and Content",
                            master = "Office Theme")


  if (is.null(width) & is.null(height)) {
  doc <- officer::ph_with(doc, x, location = officer::ph_location_fullsize())
  print(doc, target = file_name)
  } else {
    sz <- officer::slide_size(doc)
    if (is.null(width)) {
      width <- sz$width
    }
    if (is.null(height)) {
      height <- sz$height
    }

    doc <- officer::ph_with(doc, x, location = officer::ph_location(
      left = 0, top = 0,
      width = width, height = height
    ))
    print(doc, target = file_name)
  }
  plot
}
