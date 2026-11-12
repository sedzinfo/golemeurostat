# Run the Eurostat Indicators Explorer

Starts the app. Each indicator is downloaded from Eurostat when a tab
first needs it, and kept on disk for a day (see
[`get_indicator()`](https://sedzinfo.github.io/golemeurostat/reference/get_indicator.md)),
so the first look at an indicator takes a second or two.

## Usage

``` r
run_app(
  onStart = NULL,
  options = list(),
  enableBookmarking = NULL,
  uiPattern = "/",
  ...
)
```

## Arguments

- onStart, options, enableBookmarking, uiPattern:

  Passed to
  [`shiny::shinyApp()`](https://rdrr.io/pkg/shiny/man/shinyApp.html).

- ...:

  Options of the app, see
  [`golem::get_golem_options()`](https://thinkr-open.github.io/golem/reference/get_golem_options.html).

## Value

A [`shiny::shinyApp()`](https://rdrr.io/pkg/shiny/man/shinyApp.html)
object; printing it opens the app.

## Examples

``` r
if (interactive()) run_app()
```
