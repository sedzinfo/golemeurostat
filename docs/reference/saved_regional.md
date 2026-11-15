# Get an indicator for the regions, as saved in the package

The values of one regional indicator, in the shape of
[`get_regional()`](https://sedzinfo.github.io/golemeurostat/reference/get_regional.md),
without internet: those of Eurostat on the day the package was built,
for the examples of the charts and to work offline.

## Usage

``` r
saved_regional(id)
```

## Arguments

- id:

  The `id` of a regional indicator in
  [`indicators()`](https://sedzinfo.github.io/golemeurostat/reference/indicators.md),
  such as "r_gdp_pps".

## Value

A data frame with `geo` (the NUTS code), `region`, `country`, `year` and
`value`, or `NULL` when the package has no values of the regions.

## Examples

``` r
head(saved_regional("r_gdp_pps"))
#>    geo region country year value
#> 1 AL01   Veri Albania 2008    20
#> 2 AL01   Veri Albania 2009    22
#> 3 AL01   Veri Albania 2010    24
#> 4 AL01   Veri Albania 2011    24
#> 5 AL01   Veri Albania 2012    24
#> 6 AL01   Veri Albania 2013    23
```
