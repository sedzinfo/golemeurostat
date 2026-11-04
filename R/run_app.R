##########################################################################################
#
##########################################################################################
#' @title Run the Eurostat Indicators Explorer
#' @description Starts the app. Each indicator is downloaded from Eurostat when a
#' tab first needs it, and kept on disk for a day (see [get_indicator()]), so
#' the first look at an indicator takes a second or two.
#' @param onStart,options,enableBookmarking,uiPattern Passed to
#'   [shiny::shinyApp()].
#' @param ... Options of the app, see [golem::get_golem_options()].
#' @return A [shiny::shinyApp()] object; printing it opens the app.
#' @import shiny
#' @importFrom golem with_golem_options
#' @export
#' @examples
#' if (interactive()) run_app()
run_app <- function(onStart = NULL, options = list(), enableBookmarking = NULL, uiPattern = "/", ...) {
  with_golem_options(
    app = shinyApp(
      ui = app_ui,
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
