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
data <- list(
  unemployment = saved_indicator("unemployment"),
  youth_unemployment = saved_indicator("youth_unemployment")
)
plot_indicator_comp(data, "EL", names(data))

{"x":{"visdat":{"104ec56c1ef1":["function () ","plotlyVisDat"]},"cur_data":"104ec56c1ef1","attrs":{"104ec56c1ef1":{"x":{},"y":{},"mode":"lines+markers","text":{},"hoverinfo":"text","color":{},"alpha_stroke":1,"sizes":[10,100],"spans":[1,20],"type":"scatter"}},"layout":{"margin":{"b":0,"l":50,"t":100,"r":50,"pad":0},"title":"Country: Greece","legend":{"orientation":"h","xanchor":"center","x":0.5,"y":1,"font":{"size":14}},"xaxis":{"domain":[0,1],"automargin":true,"title":"","tickangle":-90},"yaxis":{"domain":[0,1],"automargin":true,"title":""},"showlegend":true,"font":{"size":20,"color":"gray25","weight":"bold"},"hovermode":"closest"},"source":"A","config":{"modeBarButtonsToAdd":["hoverclosest","hovercompare"],"showSendToCloud":false,"responsive":true},"data":[{"x":[2009,2010,2011,2012,2013,2014,2015,2016,2017,2018,2019,2020,2021,2022,2023,2024,2025],"y":[9.8000000000000007,12.9,18.100000000000001,24.800000000000001,27.800000000000001,26.600000000000001,25,23.899999999999999,21.800000000000001,19.699999999999999,17.899999999999999,17.600000000000001,14.699999999999999,12.5,11.1,10.1,8.9000000000000004],"mode":"lines+markers","text":["Unemployment rate<br>2009: 9.8 % of the labour force","Unemployment rate<br>2010: 12.9 % of the labour force","Unemployment rate<br>2011: 18.1 % of the labour force","Unemployment rate<br>2012: 24.8 % of the labour force","Unemployment rate<br>2013: 27.8 % of the labour force","Unemployment rate<br>2014: 26.6 % of the labour force","Unemployment rate<br>2015: 25 % of the labour force","Unemployment rate<br>2016: 23.9 % of the labour force","Unemployment rate<br>2017: 21.8 % of the labour force","Unemployment rate<br>2018: 19.7 % of the labour force","Unemployment rate<br>2019: 17.9 % of the labour force","Unemployment rate<br>2020: 17.6 % of the labour force","Unemployment rate<br>2021: 14.7 % of the labour force","Unemployment rate<br>2022: 12.5 % of the labour force","Unemployment rate<br>2023: 11.1 % of the labour force","Unemployment rate<br>2024: 10.1 % of the labour force","Unemployment rate<br>2025: 8.9 % of the labour force"],"hoverinfo":["text","text","text","text","text","text","text","text","text","text","text","text","text","text","text","text","text"],"type":"scatter","name":"Unemployment rate (% of the labour force)","marker":{"color":"rgba(102,194,165,1)","line":{"color":"rgba(102,194,165,1)"}},"textfont":{"color":"rgba(102,194,165,1)"},"error_y":{"color":"rgba(102,194,165,1)"},"error_x":{"color":"rgba(102,194,165,1)"},"line":{"color":"rgba(102,194,165,1)"},"xaxis":"x","yaxis":"y","frame":null},{"x":[2009,2010,2011,2012,2013,2014,2015,2016,2017,2018,2019,2020,2021,2022,2023,2024,2025],"y":[26.100000000000001,33.600000000000001,45.200000000000003,55.899999999999999,59.200000000000003,53,50.299999999999997,48.200000000000003,44.5,41.200000000000003,37.5,38,35.5,31.399999999999999,26.699999999999999,22.5,19.100000000000001],"mode":"lines+markers","text":["Youth unemployment rate<br>2009: 26.1 % of the labour force aged 15 to 24","Youth unemployment rate<br>2010: 33.6 % of the labour force aged 15 to 24","Youth unemployment rate<br>2011: 45.2 % of the labour force aged 15 to 24","Youth unemployment rate<br>2012: 55.9 % of the labour force aged 15 to 24","Youth unemployment rate<br>2013: 59.2 % of the labour force aged 15 to 24","Youth unemployment rate<br>2014: 53 % of the labour force aged 15 to 24","Youth unemployment rate<br>2015: 50.3 % of the labour force aged 15 to 24","Youth unemployment rate<br>2016: 48.2 % of the labour force aged 15 to 24","Youth unemployment rate<br>2017: 44.5 % of the labour force aged 15 to 24","Youth unemployment rate<br>2018: 41.2 % of the labour force aged 15 to 24","Youth unemployment rate<br>2019: 37.5 % of the labour force aged 15 to 24","Youth unemployment rate<br>2020: 38 % of the labour force aged 15 to 24","Youth unemployment rate<br>2021: 35.5 % of the labour force aged 15 to 24","Youth unemployment rate<br>2022: 31.4 % of the labour force aged 15 to 24","Youth unemployment rate<br>2023: 26.7 % of the labour force aged 15 to 24","Youth unemployment rate<br>2024: 22.5 % of the labour force aged 15 to 24","Youth unemployment rate<br>2025: 19.1 % of the labour force aged 15 to 24"],"hoverinfo":["text","text","text","text","text","text","text","text","text","text","text","text","text","text","text","text","text"],"type":"scatter","name":"Youth unemployment rate (% of the labour force aged 15 to 24)","marker":{"color":"rgba(141,160,203,1)","line":{"color":"rgba(141,160,203,1)"}},"textfont":{"color":"rgba(141,160,203,1)"},"error_y":{"color":"rgba(141,160,203,1)"},"error_x":{"color":"rgba(141,160,203,1)"},"line":{"color":"rgba(141,160,203,1)"},"xaxis":"x","yaxis":"y","frame":null}],"highlight":{"on":"plotly_click","persistent":false,"dynamic":false,"selectize":false,"opacityDim":0.20000000000000001,"selected":{"opacity":1},"debounce":0},"shinyEvents":["plotly_hover","plotly_click","plotly_selected","plotly_relayout","plotly_brushed","plotly_brushing","plotly_clickannotation","plotly_doubleclick","plotly_deselect","plotly_afterplot","plotly_sunburstclick"],"base_url":"https://plot.ly"},"evals":[],"jsHooks":[]}
```
