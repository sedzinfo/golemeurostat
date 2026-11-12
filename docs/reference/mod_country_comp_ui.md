# Country Comparison module - UI

Countries and an indicator to pick, and a line per country over the
years, with the EU-27 average.

## Usage

``` r
mod_country_comp_ui(id)
```

## Arguments

- id:

  Character. Module namespace id.

## Value

A `tagList` of Shiny UI elements.

## Examples

``` r
if (FALSE) { # \dontrun{
shiny::fluidPage(golemeurostat:::mod_country_comp_ui("country_comp"))
} # }
```
