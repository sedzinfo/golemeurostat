##########################################################################################
#
##########################################################################################
#' @title Address of the cookie banner shared by the sites of sedzinfo.github.io
#' @noRd
consent_script <- "https://sedzinfo.github.io/consent.js"
##########################################################################################
#
##########################################################################################
#' @title Google Analytics for the public deployment
#' @description As in golemworldbank: loads the cookie banner shared with the
#' sites of sedzinfo.github.io, which loads Google Analytics only after the
#' visitor accepts, and two files shared by the apps (`shared_url`): the style of
#' the banner on Bootstrap 3, which lacks most of the Bootstrap 5 classes of the
#' banner (`analytics.css`), and the script that reports the tabs as pages
#' (`analytics.js`).
#' @return A `tagList` for the head of the page.
#' @keywords internal
#' @examples
#' golemeurostat:::analytics_resources()
analytics_resources <- function() {
  tagList(
    tags$script(src = consent_script, defer = NA),
    tags$link(rel = "stylesheet", href = paste0(shared_url, "analytics.css")),
    tags$script(src = paste0(shared_url, "analytics.js"))
  )
}
##########################################################################################
#
##########################################################################################
#' @title Footer with the links of the cookie banner
#' @description "Cookie settings" opens the banner again, so that visitors can
#' change their choice at any time, as the privacy note promises; "Privacy"
#' opens that note.
#' @return A `div` for the bottom of the page.
#' @keywords internal
#' @examples
#' golemeurostat:::analytics_footer()
analytics_footer <- function() {
  div(
    class = "analytics-footer",
    tags$a(href = "#cookie-settings", "Cookie settings"),
    HTML(" &middot; "),
    tags$a(href = "https://sedzinfo.github.io/privacy.html", "Privacy")
  )
}
