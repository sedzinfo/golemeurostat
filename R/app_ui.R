##########################################################################################
#
##########################################################################################
#' @title The application user interface
#' @description A navbar page with one tab per module, in the layout of
#' golemworldbank, which the two apps share (`shared_layout()`): a compact
#' navbar, and charts that fill the window under their controls.
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
#' The scripts and stylesheets that several apps use (the dark mode, the layout) are kept once,
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
#' The layout shared with golemworldbank
#'
#' \code{layout.css}: a compact navbar, and tabs that fill the window, with charts that stretch
#' to its bottom; on phones, a page that scrolls, with entries big enough for a finger.
#' \code{layout.js}: the charts laid out for a phone. Both from sedzinfo.github.io
#' (\code{shared_url}), for the head of the page, after \code{shared_css()}.
#'
#' @noRd
shared_layout <- function() {
  tagList(
    tags$link(rel = "stylesheet", href = paste0(shared_url, "layout.css")),
    tags$script(src = paste0(shared_url, "layout.js"))
  )
}
##########################################################################################
#
##########################################################################################
#' @title Description of the app, for search engines and link previews
#' @description Used by `golem_add_external_resources()`, as in golemworldbank:
#' the description that search engines show, and the Open Graph tags of the
#' preview that other sites show for a link to the app. `title` is the window
#' title that `app_ui()` gives the page. `url`, the address of the live app, and
#' `image`, a screenshot of it, are left out of the page while they are `NULL`:
#' fill them in once the app is deployed.
#' @noRd
app_meta <- list(
  url = NULL,
  title = "Eurostat",
  description = "Explore Eurostat indicators for the countries and regions of Europe with interactive country and indicator comparisons, population pyramids, bar charts, scatter plots and maps.",
  image = NULL
)
##########################################################################################
#
##########################################################################################
#' @title Add external resources to the application
#' @description The description and Open Graph tags of `app_meta`, the favicon,
#' any CSS and JavaScript file of `inst/app/www`, the stylesheet, the layout and
#' the dark mode that the apps share on sedzinfo.github.io (`shared_css()`,
#' `shared_layout()`, `shared_url`), and the outlines of the regions of the
#' map, downloaded once and served under `nuts/`; those of the countries are in
#' `inst/app/www`, served under `www/`.
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
  # the maps ask the browser for the outlines: those of the countries are in www, and those of
  # the regions are downloaded the first time only
  nuts_file(2)
  addResourcePath("nuts", nuts_dir())
  tags$head(
    tags$meta(name = "description", content = app_meta$description),
    tags$meta(property = "og:type", content = "website"),
    tags$meta(property = "og:site_name", content = "sedzinfo"),
    tags$meta(property = "og:title", content = app_meta$title),
    tags$meta(property = "og:description", content = app_meta$description),
    if (!is.null(app_meta$url)) tags$meta(property = "og:url", content = app_meta$url),
    if (!is.null(app_meta$image)) {
      tagList(
        tags$meta(property = "og:image", content = app_meta$image),
        tags$meta(name = "twitter:card", content = "summary_large_image")
      )
    },
    favicon(ext = "svg"),
    shared_css(),
    shared_layout(),
    bundle_resources(path = app_sys("app/www"), app_title = "Eurostat"),
    tags$script(src = paste0(shared_url, "dark_mode.js"))
  )
}
