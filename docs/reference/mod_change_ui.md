# Change (%) module - UI

As in golemworldbank: a country, the two years to compare, the two
checkboxes of
[`indicator_change()`](https://sedzinfo.github.io/golemeurostat/reference/indicator_change.md)
(rates of change, changes of sign), a note that the comparison is
automatic and needs interpretation, a one-line summary, and the
indicators that increased and decreased, by percent change, and those
that are percentages, by percentage points, in four tabs.

## Usage

``` r
mod_change_ui(id)
```

## Arguments

- id:

  Character. Module namespace id.

## Value

A `tagList` of Shiny UI elements.

## Examples

``` r
if (FALSE) { # \dontrun{
shiny::fluidPage(golemeurostat:::mod_change_ui("change"))
} # }
```
