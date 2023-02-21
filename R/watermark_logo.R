watermark_logo <- function(logo = NULL, alpha = 1){
  logo_dir <- paste0(path.package("ggProfessional"), "/logos")

  if (is.null(logo)) {
    logo <- list.files(logo_dir, full.names = T) |>
      file.info() |>
      pull(mtime) |>
      (\(x) list.files(logo_dir)[which(x == max(x))]) ()
  } else {
    logo <- paste0(logo, ".png")
  }

  img <- png::readPNG(paste0(logo_dir, "/", logo), FALSE, FALSE)

  img <- matrix(grDevices::rgb(img[,,1], img[,,2], img[,,3],
                               img[,,4] * alpha), nrow=dim(img)[1])

  g <- grid::rasterGrob(img, interpolate=TRUE)

  ggplot2::annotation_custom(grob = g)
}
