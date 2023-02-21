#' Register a logo locally.
#'
#' @param path ..
#' @param name ..
#' @export

register_logo <- function(path, name) {
  if (!"logos" %in% list.dirs(path.package("ggProfessional"), full.names = FALSE)) {
    dir.create(paste0(path.package("ggProfessional"), "/logos/"))
  }

  file_name <- paste0(path.package("ggProfessional"), "/logos/", name, ".png")

  if (file_name %in% list.files(paste0(path.package("ggProfessional"), "/logos"), full.names = TRUE)) {
    unlink(file_name)
  }

  file.copy(from = path, to = file_name)
}
