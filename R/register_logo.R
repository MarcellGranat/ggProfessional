register_logo <- function(path, name) {
  file.copy(from = path, to = paste0(path.package("ggProfessional"), "/logos/", name, ".png"))
}
