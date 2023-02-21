#' Read a given saved theme.
#'
#' @param name ..
#'
#' @return gg theme.
#' @export
#'

get_theme <- function(name) {
  path.package("ggProfessional") |>
    paste0("/theme.rds") |>
    readr::read_rds() |>
    keep(~ name == .[[1]]) |>
    first() |>
    pluck(2)
}
