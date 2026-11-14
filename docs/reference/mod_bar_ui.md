# Barplot module - UI

An indicator, how many countries to show and a country to pick, and the
countries ranked by the indicator, animated by year, with the picked
country in red.

## Usage

``` r
mod_bar_ui(id)
```

## Arguments

- id:

  Character. Module namespace id.

## Value

A `tagList` of Shiny UI elements.

## Examples

``` r
if (FALSE) { # \dontrun{
shiny::fluidPage(golemeurostat:::mod_bar_ui("bar"))
} # }
```
