##########################################################################################
#
##########################################################################################
#' @title Map module - UI
#' @description An indicator to pick, across the page, and a map of the
#' countries colored by it, animated by year, as in golemworldbank.
#' @param id Character. Module namespace id.
#' @return A `tagList` of Shiny UI elements.
#' @keywords internal
#' @examples
#' \dontrun{
#' shiny::fluidPage(golemeurostat:::mod_map_ui("map"))
#' }
mod_map_ui <- function(id) {
  ns <- NS(id)
  tagList(
    selectizeInput(ns("indicator"), label = "Indicator", choices = NULL, width = "100%", options = indicator_options()),
    plotly::plotlyOutput(ns("plot"), width = "100%", height = "100%")
  )
}
##########################################################################################
#
##########################################################################################
#' @title Map module - server
#' @description Downloads the picked indicator, or takes it from the disk cache,
#' and draws the map.
#' @param id Character. Module namespace id, must match the id used in
#'   [mod_map_ui()].
#' @return None. Called for its side effect of registering the module server.
#' @keywords internal
#' @examples
#' \dontrun{
#' mod_map_server("map")
#' }
mod_map_server <- function(id) {
  moduleServer(id, function(input, output, session) {
    # the unemployment rate of Eurostat's social scoreboard, with nearly every country from 2005
    # (une_rt_a, of "unemployment", has most only from 2009)
    fill_indicators(session, "indicator", "tepsr_wc170_y15_74")
    data <- reactive({
      req(input$indicator)
      get_indicator(input$indicator)
    })
    output$plot <- plotly::renderPlotly({
      validate(need(data(), "Eurostat cannot be reached right now"))
      plot_map(data(), input$indicator)
    })
  })
}
