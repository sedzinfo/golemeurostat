# Get the population of a country by age group and sex

Downloads the population on 1 January by five-year age group and sex of
one country from Eurostat (`demo_pjangroup`), or takes it from the disk
cache when it was downloaded less than a day ago.

## Usage

``` r
get_pyramid(country)
```

## Arguments

- country:

  Eurostat code of the country, such as "EL", or "EU27_2020".

## Value

A data frame with `sex`, `age`, `year` and `value`, the share of the age
group in the population of its sex, in percent, or `NULL` with a message
when Eurostat cannot be reached.

## Examples

``` r
if (FALSE) { # \dontrun{
get_pyramid("EL")
} # }
```
