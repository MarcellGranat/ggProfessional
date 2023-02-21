available_palettes <- function() {
  pals <- path.package("ggProfessional") |>
    paste0("/pals.rds") |>
    readr::read_rds()

  pals_df <- pals |>
    purrr::map_dfr(\(x) {
      if (is.null(names(x[[2]]))) {
        names(x[[2]]) <- x[[2]]
      }
      tibble::tibble(name = x[[1]], col_name = names(x[[2]]), col_id = x[[2]])
    })

  cols <- set_names(pals_df$col_id, pals_df$col_id)

  pals_df |>
    dplyr::group_by(name) |>
    dplyr::mutate(
      r = dplyr::row_number()
    ) |>
    ggplot2::ggplot() +
    ggplot2::aes(r, name, fill = col_id, label = col_name) +
    ggplot2::geom_tile(color = "black", show.legend = FALSE) +
    ggplot2::geom_text(color = "grey30") +
    ggplot2::theme_void() +
    ggplot2::theme(
      axis.text.y = element_text()
    ) +
    ggplot2::labs(title = "Palettes") +
    scale_fill_manual(values = cols)
}
