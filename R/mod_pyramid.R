##########################################################################################
#
##########################################################################################
#' @title Pyramid module - UI
#' @description A country to pick, and its population pyramid, animated by
#' year, as in golemworldbank.
#' @param id Character. Module namespace id.
#' @return A `tagList` of Shiny UI elements.
#' @keywords internal
#' @examples
#' \dontrun{
#' shiny::fluidPage(golemeurostat:::mod_pyramid_ui("pyramid"))
#' }
mod_pyramid_ui <- function(id) {
  ns <- NS(id)
  tagList(
    fluidRow(
      column(4, selectizeInput(ns("country"), label = "Country", choices = country_choices(average = TRUE), selected = "EL", width = "100%"))
    ),
    plotly::plotlyOutput(ns("plot"), width = "100%", height = "100%")
  )
}
##########################################################################################
#
##########################################################################################
#' @title Pyramid module - server
#' @description Downloads the population of the picked country by age group and
#' sex, or takes it from the disk cache, and draws its pyramid.
#' @param id Character. Module namespace id, must match the id used in
#'   [mod_pyramid_ui()].
#' @return None. Called for its side effect of registering the module server.
#' @keywords internal
#' @examples
#' \dontrun{
#' mod_pyramid_server("pyramid")
#' }
mod_pyramid_server <- function(id) {
  moduleServer(id, function(input, output, session) {
    data <- reactive({
      req(input$country)
      get_pyramid(input$country)
    })
    output$plot <- plotly::renderPlotly({
      validate(need(data(), "Eurostat cannot be reached right now"))
      validate(need(nrow(data()) > 0, "Eurostat has no population by age group for this country"))
      plot_pyramid(data(), input$country)
    })
  })
}
