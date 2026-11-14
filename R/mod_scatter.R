##########################################################################################
#
##########################################################################################
#' @title Scatterplot module - UI
#' @description Two indicators to pick, and the countries plotted by the two,
#' animated by year.
#' @param id Character. Module namespace id.
#' @return A `tagList` of Shiny UI elements.
#' @keywords internal
#' @examples
#' \dontrun{
#' shiny::fluidPage(golemeurostat:::mod_scatter_ui("scatter"))
#' }
mod_scatter_ui <- function(id) {
  ns <- NS(id)
  tagList(
    fluidRow(
      column(6, selectizeInput(ns("x"), label = "Horizontal axis", choices = NULL, width = "100%", options = indicator_options())),
      column(6, selectizeInput(ns("y"), label = "Vertical axis", choices = NULL, width = "100%", options = indicator_options()))
    ),
    plotly::plotlyOutput(ns("plot"), width = "100%", height = "100%")
  )
}
##########################################################################################
#
##########################################################################################
#' @title Scatterplot module - server
#' @description Downloads the two picked indicators, or takes them from the disk
#' cache, and draws the countries by the two.
#' @param id Character. Module namespace id, must match the id used in
#'   [mod_scatter_ui()].
#' @return None. Called for its side effect of registering the module server.
#' @keywords internal
#' @examples
#' \dontrun{
#' mod_scatter_server("scatter")
#' }
mod_scatter_server <- function(id) {
  moduleServer(id, function(input, output, session) {
    fill_indicators(session, "x", "gdp_pps")
    fill_indicators(session, "y", "life_expectancy")
    x_data <- reactive({
      req(input$x)
      get_indicator(input$x)
    })
    y_data <- reactive({
      req(input$y)
      get_indicator(input$y)
    })
    output$plot <- plotly::renderPlotly({
      validate(need(x_data(), "Eurostat cannot be reached right now"), need(y_data(), "Eurostat cannot be reached right now"))
      p <- plot_scatter(x_data(), y_data(), input$x, input$y)
      validate(need(p, "The two indicators have no year in common"))
      p
    })
  })
}
