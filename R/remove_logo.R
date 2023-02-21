#' Removes a locally registered a logo.
#'
#' @param name ..
#' @export


remove_logo <- function(name) {
  unlink(paste0(path.package("ggProfessional"), "/logos/", name, ".png"))
}
