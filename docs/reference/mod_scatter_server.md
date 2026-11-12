# Scatterplot module - server

Downloads the two picked indicators, or takes them from the disk cache,
and draws the countries by the two.

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
