##########################################################################################
#
##########################################################################################
#' @title Map module - UI
#' @description An indicator to pick, and a map of the countries colored by it,
#' animated by year.
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
    fluidRow(column(6, selectizeInput(ns("indicator"), label = "Indicator", choices = indicator_choices(), selected = "unemployment", width = "100%"))),
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
