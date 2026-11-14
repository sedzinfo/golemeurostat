##########################################################################################
#
##########################################################################################
#' @title The application user interface
#' @description A navbar page with one tab per module, in the layout of
#' golemworldbank: a compact navbar, and charts that fill the window under
#' their controls.
#' @param request Internal parameter for `{shiny}`. DO NOT REMOVE.
#' @param analytics `TRUE` to add Google Analytics, with its cookie banner
#'   (see `analytics_resources()`) and a footer with the links of the banner
#'   (see `analytics_footer()`).
#' @import shiny
#' @noRd
#' @examples
#' \dontrun{
#' shiny::shinyApp(ui = app_ui, server = app_server)
#' }
app_ui <- function(request, analytics = FALSE) {
  tagList(
    golem_add_external_resources(),
    if (analytics) tags$head(analytics_resources()),
    # a spinner on a chart while its data download
    useBusyIndicators(),
    # compact navbar (outside navbarPage, which expects only tabs)
    tags$head(
      tags$style(HTML(".navbar-nav > li > a, .navbar-brand {
        padding-top:4px;
        padding-bottom:4px;
        height: 25px;
        }
        .navbar {min-height:20px;}
        /* charts fill the space left under the navbar and the controls */
        body {display:flex; flex-direction:column; height:100vh; margin:0;}
        body > .container-fluid {flex:1; width:100%;min-height:0; display:flex; flex-direction:column;}
        .tab-content {flex:1; min-height:0; display:flex;}
        .tab-content > .tab-pane.active {flex:1; min-width:0; min-height:0; display:flex; flex-direction:column; overflow:auto;}
        /* a Bootstrap row sticks out 15px on the right (margin-right:-15px), which would make the tab scroll sideways */
        .tab-pane > .row {margin-right:0;}
        .tab-pane .plotly.html-widget-output {flex:1 1 0; min-height:300px;}"))
    ),
    navbarPage(
      title = "Data: Eurostat",
      collapsible = TRUE,
      fluid = TRUE,
      windowTitle = "Eurostat",
      footer = if (analytics) analytics_footer(),
      # the tabs of golemworldbank, in its order, with two maps, of the countries and of the regions
      tabPanel(title = "Country Comparison", mod_country_comp_ui("country_comp")),
      tabPanel(title = "Indicator Comparison", mod_indicator_comp_ui("indicator_comp")),
      tabPanel(title = "Pyramid", mod_pyramid_ui("pyramid")),
      tabPanel(title = "Barplot", mod_bar_ui("bar")),
      tabPanel(title = "Scatterplot", mod_scatter_ui("scatter")),
      tabPanel(title = "Map", mod_map_ui("map")),
      tabPanel(title = "Regions", mod_regions_ui("regions")),
      tabPanel(title = "Change (%)", mod_change_ui("change")),
      tabPanel(title = "Indicators", mod_index_table_ui("index_table")),
      tabPanel(title = "About", mod_about_ui("about"))
    )
  )
}
##########################################################################################
#
##########################################################################################
#' Address of the files shared by the Shiny apps, on sedzinfo.github.io
#'
#' The scripts and stylesheets that several apps use (the dark mode) are kept once,
#' in the shiny folder of the sedzinfo.github.io repository, and each app loads
#' them from there: a fix reaches every app without deploying it again.
#'
#' @noRd
shared_url <- "https://sedzinfo.github.io/shiny/"
##########################################################################################
#
##########################################################################################
#' The stylesheet shared by the Shiny apps
#'
#' \code{https://sedzinfo.github.io/shiny/apps.css}, as a link for the head of the page, before
#' the app's own stylesheets. Shiny puts the head after the stylesheets of Bootstrap and of the
#' inputs, so the page loads those, then this, then the app's own, which can override it.
#'
#' @noRd
shared_css <- function() {
  tags$link(rel = "stylesheet", href = paste0(shared_url, "apps.css"))
}
##########################################################################################
#
##########################################################################################
#' @title Add external resources to the application
#' @description The favicon, any CSS and JavaScript file of `inst/app/www`, the
#' stylesheet and the dark mode that the apps share on sedzinfo.github.io
#' (`shared_css()`, `shared_url`), and the outlines of the countries and regions
#' of the maps, downloaded once and served under `nuts/`.
#' @import shiny
#' @importFrom golem add_resource_path favicon bundle_resources
#' @noRd
#' @examples
#' \dontrun{
#' # called from inside app_ui():
#' shiny::tagList(golem_add_external_resources(), shiny::fluidPage())
#' }
golem_add_external_resources <- function() {
  add_resource_path("www", app_sys("app/www"))
  # the maps ask the browser for the outlines; downloaded the first time only
  nuts_file(0)
  nuts_file(2)
  addResourcePath("nuts", nuts_dir())
  tags$head(
    favicon(ext = "svg"),
    shared_css(),
    bundle_resources(path = app_sys("app/www"), app_title = "Eurostat"),
    tags$script(src = paste0(shared_url, "dark_mode.js"))
  )
}
