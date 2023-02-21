register_palette <- function(pal, name) {
  file_name <- path.package("ggProfessional") |>
    paste0("/pals.rds")

  if (!is.character(pal)) {
    stop("`pal` must be a character vector (named preferably)!")
  }

  pals <- readr::read_rds(file_name)

  # overwrite >> remove previous with the same name
  keep_these <- purrr::map_lgl(pals, ~ !.[[1]] %in% name)

  pals <- pals[keep_these]

  pals |>
    append(list(list(name = name, pal = pal))) |>
    saveRDS(file = file_name)
}

