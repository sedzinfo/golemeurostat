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
#' offers only the countries that have values of it (see `offer_countries()`),
#' and draws those picked.
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
    countries <- offer_countries(session, "countries", reactive(data()$geo), c("EL", "BG"), multiple = TRUE)
    output$plot <- plotly::renderPlotly({
      validate(need(data(), "Eurostat cannot be reached right now"))
      validate(need(countries(), "Pick one or more countries"))
      plot_country_comp(data(), countries(), input$indicator)
    })
  })
}
