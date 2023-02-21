#' Remove a locally registered palette.
#'
#' @param name ..
#' @export

remove_palette <- function(name) {
  file_name <- path.package("ggProfessional") |>
    paste0("/pals.rds")

  pals <- readr::read_rds(file_name)

  keep_these <- purrr::map_lgl(pals, ~ !.[[1]] %in% name)

  saveRDS(pals[keep_these], file = file_name)

}
