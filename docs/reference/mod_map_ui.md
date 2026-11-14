# Map module - UI

An indicator to pick, across the page, and a map of the countries
colored by it, animated by year, as in golemworldbank.

## Usage

``` r
mod_map_ui(id)
```

## Arguments

- id:

  Character. Module namespace id.

## Value

A `tagList` of Shiny UI elements.

## Examples

``` r
if (FALSE) { # \dontrun{
shiny::fluidPage(golemeurostat:::mod_map_ui("map"))
} # }
```
