# The values of all the indicators

Every value of every indicator of the countries in
[`indicators()`](https://sedzinfo.github.io/golemeurostat/reference/indicators.md),
for the countries of the app and the EU-27, as of the day
`data-raw/build_values.R` wrote them into the package (the `built`
attribute). The Change (%) tab compares all the indicators of a country
between two years, which needs them all at once; the other tabs download
the indicator they show from Eurostat, and so have the latest values.

## Usage

``` r
all_values()
```

## Value

A data frame with `id` (the indicator), `geo` (the Eurostat code of the
country), `year` and `value`, or `NULL` when the package has no values.

## Examples

``` r
values <- all_values()
attr(values, "built")
#> [1] "2026-11-14"
head(values)
#>        id geo year value
#> 1 gdp_pps  AL 1997  14.7
#> 2 gdp_pps  AL 1998  15.6
#> 3 gdp_pps  AL 1999  17.1
#> 4 gdp_pps  AL 2000  18.1
#> 5 gdp_pps  AL 2001  19.3
#> 6 gdp_pps  AL 2002  20.1
```
