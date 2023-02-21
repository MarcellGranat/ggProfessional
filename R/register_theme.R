#' Register a theme locally.
#'
#' @param theme ..
#' @param name ..
#' @export

register_theme <- function(theme, name) {
  file_name <- path.package(package = "ggProfessional") |>
    paste0("/theme.rds")


  if (!ggplot2::is.theme(theme)) {
    stop("`theme` must be a valid ggplot2 theme")
  }

  if (!file_name %in% list.files(path.package(package = "ggProfessional"), full.names = TRUE)) {
    saveRDS(list(), file_name)
  }

  themes <- readr::read_rds(file_name)

  # overwrite >> remove previous with the same name
  keep_these <- purrr::map_lgl(themes, ~ !.[[1]] %in% name)

  themes <- themes[keep_these]

  themes |>
    append(list(list(name = name, theme = theme))) |>
    saveRDS(file = file_name)
}

