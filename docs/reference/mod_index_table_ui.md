# Indicators module - UI

The table of the indicators of the app, with their definitions and links
to their datasets at Eurostat.

## Usage

``` r
mod_index_table_ui(id)
```

## Arguments

- id:

  Character. Module namespace id.

## Value

A `tagList` of Shiny UI elements.

## Examples

``` r
if (FALSE) { # \dontrun{
shiny::fluidPage(golemeurostat:::mod_index_table_ui("index_table"))
} # }
```
