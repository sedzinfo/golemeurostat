##########################################################################################
#
##########################################################################################
#' @title Indicator Comparison module - UI
#' @description Indicators and a country to pick, one under the other across
#' the page, and a line per indicator over the years, as in golemworldbank.
#' @param id Character. Module namespace id.
#' @return A `tagList` of Shiny UI elements.
#' @keywords internal
#' @examples
#' \dontrun{
#' shiny::fluidPage(golemeurostat:::mod_indicator_comp_ui("indicator_comp"))
#' }
mod_indicator_comp_ui <- function(id) {
  ns <- NS(id)
  tagList(
    selectizeInput(ns("indicators"), label = "Indicators", choices = NULL, multiple = TRUE, width = "100%", options = indicator_options()),
    selectizeInput(ns("country"), label = "Country", choices = country_choices(average = TRUE), selected = "EL", width = "100%"),
    plotly::plotlyOutput(ns("plot"), width = "100%", height = "100%")
  )
}
##########################################################################################
#
##########################################################################################
#' @title Indicator Comparison module - server
#' @description Downloads the picked indicators, or takes them from the disk
#' cache, and draws them for the picked country.
#' @param id Character. Module namespace id, must match the id used in
#'   [mod_indicator_comp_ui()].
#' @return None. Called for its side effect of registering the module server.
#' @keywords internal
#' @examples
#' \dontrun{
#' mod_indicator_comp_server("indicator_comp")
#' }
mod_indicator_comp_server <- function(id) {
  moduleServer(id, function(input, output, session) {
    fill_indicators(session, "indicators", c("unemployment", "youth_unemployment"))
    data <- reactive({
      req(input$indicators)
      stats::setNames(lapply(input$indicators, get_indicator), input$indicators)
    })
    output$plot <- plotly::renderPlotly({
      req(input$country)
      validate(need(!any(vapply(data(), is.null, TRUE)), "Eurostat cannot be reached right now"))
      p <- plot_indicator_comp(data(), input$country, input$indicators)
      validate(need(p, "No values of these indicators for this country"))
      p
    })
  })
}
