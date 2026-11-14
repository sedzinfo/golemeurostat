# Indicator Comparison module - UI

Indicators and a country to pick, and a line per indicator over the
years, as in golemworldbank.

## Usage

``` r
mod_indicator_comp_ui(id)
```

## Arguments

- id:

  Character. Module namespace id.

## Value

A `tagList` of Shiny UI elements.

## Examples

``` r
if (FALSE) { # \dontrun{
shiny::fluidPage(golemeurostat:::mod_indicator_comp_ui("indicator_comp"))
} # }
```
