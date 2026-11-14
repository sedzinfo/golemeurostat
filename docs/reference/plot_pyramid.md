# Population pyramid, animated by year

As in golemworldbank: the share of each five-year age group in the male
population, to the left, and in the female population, to the right,
animated over the years. The male values are drawn negative, so that the
two sexes stand back to back, but the labels on the bars and the axis
show them positive. The axis stays the same for all the years.

## Usage

``` r
plot_pyramid(data, country)
```

## Arguments

- data:

  Data frame from
  [`get_pyramid()`](https://sedzinfo.github.io/golemeurostat/reference/get_pyramid.md).

- country:

  Eurostat code of the country, for the title.

## Value

A plotly object.

## Examples

``` r
data <- data.frame(
  sex = rep(c("Male", "Female"), each = 4),
  age = factor(rep(c("0-4", "5-9"), 4), levels = c("0-4", "5-9")),
  year = rep(c(2024, 2024, 2025, 2025), 2),
  value = c(48, 52, 47, 53, 49, 51, 48, 52)
)
plot_pyramid(data, "EL")
```
