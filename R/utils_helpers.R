##########################################################################################
#
##########################################################################################
#' @title The font of the charts
#' @description Large and bold, as in golemworldbank.
#' @noRd
font_style <- list(size = 20, color = "gray25", weight = "bold")
##########################################################################################
#
##########################################################################################
#' @title Short labels for numbers
#' @description Three significant digits, with k, M, B or T for thousands,
#' millions, billions and trillions.
#' @param n Numbers.
#' @return Text, such as "10.4M" for 10,366,586.
#' @noRd
format_value <- function(n) {
  a <- abs(n)
  div <- ifelse(a >= 1e12, 1e12, ifelse(a >= 1e9, 1e9, ifelse(a >= 1e6, 1e6, ifelse(a >= 1e3, 1e3, 1))))
  suf <- ifelse(a >= 1e12, "T", ifelse(a >= 1e9, "B", ifelse(a >= 1e6, "M", ifelse(a >= 1e3, "k", ""))))
  paste0(trimws(formatC(signif(n / div, 3), format = "fg", digits = 3)), suf)
}
##########################################################################################
#
##########################################################################################
#' @title Pause and Stop buttons of the animated charts
#' @description Plotly adds the Play button and the slider of the years; Pause
#' stops at the year shown, Stop goes back to the first.
#' @param first_frame Name of the first frame, the first year.
#' @return A list for `updatemenus` of a plotly layout.
#' @noRd
animation_buttons <- function(first_frame) {
  # duration 0 makes plotly drop the queued frames instead of finishing them
  halt <- list(mode = "immediate", frame = list(duration = 0, redraw = TRUE), transition = list(duration = 0))
  list(
    list(
      type = "buttons",
      direction = "right",
      x = 0,
      y = 0,
      showactive = FALSE,
      buttons = list(
        list(label = "Pause", method = "animate", args = list(list(NULL), halt)),
        list(label = "Stop", method = "animate", args = list(list(first_frame), halt))
      )
    )
  )
}
##########################################################################################
#
##########################################################################################
#' @title The indicators to choose from
#' @description Grouped by topic, as a select box shows them.
#' @param level "country" or "region".
#' @return A named list of named vectors of ids.
#' @noRd
indicator_choices <- function(level = "country") {
  table <- indicators()
  table <- table[table$level == level, ]
  lapply(split(table, factor(table$topic, levels = unique(table$topic))), function(t) stats::setNames(t$id, t$name))
}
##########################################################################################
#
##########################################################################################
#' @title The countries to choose from
#' @description In alphabetical order, without the EU-27 average.
#' @return A named vector of Eurostat codes.
#' @noRd
country_choices <- function() {
  known <- countries()
  known <- known[known$group != "EU-27", ]
  known <- known[order(known$name), ]
  stats::setNames(known$code, known$name)
}
