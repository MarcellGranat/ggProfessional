#' Add watermark logo
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
#' geom_point() +
#' watermark_logo()
#'

watermark_logo <- function(logo = NULL, alpha = 1){
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

  ggplot2::annotation_custom(grob = g)
}
