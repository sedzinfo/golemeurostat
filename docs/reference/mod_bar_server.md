# Barplot module - server

Downloads the picked indicator, or takes it from the disk cache, and
draws the race of the countries.

## Usage

``` r
mod_bar_server(id)
```

## Arguments

- id:

  Character. Module namespace id, must match the id used in
  [`mod_bar_ui()`](https://sedzinfo.github.io/golemeurostat/reference/mod_bar_ui.md).

## Value

None. Called for its side effect of registering the module server.

## Examples

``` r
if (FALSE) { # \dontrun{
mod_bar_server("bar")
} # }
```
