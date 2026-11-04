##########################################################################################
#
##########################################################################################
#' @title Indicators module - UI
#' @description The table of the indicators of the app, with their definitions
#' and links to their datasets at Eurostat.
#' @param id Character. Module namespace id.
#' @return A `tagList` of Shiny UI elements.
#' @keywords internal
#' @examples
#' \dontrun{
#' shiny::fluidPage(golemeurostat:::mod_index_table_ui("index_table"))
#' }
mod_index_table_ui <- function(id) {
  ns <- NS(id)
  tagList(DT::dataTableOutput(ns("table")))
}
##########################################################################################
#
##########################################################################################
#' @title Indicators module - server
#' @description Renders the table of the indicators.
#' @param id Character. Module namespace id, must match the id used in
#'   [mod_index_table_ui()].
#' @return None. Called for its side effect of registering the module server.
#' @keywords internal
#' @examples
#' \dontrun{
#' mod_index_table_server("index_table")
#' }
mod_index_table_server <- function(id) {
  moduleServer(id, function(input, output, session) {
    output$table <- DT::renderDataTable(render_index_table())
  })
}
