##########################################################################################
#
##########################################################################################
#' @title About module - UI
#' @description A static page, as in golemworldbank: what the app shows, where
#' the data comes from, the acknowledgments, and the license and links of the
#' package. It has no inputs, so it has no module server.
#' @param id Character. Module namespace id.
#' @return A `tagList` of Shiny UI elements.
#' @keywords internal
#' @examples
#' \dontrun{
#' shiny::fluidPage(golemeurostat:::mod_about_ui("about"))
#' }
mod_about_ui <- function(id) {
  ns <- NS(id)
  # .noWS: no space between a link and the punctuation after it
  link <- function(href, text) tags$a(href = href, target = "_blank", rel = "noopener", text, .noWS = "outside")
  div(
    id = ns("page"),
    # centred in the tab: auto side margins, and width 100% since the tab is a flex
    # column, where auto margins would otherwise shrink the page to its text
    style = "width: 100%; max-width: 860px; margin: 0 auto; padding: 1.5rem 1rem;",
    h2("About"),
    p(
      strong("golemeurostat"), " is an interactive application for exploring the indicators of",
      " Eurostat, the statistical office of the European Union, for the countries of the EU and",
      " EFTA, the candidate countries and the regions of Europe: how one indicator changes over",
      " time across countries, how several indicators change for one country, population",
      " pyramids, ranked bar charts, scatterplots of two indicators, maps of the countries and of",
      " the regions, the change between two years, and the list of the indicators with their",
      " definitions."
    ),
    h3("Data"),
    p(
      "All the data comes from ", link("https://ec.europa.eu/eurostat", "Eurostat"),
      ", which allows it to be reused freely, with acknowledgment of the source (see its ",
      link("https://ec.europa.eu/eurostat/about-us/policies/copyright", "copyright notice"), ").",
      " Each indicator is downloaded from Eurostat's API when a chart first needs it, and kept",
      " for a day; the Change (%) tab compares values taken when the app was built. Values",
      " missing from Eurostat's data are missing from the charts too. The names and definitions",
      " in the Indicators tab are Eurostat's own, with a link to each dataset."
    ),
    h3("Acknowledgments"),
    p(
      "Thanks to ", strong("Eurostat"), " for making its data open and free to reuse, and to ",
      link("https://ec.europa.eu/eurostat/web/gisco", "GISCO"),
      " for the outlines of the countries and regions of the maps (© EuroGeographics for",
      " the administrative boundaries)."
    ),
    p(
      "The app is built with ",
      link("https://shiny.posit.co/", "Shiny"), " and ",
      link("https://thinkr-open.github.io/golem/", "golem"), "; the data is downloaded with the ",
      link("https://ropengov.github.io/eurostat/", "eurostat"), " package of rOpenGov, the charts are drawn with ",
      link("https://plotly.com/r/", "plotly"), " and the tables with ",
      link("https://rstudio.github.io/DT/", "DT"), " (DataTables). Thanks to their authors and to the R community."
    ),
    p(
      "The borders and names of the countries and regions are those of Eurostat and GISCO,",
      " and do not imply any judgment on the legal status of any territory."
    ),
    h3("License and source"),
    p(
      "golemeurostat is free software under the ",
      link("https://www.gnu.org/licenses/gpl-3.0.html", "GNU General Public License v3"), ".",
      " Source code: ", link("https://github.com/sedzinfo/golemeurostat", "github.com/sedzinfo/golemeurostat"),
      "; documentation: ", link("https://sedzinfo.github.io/golemeurostat/", "sedzinfo.github.io/golemeurostat"),
      "; issues and suggestions: ", link("https://github.com/sedzinfo/golemeurostat/issues", "the issues page"), "."
    ),
    p("Author and maintainer: Dimitrios Zacharatos.")
  )
}
