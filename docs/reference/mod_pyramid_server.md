# Pyramid module - server

Downloads the population of the picked country by age group and sex, or
takes it from the disk cache, and draws its pyramid.

## Usage

``` r
mod_pyramid_server(id)
```

## Arguments

- id:

  Character. Module namespace id, must match the id used in
  [`mod_pyramid_ui()`](https://sedzinfo.github.io/golemeurostat/reference/mod_pyramid_ui.md).

## Value

None. Called for its side effect of registering the module server.

## Examples

``` r
if (FALSE) { # \dontrun{
mod_pyramid_server("pyramid")
} # }
```
