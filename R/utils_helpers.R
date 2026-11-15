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
#' @description In alphabetical order, and the EU-27 first when `average` is
#' `TRUE`.
#' @param average Offer the EU-27 too, for the tabs of one country.
#' @return A named vector of Eurostat codes.
#' @noRd
country_choices <- function(average = FALSE) {
  known <- countries()
  known <- known[known$group != "EU-27", ]
  known <- known[order(known$name), ]
  choices <- stats::setNames(known$code, known$name)
  if (average) c(`EU-27` = eu_average, choices) else choices
}
##########################################################################################
#
##########################################################################################
#' @title Offer only the countries that have values
#' @description As golemworldbank offers only the indicators that have values for
#' the countries picked, a select box of countries offers only those that have
#' values of the indicator of its tab, or of one of its indicators, so that it is
#' not cluttered with countries that give an empty chart: most indicators have none
#' for Ukraine, Georgia, Moldova or Liechtenstein. A country picked that has no
#' values is set aside, not forgotten, and is picked again with the next indicator
#' that has values for it; meanwhile, a select box of one country shows `selected`,
#' or, without values for it either, the first country with values.
#'
#' The select box follows the downloads of the tab, which wait, as its chart does,
#' until the tab is shown, so that a tab nobody opens downloads nothing.
#' @param session The session of the module.
#' @param input_id The id of the select box, such as "countries".
#' @param geo A reactive of the Eurostat codes that have values, such as
#'   `data()$geo`: `NULL` when Eurostat cannot be reached, which leaves the select
#'   box as it is.
#' @param selected The countries the select box opens with, as in its UI.
#' @param multiple Whether the select box takes several countries.
#' @param average Whether it offers the EU-27 too, as `country_choices()`.
#' @param output_id The id of the chart of the tab.
#' @return A reactive of the countries to draw: those picked that have values.
#' @noRd
offer_countries <- function(session, input_id, geo, selected, multiple = FALSE, average = FALSE, output_id = "plot") {
  input <- session$input
  choices <- country_choices(average)
  hidden <- paste0("output_", session$ns(output_id), "_hidden")
  # the countries picked, those set aside too, and those in the select box
  wanted <- selected
  offered <- choices
  shown <- reactiveVal(selected)
  # a pick first, then the select box that follows from it, then the chart, which draws once
  observeEvent(input[[input_id]], {
    value <- as.character(input[[input_id]])
    # the select box showing what it was sent
    if (setequal(value, shown())) {
      return()
    }
    wanted <<- if (multiple) {
      kept <- wanted[wanted %in% value | !wanted %in% offered]
      c(kept, setdiff(value, kept))
    } else {
      value
    }
    shown(value)
  }, ignoreNULL = FALSE, ignoreInit = TRUE, priority = 2)
  observe({
    req(!isTRUE(session$clientData[[hidden]]))
    # an error here would end the session
    have <- tryCatch(geo(), error = function(e) NULL)
    have <- choices[choices %in% have]
    req(length(have) > 0)
    show <- if (multiple) {
      wanted[wanted %in% have]
    } else if (isTRUE(wanted %in% have)) {
      wanted
    } else if (selected %in% have) {
      selected
    } else {
      unname(have[1])
    }
    changed <- !setequal(show, isolate(shown()))
    if (changed || !identical(have, offered)) {
      updateSelectizeInput(session, input_id, choices = have, selected = show)
    }
    offered <<- have
    if (changed) shown(show)
  }, priority = 1)
  shown
}
##########################################################################################
#
##########################################################################################
#' @title Keep the legend clicks of an animated chart
#' @description As in golemworldbank: plotly writes `visible` into every trace of
#' every frame, so a trace hidden with a click on the legend comes back on the
#' next frame. This removes `visible` from the frames, so the click lasts while
#' the animation plays. plotly also hides a trace, with `visible = FALSE`, in a
#' frame where it has no data, as a copy of its previous frame; that copy is
#' emptied instead, so nothing is drawn there.
#' @param p A plotly object with frames.
#' @return The plotly object, built.
#' @noRd
keep_legend_clicks <- function(p) {
  p <- plotly::plotly_build(p)
  without_visible <- function(trace) {
    if (isFALSE(trace$visible)) trace$x <- trace$y <- rep(NA, length(trace$x))
    trace$visible <- NULL
    trace
  }
  p$x$data <- lapply(p$x$data, without_visible)
  for (k in seq_along(p$x$frames)) {
    p$x$frames[[k]]$data <- lapply(p$x$frames[[k]]$data, without_visible)
  }
  p
}
