# Map of the regions, animated by year

The regions of the NUTS 2024 classification at level 2 colored by the
value of the indicator, from light for low to dark blue for high, on one
scale for all the years.

## Usage

``` r
plot_regions(data, indicator)
```

## Arguments

- data:

  Data frame from
  [`get_regional()`](https://sedzinfo.github.io/golemeurostat/reference/get_regional.md).

- indicator:

  The `id` of a regional indicator in
  [`indicators()`](https://sedzinfo.github.io/golemeurostat/reference/indicators.md).

## Value

A plotly object.

## Examples

``` r
data <- data.frame(
  geo = c("EL30", "EL52"), region = c("Attiki", "Kentriki Makedonia"),
  country = "Greece", year = 2024, value = c(105, 58)
)
plot_regions(data, "r_gdp_pps")
#> Error in p$x$layout$sliders[[which(isAniSlider)]] <- modify_list(p$x$layout$sliders[[which(isAniSlider)]],     list(...)): attempt to select less than one element in OneIndex
```
