#' Register a palette locally.
#'
#' @param pal character vector (can be named).
#' @param name ..
#' @export

register_palette <- function(pal, name) {
  file_name <- path.package("ggProfessional") |>
    paste0("/pals.RDS")

  if (!is.character(pal)) {
    stop("`pal` must be a character vector (named preferably)!")
  }

  if (!file_name %in% list.files(path.package(package = "ggProfessional"), full.names = TRUE)) {
    saveRDS(list(), file_name)
  }

  pals <- readr::read_rds(file_name)

  # overwrite >> remove previous with the same name
  keep_these <- purrr::map_lgl(pals, ~ !.[[1]] %in% name)

  pals <- pals[keep_these]

  pals |>
    append(list(list(name = name, pal = pal))) |>
    saveRDS(file = file_name)
}

