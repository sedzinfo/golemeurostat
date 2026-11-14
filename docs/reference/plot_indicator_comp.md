# Line chart of several indicators for one country

As in golemworldbank: one line per indicator, in the colors of the
Country Comparison, named with its unit in the legend, at the top of the
plot. The axis takes the unit when all the indicators share it. An
indicator without values for the country is left out.

## Usage

``` r
plot_indicator_comp(data, country, indicators)
```

## Arguments

- data:

  Data frames from
  [`get_indicator()`](https://sedzinfo.github.io/golemeurostat/reference/get_indicator.md),
  one per indicator, named by its `id`.

- country:

  Eurostat code of the country, such as "EL", or "EU27_2020".

- indicators:

  The `id`s of the indicators in
  [`indicators()`](https://sedzinfo.github.io/golemeurostat/reference/indicators.md).

## Value

A plotly object, or `NULL` when none of the indicators has values for
the country.

## Examples

``` r
unemployment <- data.frame(
  geo = "EL", country = "Greece", group = "EU", year = 2022:2024, value = c(12.4, 11.1, 10.1)
)
youth <- transform(unemployment, value = c(31.4, 26.7, 22.4))
plot_indicator_comp(
  list(unemployment = unemployment, youth_unemployment = youth), "EL",
  c("unemployment", "youth_unemployment")
)

{"x":{"visdat":{"d1441e2e2b72":["function () ","plotlyVisDat"]},"cur_data":"d1441e2e2b72","attrs":{"d1441e2e2b72":{"x":{},"y":{},"mode":"lines+markers","text":{},"hoverinfo":"text","color":{},"alpha_stroke":1,"sizes":[10,100],"spans":[1,20],"type":"scatter"}},"layout":{"margin":{"b":0,"l":50,"t":100,"r":50,"pad":0},"title":"Country: Greece","legend":{"orientation":"h","xanchor":"center","x":0.5,"y":1,"font":{"size":14}},"xaxis":{"domain":[0,1],"automargin":true,"title":"","tickangle":-90},"yaxis":{"domain":[0,1],"automargin":true,"title":""},"showlegend":true,"font":{"size":20,"color":"gray25","weight":"bold"},"hovermode":"closest"},"source":"A","config":{"modeBarButtonsToAdd":["hoverclosest","hovercompare"],"showSendToCloud":false,"responsive":true},"data":[{"x":[2022,2023,2024],"y":[12.4,11.1,10.1],"mode":"lines+markers","text":["Unemployment rate<br>2022: 12.4 % of the labour force","Unemployment rate<br>2023: 11.1 % of the labour force","Unemployment rate<br>2024: 10.1 % of the labour force"],"hoverinfo":["text","text","text"],"type":"scatter","name":"Unemployment rate (% of the labour force)","marker":{"color":"rgba(102,194,165,1)","line":{"color":"rgba(102,194,165,1)"}},"textfont":{"color":"rgba(102,194,165,1)"},"error_y":{"color":"rgba(102,194,165,1)"},"error_x":{"color":"rgba(102,194,165,1)"},"line":{"color":"rgba(102,194,165,1)"},"xaxis":"x","yaxis":"y","frame":null},{"x":[2022,2023,2024],"y":[31.399999999999999,26.699999999999999,22.399999999999999],"mode":"lines+markers","text":["Youth unemployment rate<br>2022: 31.4 % of the labour force aged 15 to 24","Youth unemployment rate<br>2023: 26.7 % of the labour force aged 15 to 24","Youth unemployment rate<br>2024: 22.4 % of the labour force aged 15 to 24"],"hoverinfo":["text","text","text"],"type":"scatter","name":"Youth unemployment rate (% of the labour force aged 15 to 24)","marker":{"color":"rgba(141,160,203,1)","line":{"color":"rgba(141,160,203,1)"}},"textfont":{"color":"rgba(141,160,203,1)"},"error_y":{"color":"rgba(141,160,203,1)"},"error_x":{"color":"rgba(141,160,203,1)"},"line":{"color":"rgba(141,160,203,1)"},"xaxis":"x","yaxis":"y","frame":null}],"highlight":{"on":"plotly_click","persistent":false,"dynamic":false,"selectize":false,"opacityDim":0.20000000000000001,"selected":{"opacity":1},"debounce":0},"shinyEvents":["plotly_hover","plotly_click","plotly_selected","plotly_relayout","plotly_brushed","plotly_brushing","plotly_clickannotation","plotly_doubleclick","plotly_deselect","plotly_afterplot","plotly_sunburstclick"],"base_url":"https://plot.ly"},"evals":[],"jsHooks":[]}
```
