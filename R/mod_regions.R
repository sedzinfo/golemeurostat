##########################################################################################
#
##########################################################################################
#' @title Regions module - UI
#' @description A regional indicator to pick, across the page, and a map of the
#' regions of Europe colored by it, animated by year, as the map of the
#' countries.
#' @param id Character. Module namespace id.
#' @return A `tagList` of Shiny UI elements.
#' @keywords internal
#' @examples
#' \dontrun{
#' shiny::fluidPage(golemeurostat:::mod_regions_ui("regions"))
#' }
mod_regions_ui <- function(id) {
  ns <- NS(id)
  tagList(
    selectizeInput(ns("indicator"), label = "Indicator", choices = NULL, width = "100%", options = indicator_options()),
    plotly::plotlyOutput(ns("plot"), width = "100%", height = "100%")
  )
}
##########################################################################################
#
##########################################################################################
#' @title Regions module - server
#' @description Downloads the picked regional indicator, or takes it from the
#' disk cache, and draws the map.
#' @param id Character. Module namespace id, must match the id used in
#'   [mod_regions_ui()].
#' @return None. Called for its side effect of registering the module server.
#' @keywords internal
#' @examples
#' \dontrun{
#' mod_regions_server("regions")
#' }
mod_regions_server <- function(id) {
  moduleServer(id, function(input, output, session) {
    fill_indicators(session, "indicator", "r_gdp_pps", level = "region")
    data <- reactive({
      req(input$indicator)
      get_regional(input$indicator)
    })
    output$plot <- plotly::renderPlotly({
      validate(need(data(), "Eurostat or the outlines of the regions cannot be reached right now"))
      plot_regions(data(), input$indicator)
    })
  })
}
