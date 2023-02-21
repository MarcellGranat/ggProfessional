#' Remove a locally registered theme.
#'
#' @param name ..
#' @export

remove_theme <- function(name) {
  file_name <- path.package("ggProfessional") |>
    paste0("/theme.rds")

  theme <- readr::read_rds(file_name)

  keep_these <- purrr::map_lgl(theme, ~ !.[[1]] %in% name)

  saveRDS(theme[keep_these], file = file_name)
}
