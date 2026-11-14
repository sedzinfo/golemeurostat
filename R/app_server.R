##########################################################################################
#
##########################################################################################
#' @title The application server logic
#' @description Wires up the module of each tab; each downloads the indicators
#' it shows when they are first picked, or takes them from the disk cache.
#' @param input,output,session Internal parameters for `{shiny}`.
#'   DO NOT REMOVE.
#' @import shiny
#' @noRd
#' @examples
#' \dontrun{
#' shiny::shinyApp(ui = app_ui, server = app_server)
#' }
app_server <- function(input, output, session) {
  mod_country_comp_server("country_comp")
  mod_indicator_comp_server("indicator_comp")
  mod_pyramid_server("pyramid")
  mod_bar_server("bar")
  mod_scatter_server("scatter")
  mod_map_server("map")
  mod_regions_server("regions")
  mod_change_server("change")
  mod_index_table_server("index_table")
}
