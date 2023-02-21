#' Shows the registered themes.
#'
#' @param show Show only this specific.
#' @export

available_themes <- function(show = NULL) {
  p <- ggplot2::ggplot(iris, ggplot2::aes(Sepal.Length, Petal.Width, color = Species)) +
    ggplot2::geom_point()

  themes <- path.package("ggProfessional") |>
    paste0("/theme.rds") |>
    readr::read_rds()

  if (length(themes) < 1) {
    stop("No registered themes.")
  }

  if (!is.null(show)) {
    names(themes) <- purrr::map(themes, 1)
    themes <- themes[show]
  }

  purrr::map(themes, ~ p + ggtitle(.[[1]]) + .[[2]]) |>
    patchwork::wrap_plots()
}
