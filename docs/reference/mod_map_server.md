# Map module - server

Downloads the picked indicator, or takes it from the disk cache, and
draws the map.

## Usage

``` r
mod_map_server(id)
```

## Arguments

- id:

  Character. Module namespace id, must match the id used in
  [`mod_map_ui()`](https://sedzinfo.github.io/golemeurostat/reference/mod_map_ui.md).

## Value

None. Called for its side effect of registering the module server.

## Examples

``` r
if (FALSE) { # \dontrun{
mod_map_server("map")
} # }
```
