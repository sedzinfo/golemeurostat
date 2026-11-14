# Line chart of an indicator for several countries

One line per country, and the EU-27 average as a dashed gray line, for
comparison.

## Usage

``` r
plot_country_comp(data, countries, indicator)
```

## Arguments

- data:

  Data frame from
  [`get_indicator()`](https://sedzinfo.github.io/golemeurostat/reference/get_indicator.md).

- countries:

  Eurostat codes of the countries, such as `c("EL", "BG")`.

- indicator:

  The `id` of the indicator in
  [`indicators()`](https://sedzinfo.github.io/golemeurostat/reference/indicators.md),
  for the title and the unit.

## Value

A plotly object.

## Examples

``` r
data <- data.frame(
  geo = rep(c("EL", "BG", "EU27_2020"), each = 3),
  country = rep(c("Greece", "Bulgaria", "EU-27"), each = 3),
  group = rep(c("EU", "EU", "EU-27"), each = 3),
  year = rep(2022:2024, 3),
  value = c(12.4, 11.1, 10.1, 4.3, 4.3, 4.2, 6.2, 6.1, 5.9)
)
plot_country_comp(data, c("EL", "BG"), "unemployment")

{"x":{"visdat":{"103a819262a32":["function () ","plotlyVisDat"]},"cur_data":"103a819262a32","attrs":{"103a819262a32":{"alpha_stroke":1,"sizes":[10,100],"spans":[1,20],"x":[2022,2023,2024,2022,2023,2024],"y":[12.4,11.1,10.1,4.2999999999999998,4.2999999999999998,4.2000000000000002],"color":["Greece","Greece","Greece","Bulgaria","Bulgaria","Bulgaria"],"type":"scatter","mode":"lines+markers","text":["Greece<br>2022: 12.4 % of the labour force","Greece<br>2023: 11.1 % of the labour force","Greece<br>2024: 10.1 % of the labour force","Bulgaria<br>2022: 4.3 % of the labour force","Bulgaria<br>2023: 4.3 % of the labour force","Bulgaria<br>2024: 4.2 % of the labour force"],"hoverinfo":"text","inherit":true},"103a819262a32.1":{"alpha_stroke":1,"sizes":[10,100],"spans":[1,20],"x":[2022,2023,2024],"y":[6.2000000000000002,6.0999999999999996,5.9000000000000004],"name":"EU-27","type":"scatter","mode":"lines","line":{"color":"gray","dash":"dash","width":2},"text":["EU-27<br>2022: 6.2 % of the labour force","EU-27<br>2023: 6.1 % of the labour force","EU-27<br>2024: 5.9 % of the labour force"],"hoverinfo":"text","inherit":true}},"layout":{"margin":{"b":0,"l":50,"t":100,"r":50,"pad":0},"title":{"text":"Unemployment rate","yref":"paper","y":1,"yanchor":"bottom","pad":{"b":50}},"legend":{"orientation":"h","xanchor":"center","x":0.5,"y":1},"xaxis":{"domain":[0,1],"automargin":true,"title":"","tickangle":-90},"yaxis":{"domain":[0,1],"automargin":true,"title":"% of the labour force"},"font":{"size":20,"color":"gray25","weight":"bold"},"hovermode":"closest","showlegend":true},"source":"A","config":{"modeBarButtonsToAdd":["hoverclosest","hovercompare"],"showSendToCloud":false,"responsive":true},"data":[{"x":[2022,2023,2024],"y":[4.2999999999999998,4.2999999999999998,4.2000000000000002],"type":"scatter","mode":"lines+markers","text":["Bulgaria<br>2022: 4.3 % of the labour force","Bulgaria<br>2023: 4.3 % of the labour force","Bulgaria<br>2024: 4.2 % of the labour force"],"hoverinfo":["text","text","text"],"name":"Bulgaria","marker":{"color":"rgba(102,194,165,1)","line":{"color":"rgba(102,194,165,1)"}},"textfont":{"color":"rgba(102,194,165,1)"},"error_y":{"color":"rgba(102,194,165,1)"},"error_x":{"color":"rgba(102,194,165,1)"},"line":{"color":"rgba(102,194,165,1)"},"xaxis":"x","yaxis":"y","frame":null},{"x":[2022,2023,2024],"y":[12.4,11.1,10.1],"type":"scatter","mode":"lines+markers","text":["Greece<br>2022: 12.4 % of the labour force","Greece<br>2023: 11.1 % of the labour force","Greece<br>2024: 10.1 % of the labour force"],"hoverinfo":["text","text","text"],"name":"Greece","marker":{"color":"rgba(141,160,203,1)","line":{"color":"rgba(141,160,203,1)"}},"textfont":{"color":"rgba(141,160,203,1)"},"error_y":{"color":"rgba(141,160,203,1)"},"error_x":{"color":"rgba(141,160,203,1)"},"line":{"color":"rgba(141,160,203,1)"},"xaxis":"x","yaxis":"y","frame":null},{"x":[2022,2023,2024],"y":[6.2000000000000002,6.0999999999999996,5.9000000000000004],"name":"EU-27","type":"scatter","mode":"lines","line":{"color":"gray","dash":"dash","width":2},"text":["EU-27<br>2022: 6.2 % of the labour force","EU-27<br>2023: 6.1 % of the labour force","EU-27<br>2024: 5.9 % of the labour force"],"hoverinfo":["text","text","text"],"marker":{"color":"rgba(44,160,44,1)","line":{"color":"rgba(44,160,44,1)"}},"error_y":{"color":"rgba(44,160,44,1)"},"error_x":{"color":"rgba(44,160,44,1)"},"xaxis":"x","yaxis":"y","frame":null}],"highlight":{"on":"plotly_click","persistent":false,"dynamic":false,"selectize":false,"opacityDim":0.20000000000000001,"selected":{"opacity":1},"debounce":0},"shinyEvents":["plotly_hover","plotly_click","plotly_selected","plotly_relayout","plotly_brushed","plotly_brushing","plotly_clickannotation","plotly_doubleclick","plotly_deselect","plotly_afterplot","plotly_sunburstclick"],"base_url":"https://plot.ly"},"evals":[],"jsHooks":[]}
```
