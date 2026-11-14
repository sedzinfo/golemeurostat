# Scatterplot module - UI

Two indicators to pick, side by side as in golemworldbank, and the
countries plotted by the two as bubbles as large as their population,
animated by year.

## Usage

``` r
mod_scatter_ui(id)
```

## Arguments

- id:

  Character. Module namespace id.

## Value

A `tagList` of Shiny UI elements.

## Examples

``` r
if (FALSE) { # \dontrun{
shiny::fluidPage(golemeurostat:::mod_scatter_ui("scatter"))
} # }
```
