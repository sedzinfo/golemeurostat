# Get an indicator for the countries, as saved in the package

The values of one indicator of
[`all_values()`](https://sedzinfo.github.io/golemeurostat/reference/all_values.md),
in the shape of
[`get_indicator()`](https://sedzinfo.github.io/golemeurostat/reference/get_indicator.md),
without internet: those of Eurostat on the day the package was built
(the `built` attribute of
[`all_values()`](https://sedzinfo.github.io/golemeurostat/reference/all_values.md)),
for the examples of the charts and to work offline.

## Usage

``` r
saved_indicator(id)
```

## Arguments

- id:

  The `id` of the indicator in
  [`indicators()`](https://sedzinfo.github.io/golemeurostat/reference/indicators.md),
  such as "unemployment".

## Value

A data frame with `geo` (the Eurostat code), `country`, `group`, `year`
and `value`, or `NULL` when the package has no values.

## Examples

``` r
head(saved_indicator("unemployment"))
#>   geo country group year value
#> 1  AT Austria    EU 2009   5.7
#> 2  AT Austria    EU 2010   5.2
#> 3  AT Austria    EU 2011   4.9
#> 4  AT Austria    EU 2012   5.2
#> 5  AT Austria    EU 2013   5.7
#> 6  AT Austria    EU 2014   6.0
```
