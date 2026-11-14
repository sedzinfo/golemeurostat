##########################################################################################
#
##########################################################################################
#' @title Change (%) module - UI
#' @description As in golemworldbank: a country, the two years to compare, the
#' two checkboxes of [indicator_change()] (rates of change, changes of sign), a
#' note that the comparison is automatic and needs interpretation, a one-line
#' summary, and the indicators that increased and decreased, in two tabs.
#' @param id Character. Module namespace id.
#' @return A `tagList` of Shiny UI elements.
#' @keywords internal
#' @examples
#' \dontrun{
#' shiny::fluidPage(golemeurostat:::mod_change_ui("change"))
#' }
mod_change_ui <- function(id) {
  ns <- NS(id)
  years <- change_years()
  built <- attr(all_values(), "built")
  tagList(
    fluidRow(
      column(4, selectizeInput(ns("country"), label = "Country", choices = country_choices(average = TRUE), selected = "EL", width = "100%")),
      column(2, selectInput(ns("year1"), label = "From", choices = years$years, selected = years$from, width = "100%")),
      column(2, selectInput(ns("year2"), label = "To", choices = years$years, selected = years$to, width = "100%")),
      column(
        4,
        checkboxInput(ns("rates"), "Include rates of change (% change, growth)", value = FALSE),
        checkboxInput(ns("sign"), "Include indicators that changed sign", value = FALSE)
      )
    ),
    # these tables are a mechanical comparison of two years, not an analysis
    tags$p(
      class = "text-muted small", style = "margin-bottom:6px;",
      tags$b("Note:"),
      "these tables are produced automatically by comparing the two selected years,",
      "and need interpretation. Change % is (To - From) / |From| x 100, the change",
      "relative to the starting value; for indicators that are already percentages",
      "(e.g. % of the population) it is not the difference in percentage points, which is",
      "the Change column. A change can come from a data revision, a missing or",
      "estimated value, a break in the series or a change of method rather than a real",
      "change, and a large percent change from a small starting value can matter little.",
      "Check the indicator's definition (Indicators tab) and its full time series",
      "(Country Comparison tab) before drawing conclusions.",
      if (!is.null(built)) paste0("The values are those of Eurostat on ", format(built, "%Y-%m-%d"), ", when the app was built; the other tabs download the latest.")
    ),
    textOutput(ns("summary")),
    tabsetPanel(
      tabPanel("Increased", DT::dataTableOutput(ns("increased"))),
      tabPanel("Decreased", DT::dataTableOutput(ns("decreased")))
    )
  )
}
##########################################################################################
#
##########################################################################################
#' @title Change (%) module - server
#' @description Runs [indicator_change()] for the picked country, years and
#' checkboxes, and shows how many indicators increased and decreased, and its
#' two tables with [render_change_table()]. Asks for two different years, and
#' shows the error of [indicator_change()] (no values in either year) in place
#' of the tables.
#' @param id Character. Module namespace id, must match the id used in
#'   [mod_change_ui()].
#' @return None. Called for its side effect of registering the module server.
#' @keywords internal
#' @examples
#' \dontrun{
#' mod_change_server("change")
#' }
mod_change_server <- function(id) {
  moduleServer(id, function(input, output, session) {
    res <- reactive({
      req(input$country, input$year1, input$year2)
      validate(need(input$year1 != input$year2, "Choose two different years."))
      tryCatch(
        indicator_change(input$country, input$year1, input$year2, include_rates = isTRUE(input$rates), include_sign_change = isTRUE(input$sign)),
        error = function(e) validate(need(FALSE, conditionMessage(e)))
      )
    })
    output$summary <- renderText({
      r <- res()
      paste0(
        nrow(r$increased), " indicators increased and ", nrow(r$decreased), " decreased from ",
        input$year1, " to ", input$year2, " (only indicators with a value in both years)."
      )
    })
    output$increased <- DT::renderDataTable(render_change_table(res()$increased))
    output$decreased <- DT::renderDataTable(render_change_table(res()$decreased))
  })
}
