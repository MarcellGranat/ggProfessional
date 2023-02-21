.onAttach <- function(...) {
  `-.gg` <<- function(e1, e2) e2(e1)
  .gg_finalise <<- function(plot = ggplot2::last_plot()) {
    plot
  }
}
