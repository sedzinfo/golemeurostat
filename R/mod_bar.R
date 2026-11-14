##########################################################################################
#
##########################################################################################
#' @title Barplot module - UI
#' @description An indicator and a country to pick, and the countries ranked by
#' the indicator, animated by year, with the picked country in red.
#' @param id Character. Module namespace id.
#' @return A `tagList` of Shiny UI elements.
#' @keywords internal
#' @examples
#' \dontrun{
#' shiny::fluidPage(golemeurostat:::mod_bar_ui("bar"))
#' }
mod_bar_ui <- function(id) {
  ns <- NS(id)
  tagList(
    fluidRow(
      column(6, selectizeInput(ns("indicator"), label = "Indicator", choices = NULL, width = "100%", options = indicator_options())),
      column(3, selectizeInput(ns("country"), label = "Country in red", choices = country_choices(), selected = "EL", width = "100%"))
    ),
    plotly::plotlyOutput(ns("plot"), width = "100%", height = "100%")
  )
}
##########################################################################################
#
##########################################################################################
#' @title Barplot module - server
#' @description Downloads the picked indicator, or takes it from the disk cache,
#' and draws the race of the countries.
#' @param id Character. Module namespace id, must match the id used in
#'   [mod_bar_ui()].
#' @return None. Called for its side effect of registering the module server.
#' @keywords internal
#' @examples
#' \dontrun{
#' mod_bar_server("bar")
#' }
mod_bar_server <- function(id) {
  moduleServer(id, function(input, output, session) {
    fill_indicators(session, "indicator", "net_earnings")
    data <- reactive({
      req(input$indicator)
      get_indicator(input$indicator)
    })
    output$plot <- plotly::renderPlotly({
      validate(need(data(), "Eurostat cannot be reached right now"))
      plot_bar(data(), input$indicator, input$country)
    })
  })
}
