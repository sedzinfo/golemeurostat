##########################################################################################
#
##########################################################################################
#' @title Country Comparison module - UI
#' @description Countries and an indicator to pick, one under the other across
#' the page, as in golemworldbank, and a line per country over the years, with
#' the EU-27 average.
#' @param id Character. Module namespace id.
#' @return A `tagList` of Shiny UI elements.
#' @keywords internal
#' @examples
#' \dontrun{
#' shiny::fluidPage(golemeurostat:::mod_country_comp_ui("country_comp"))
#' }
mod_country_comp_ui <- function(id) {
  ns <- NS(id)
  tagList(
    selectizeInput(ns("countries"), label = "Countries", choices = country_choices(), selected = c("EL", "BG"), multiple = TRUE, width = "100%"),
    selectizeInput(ns("indicator"), label = "Indicator", choices = NULL, width = "100%", options = indicator_options()),
    plotly::plotlyOutput(ns("plot"), width = "100%", height = "100%")
  )
}
##########################################################################################
#
##########################################################################################
#' @title Country Comparison module - server
#' @description Downloads the picked indicator, or takes it from the disk cache,
#' and draws the picked countries.
#' @param id Character. Module namespace id, must match the id used in
#'   [mod_country_comp_ui()].
#' @return None. Called for its side effect of registering the module server.
#' @keywords internal
#' @examples
#' \dontrun{
#' mod_country_comp_server("country_comp")
#' }
mod_country_comp_server <- function(id) {
  moduleServer(id, function(input, output, session) {
    fill_indicators(session, "indicator", "gdp_pps")
    data <- reactive({
      req(input$indicator)
      get_indicator(input$indicator)
    })
    output$plot <- plotly::renderPlotly({
      validate(need(data(), "Eurostat cannot be reached right now"))
      req(input$countries)
      plot_country_comp(data(), input$countries, input$indicator)
    })
  })
}
