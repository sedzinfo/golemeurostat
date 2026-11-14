# Scatterplot module - server

Downloads the two picked indicators and the population, or takes them
from the disk cache, and draws the countries by the two, as bubbles as
large as their population; all of one size when the population cannot be
downloaded.

## Usage

``` r
mod_scatter_server(id)
```

## Arguments

- id:

  Character. Module namespace id, must match the id used in
  [`mod_scatter_ui()`](https://sedzinfo.github.io/golemeurostat/reference/mod_scatter_ui.md).

## Value

None. Called for its side effect of registering the module server.

## Examples

``` r
if (FALSE) { # \dontrun{
mod_scatter_server("scatter")
} # }
```
