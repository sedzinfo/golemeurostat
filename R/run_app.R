##########################################################################################
#
##########################################################################################
#' @title Run the Eurostat Indicators Explorer
#' @description Starts the app. Each indicator is downloaded from Eurostat when a
#' tab first needs it, and kept on disk for a day (see [get_indicator()]), so
#' the first look at an indicator takes a second or two.
#' @param analytics `TRUE` to add Google Analytics, through the cookie banner
#'   shared with the sites of sedzinfo.github.io, which loads it only after the
#'   visitor accepts. Meant for the public deployment (see `app.R`); off by
#'   default, so that running the app yourself sends nothing.
#' @param onStart,options,enableBookmarking,uiPattern Passed to
#'   [shiny::shinyApp()].
#' @param ... Options of the app, see [golem::get_golem_options()].
#' @return A [shiny::shinyApp()] object; printing it opens the app.
#' @import shiny
#' @importFrom golem with_golem_options
#' @export
#' @examples
#' if (interactive()) run_app()
run_app <- function(analytics = FALSE, onStart = NULL, options = list(), enableBookmarking = NULL, uiPattern = "/", ...) {
  with_golem_options(
    app = shinyApp(
      # shiny calls the ui function with the request only, so analytics is passed in here
      ui = function(request) app_ui(request, analytics),
      server = app_server,
      onStart = function() {
        # small values in full rather than as 1e-05, for this app run only
        old <- base::options(scipen = 999)
        onStop(function() base::options(old))
        if (!is.null(onStart)) onStart()
      },
      options = options,
      enableBookmarking = enableBookmarking,
      uiPattern = uiPattern
    ),
    golem_opts = list(...)
  )
}
