# Check the catalogue against Eurostat

Downloads each indicator of
[`indicators()`](https://sedzinfo.github.io/golemeurostat/reference/indicators.md)
from Eurostat, past the disk cache, and reports how many countries or
regions and which years it has, or what is wrong with its row: Eurostat
refuses the query, often for a wrong dimension in `filters`; it has no
values, often for a value the dataset does not have; or it has more than
one value for a country and year, when a dimension of the dataset is
left open. Run it after adding or changing a row, and now and then, as
Eurostat renames or retires datasets. The generated rows are checked
when `data-raw/build_indicators.R` writes them, so by default only the
hand-written rows are checked here.

## Usage

``` r
check_indicators(ids = indicators()$id[!indicators()$generated])
```

## Arguments

- ids:

  The `id`s of the indicators to check, by default those written by
  hand.

## Value

A data frame with one row per indicator: `id`, `ok`, `areas` (the
countries or regions with values), `first` and `last` (years), `problem`
and `note` (values left out as errors of units or as known errors of
Eurostat, see
[`get_indicator()`](https://sedzinfo.github.io/golemeurostat/reference/get_indicator.md)).

## Examples

``` r
if (FALSE) { # \dontrun{
check_indicators()
check_indicators(c("unemployment", "r_gdp_pps"))
} # }
```
