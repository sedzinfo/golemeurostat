# Indicators module - server

Renders the table of the indicators.

## Usage

``` r
mod_index_table_server(id)
```

## Arguments

- id:

  Character. Module namespace id, must match the id used in
  [`mod_index_table_ui()`](https://sedzinfo.github.io/golemeurostat/reference/mod_index_table_ui.md).

## Value

None. Called for its side effect of registering the module server.

## Examples

``` r
if (FALSE) { # \dontrun{
mod_index_table_server("index_table")
} # }
```
