# Population pyramid, animated by year

As in golemworldbank: the share of each five-year age group in the male
population, to the left, and in the female population, to the right,
animated over the years. The male values are drawn negative, so that the
two sexes stand back to back, but the labels on the bars and the axis
show them positive. The axis stays the same for all the years. The years
whose figures jump back and forth from one year to the next, as
Eurostat's for Greece from 1961 to 1969 do, are left out, and named at
the top of the chart.

## Usage

``` r
plot_pyramid(data, country)
```

## Arguments

- data:

  Data frame from
  [`get_pyramid()`](https://sedzinfo.github.io/golemeurostat/reference/get_pyramid.md).

- country:

  Eurostat code of the country, for the title ("Country: " and its name,
  as in golemworldbank).

## Value

A plotly object.

## Examples

``` r
plot_pyramid(saved_pyramid("EL"), "EL")
```
