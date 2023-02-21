set_palette <- function(name, attach = FALSE, low = NULL, high = NULL) {
  file_name <- path.package("ggProfessional") |>
    paste0("/pals.rds")

  pals <- readr::read_rds(file_name) |>
    purrr::keep(~ .[[1]] == name) |>
    dplyr::first() |>
    (\(x) {
      if (is.null(names(x[[2]]))) {
        names(x[[2]]) <- x[[2]]
        x[[2]]
      }
    }) ()

  if (length(pals) < 7) {
    added_pal <- scales::hue_pal()(7)
    names(added_pal) <- scales::hue_pal()(7)
    pals <- c(pals, added_pal)
  }

  .co_pal <<- pals

  .co <<- function(x) {
    out <- .co_pal[x]
    names(out) <- NULL
    out
  }

  if (attach) {

    if (is.null(low)) {
      low <- 1
    }

    if (is.null(high)) {
      high <- 2
    }

    names(pals) <- NULL
    pacman::p_load_gh("Mikata-Project/ggthemr")

    t <- ggplot2::theme_get()
    ggthemr::ggthemr(
      ggthemr::define_palette(
        swatch = c(pals),
        gradient = c(lower = .co_pal[low], .co_pal[high])
      )
    )
    ggplot2::theme_set(t)
  }

}
