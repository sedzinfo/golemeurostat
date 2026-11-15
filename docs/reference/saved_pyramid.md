# Get the population of a country by age group and sex, as saved in the package

The population pyramid of
[`get_pyramid()`](https://sedzinfo.github.io/golemeurostat/reference/get_pyramid.md)
without internet: Eurostat's population on 1 January by five-year age
group and sex (`demo_pjangroup`) on the day the package was built, for
the examples of the charts and to work offline.

## Usage

``` r
saved_pyramid(country)
```

## Arguments

- country:

  Eurostat code of the country, such as "EL", or "EU27_2020".

## Value

A data frame with `sex`, `age`, `year` and `value`, the share of the age
group in the population of its sex, in percent, or `NULL` when the
package has no population pyramids.

## Examples

``` r
head(saved_pyramid("EL"))
#>      sex   age year    value
#> 1 Female   0-4 1961 8.437061
#> 2 Female   5-9 1961 8.563425
#> 3 Female 10-14 1961 8.626130
#> 4 Female 15-19 1961 7.775774
#> 5 Female 20-24 1961 9.485151
#> 6 Female 25-29 1961 9.410101
```
