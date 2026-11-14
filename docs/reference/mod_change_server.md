# Change (%) module - server

Runs
[`indicator_change()`](https://sedzinfo.github.io/golemeurostat/reference/indicator_change.md)
for the picked country, years and checkboxes, and shows how many
indicators increased and decreased, and its two tables with
[`render_change_table()`](https://sedzinfo.github.io/golemeurostat/reference/render_change_table.md).
Asks for two different years, and shows the error of
[`indicator_change()`](https://sedzinfo.github.io/golemeurostat/reference/indicator_change.md)
(no values in either year) in place of the tables.

## Usage

``` r
mod_change_server(id)
```

## Arguments

- id:

  Character. Module namespace id, must match the id used in
  [`mod_change_ui()`](https://sedzinfo.github.io/golemeurostat/reference/mod_change_ui.md).

## Value

None. Called for its side effect of registering the module server.

## Examples

``` r
if (FALSE) { # \dontrun{
mod_change_server("change")
} # }
```
