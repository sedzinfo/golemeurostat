# Get an indicator for the countries

Downloads one indicator of
[`indicators()`](https://sedzinfo.github.io/golemeurostat/reference/indicators.md)
from Eurostat, or takes it from the disk cache when it was downloaded
less than a day ago, for the countries of
[`countries()`](https://sedzinfo.github.io/golemeurostat/reference/countries.md)
and the EU-27 average. A value in the wrong units, more than 1,000 times
the median of its year and of its country, is left out, and so is a
value of `inst/extdata/errors.csv`, plainly wrong in the data of
Eurostat, such as a share of 933.2% for 93.32%.

## Usage

``` r
get_indicator(id)
```

## Arguments

- id:

  The `id` of the indicator in
  [`indicators()`](https://sedzinfo.github.io/golemeurostat/reference/indicators.md),
  such as "unemployment".

## Value

A data frame with `geo` (the Eurostat code), `country`, `group`, `year`
and `value`, or `NULL` with a message when Eurostat cannot be reached.

## Examples

``` r
if (FALSE) { # \dontrun{
get_indicator("unemployment")
} # }
```
