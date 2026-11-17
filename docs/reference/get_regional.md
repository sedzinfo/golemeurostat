# Get an indicator for the regions

Downloads one regional indicator of
[`indicators()`](https://sedzinfo.github.io/golemeurostat/reference/indicators.md)
from Eurostat, or takes it from the disk cache when it was downloaded
less than a day ago, for the regions of the NUTS 2024 classification at
level 2, without the values of `inst/extdata/errors.csv`, plainly wrong
in the data of Eurostat.

## Usage

``` r
get_regional(id)
```

## Arguments

- id:

  The `id` of a regional indicator in
  [`indicators()`](https://sedzinfo.github.io/golemeurostat/reference/indicators.md),
  such as "r_unemployment".

## Value

A data frame with `geo` (the NUTS code), `region`, `country`, `year` and
`value`, or `NULL` with a message when Eurostat or the outlines of the
regions cannot be reached.

## Examples

``` r
if (FALSE) { # \dontrun{
get_regional("r_gdp_pps")
} # }
```
