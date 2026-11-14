# Run the Eurostat Indicators Explorer

Starts the app, with the tabs of golemworldbank: country and indicator
comparisons, a population pyramid, a bar chart race, a scatter plot,
maps of the countries and of the regions, the change of the indicators
between two years, the list of the indicators and an About page. Each
indicator is downloaded from Eurostat when a tab first needs it, and
kept on disk for a day (see
[`get_indicator()`](https://sedzinfo.github.io/golemeurostat/reference/get_indicator.md)),
so the first look at an indicator takes a second or two.

## Usage

``` r
run_app(
  analytics = FALSE,
  onStart = NULL,
  options = list(),
  enableBookmarking = NULL,
  uiPattern = "/",
  ...
)
```

## Arguments

- analytics:

  `TRUE` to add Google Analytics, through the cookie banner shared with
  the sites of sedzinfo.github.io, which loads it only after the visitor
  accepts. Meant for the public deployment (see `app.R`); off by
  default, so that running the app yourself sends nothing.

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
