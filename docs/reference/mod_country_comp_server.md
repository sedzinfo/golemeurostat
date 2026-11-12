# Country Comparison module - server

Downloads the picked indicator, or takes it from the disk cache, and
draws the picked countries.

## Usage

``` r
mod_country_comp_server(id)
```

## Arguments

- id:

  Character. Module namespace id, must match the id used in
  [`mod_country_comp_ui()`](https://sedzinfo.github.io/golemeurostat/reference/mod_country_comp_ui.md).

## Value

None. Called for its side effect of registering the module server.

## Examples

``` r
if (FALSE) { # \dontrun{
mod_country_comp_server("country_comp")
} # }
```
