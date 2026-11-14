# Scatter plot of two indicators, animated by year

One point per country, colored by its group (EU, EFTA, candidate), on
axes that stay the same for all the years, with the correlation of the
two indicators across the countries of each year.

## Usage

``` r
plot_scatter(x_data, y_data, x_indicator, y_indicator)
```

## Arguments

- x_data, y_data:

  Data frames from
  [`get_indicator()`](https://sedzinfo.github.io/golemeurostat/reference/get_indicator.md).

- x_indicator, y_indicator:

  The `id`s of the two indicators in
  [`indicators()`](https://sedzinfo.github.io/golemeurostat/reference/indicators.md).

## Value

A plotly object, or `NULL` when the two indicators have no year in
common.

## Examples

``` r
x <- data.frame(
  geo = c("EL", "BG", "DE", "NO"), country = c("Greece", "Bulgaria", "Germany", "Norway"),
  group = c("EU", "EU", "EU", "EFTA"), year = 2024, value = c(70, 66, 116, 130)
)
y <- transform(x, value = c(81.9, 75.9, 81.2, 83.4))
plot_scatter(x, y, "gdp_pps", "life_expectancy")
#> Error in p$x$layout$sliders[[which(isAniSlider)]] <- modify_list(p$x$layout$sliders[[which(isAniSlider)]],     list(...)): attempt to select less than one element in OneIndex
```
