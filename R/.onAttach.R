.onAttach <- function(...) {
  `-.gg` <<- function(e1, e2) e2(e1)
  assign(`-.gg`, `-.gg`, envir = globalenv())
  .gg_finalise <<- function(plot = ggplot2::last_plot()) {
    plot
  }
}
