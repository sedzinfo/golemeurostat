# Indicator Comparison module - server

Downloads the picked indicators, or takes them from the disk cache,
offers only the countries that have values of at least one of them (see
`offer_countries()`), and draws them for the picked country.

## Usage

``` r
mod_indicator_comp_server(id)
```

## Arguments

- id:

  Character. Module namespace id, must match the id used in
  [`mod_indicator_comp_ui()`](https://sedzinfo.github.io/golemeurostat/reference/mod_indicator_comp_ui.md).

## Value

None. Called for its side effect of registering the module server.

## Examples

``` r
if (FALSE) { # \dontrun{
mod_indicator_comp_server("indicator_comp")
} # }
```
