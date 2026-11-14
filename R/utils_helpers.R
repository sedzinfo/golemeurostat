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
#' @description Grouped by topic, in the order of the catalogue: the topics of
#' the hand-written indicators first, then those of Eurostat's main tables.
#' @param level "country" or "region".
#' @return A data frame with `label`, `value` (the id), `optgroup` (the topic)
#'   and `dataset`, as a select box filled by the server takes it.
#' @noRd
indicator_choices <- function(level = "country") {
  table <- indicators()
  table <- table[table$level == level, ]
  # selectize shows the groups in the order of their first option
  table <- table[order(match(table$topic, unique(table$topic))), ]
  data.frame(label = table$name, value = table$id, optgroup = table$topic, dataset = table$dataset)
}
##########################################################################################
#
##########################################################################################
#' @title The options of a select box of indicators
#' @description Searches the names and the dataset codes, such as "une_rt_a",
#' and shows every indicator when nothing is typed.
#' @noRd
indicator_options <- function() {
  list(searchField = c("label", "dataset"), maxOptions = nrow(indicators()), placeholder = "Type to search")
}
##########################################################################################
#
##########################################################################################
#' @title Fill a select box of indicators
#' @description The server sends the browser the indicators that match what is
#' typed, rather than the page carrying every one of them in each select box.
#' @param session The session of the module.
#' @param input_id The id of the select box in the module, such as "indicator".
#' @param selected The id of the indicator picked at first.
#' @param level "country" or "region".
#' @noRd
fill_indicators <- function(session, input_id, selected, level = "country") {
  updateSelectizeInput(session, input_id, choices = indicator_choices(level), selected = selected, server = TRUE)
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
