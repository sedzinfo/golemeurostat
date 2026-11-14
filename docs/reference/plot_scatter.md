# Scatter plot of two indicators, animated by year

As in golemworldbank, a bubble per country, as large as its population,
colored by its group (EU, EFTA, candidate), on axes that stay the same
for all the years; here with the code of the country over its bubble,
and the correlation of the two indicators across the countries of each
year.

## Usage

``` r
plot_scatter(x_data, y_data, x_indicator, y_indicator, population = NULL)
```

## Arguments

- x_data, y_data:

  Data frames from
  [`get_indicator()`](https://sedzinfo.github.io/golemeurostat/reference/get_indicator.md).

- x_indicator, y_indicator:

  The `id`s of the two indicators in
  [`indicators()`](https://sedzinfo.github.io/golemeurostat/reference/indicators.md).

- population:

  Data frame of the population of the countries, from
  `get_indicator("population")`, for the size of the bubbles; `NULL`, or
  a country without it, for bubbles of the smallest size.

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
population <- transform(x, value = c(10.4e6, 6.4e6, 83.6e6, 5.6e6))
plot_scatter(x, y, "gdp_pps", "life_expectancy", population)

{"x":{"visdat":{"106b47260137":["function () ","plotlyVisDat"]},"cur_data":"106b47260137","attrs":{"106b47260137":{"x":{},"y":{},"ids":{},"text":{},"mode":"markers+text","textposition":"top center","marker":{"sizemode":"diameter"},"hovertext":{},"hoverinfo":"text","color":{},"size":{},"frame":{},"alpha_stroke":1,"sizes":[10,60],"spans":[1,20],"type":"scatter"}},"layout":{"margin":{"b":100,"l":50,"t":100,"r":50,"pad":0},"title":"","legend":{"traceorder":"reversed"},"xaxis":{"domain":[0,1],"automargin":true,"title":{"text":"GDP per inhabitant in PPS (Index, EU-27 = 100)","standoff":3},"range":[62.159999999999997,133.84]},"yaxis":{"domain":[0,1],"automargin":true,"title":{"text":"Life expectancy at birth (Years)"},"range":[75.450000000000003,83.850000000000009]},"font":{"size":20,"color":"gray25","weight":"bold"},"updatemenus":[{"type":"buttons","direction":"right","x":0,"y":0,"showactive":false,"buttons":[{"label":"Pause","method":"animate","args":[[[]],{"mode":"immediate","frame":{"duration":0,"redraw":true},"transition":{"duration":0}}]},{"label":"Stop","method":"animate","args":[["2024"],{"mode":"immediate","frame":{"duration":0,"redraw":true},"transition":{"duration":0}}]}]}],"hovermode":"closest","showlegend":true,"annotations":[{"text":[],"xref":"paper","yref":"paper","x":0,"y":1,"xanchor":"left","yanchor":"bottom","showarrow":false,"font":{"size":14}}]},"source":"A","config":{"modeBarButtonsToAdd":["hoverclosest","hovercompare"],"showSendToCloud":false,"responsive":true},"data":[{"x":[-1000000000000],"y":[-1000000000000],"ids":["none_Candidate"],"text":"","mode":"markers+text","textposition":"top center","marker":{"color":"rgba(141,160,203,1)","size":[10],"sizemode":"diameter","line":{"color":"rgba(141,160,203,1)"}},"hovertext":", 2024<br>GDP per inhabitant in PPS: -1T Index, EU-27 = 100<br>Life expectancy at birth: -1T Years<br>Population: 5.6M","hoverinfo":"text","frame":"2024","type":"scatter","name":"Candidate","textfont":{"color":"rgba(141,160,203,1)"},"error_y":{"color":"rgba(141,160,203,1)","width":10},"error_x":{"color":"rgba(141,160,203,1)","width":10},"line":{"color":"rgba(141,160,203,1)","width":10},"xaxis":"x","yaxis":"y"},{"x":[130],"y":[83.400000000000006],"ids":["NO"],"text":"NO","mode":"markers+text","textposition":"top center","marker":{"color":"rgba(252,141,98,1)","size":[10],"sizemode":"diameter","line":{"color":"rgba(252,141,98,1)"}},"hovertext":"Norway, 2024<br>GDP per inhabitant in PPS: 130 Index, EU-27 = 100<br>Life expectancy at birth: 83.4 Years<br>Population: 5.6M","hoverinfo":"text","frame":"2024","type":"scatter","name":"EFTA","textfont":{"color":"rgba(252,141,98,1)"},"error_y":{"color":"rgba(252,141,98,1)","width":10},"error_x":{"color":"rgba(252,141,98,1)","width":10},"line":{"color":"rgba(252,141,98,1)","width":10},"xaxis":"x","yaxis":"y"},{"x":[66,116,70],"y":[75.900000000000006,81.200000000000003,81.900000000000006],"ids":["BG","DE","EL"],"text":["BG","DE","EL"],"mode":"markers+text","textposition":["top center","top center","top center"],"marker":{"color":"rgba(102,194,165,1)","size":[10.512820512820513,60,13.076923076923077],"sizemode":"diameter","line":{"color":"rgba(102,194,165,1)"}},"hovertext":["Bulgaria, 2024<br>GDP per inhabitant in PPS: 66 Index, EU-27 = 100<br>Life expectancy at birth: 75.9 Years<br>Population: 6.4M","Germany, 2024<br>GDP per inhabitant in PPS: 116 Index, EU-27 = 100<br>Life expectancy at birth: 81.2 Years<br>Population: 83.6M","Greece, 2024<br>GDP per inhabitant in PPS: 70 Index, EU-27 = 100<br>Life expectancy at birth: 81.9 Years<br>Population: 10.4M"],"hoverinfo":["text","text","text"],"frame":"2024","type":"scatter","name":"EU","textfont":{"color":"rgba(102,194,165,1)"},"error_y":{"color":"rgba(102,194,165,1)","width":[]},"error_x":{"color":"rgba(102,194,165,1)","width":[]},"line":{"color":"rgba(102,194,165,1)"},"xaxis":"x","yaxis":"y"}],"highlight":{"on":"plotly_click","persistent":false,"dynamic":false,"selectize":false,"opacityDim":0.20000000000000001,"selected":{"opacity":1},"debounce":0},"shinyEvents":["plotly_hover","plotly_click","plotly_selected","plotly_relayout","plotly_brushed","plotly_brushing","plotly_clickannotation","plotly_doubleclick","plotly_deselect","plotly_afterplot","plotly_sunburstclick"],"base_url":"https://plot.ly"},"evals":[],"jsHooks":{"render":[{"code":"function(el, x, labels) {\n    el.on('plotly_animatingframe', function(e) {\n      var text = el.querySelector('.annotation-text');\n      if (text && labels[e.name] !== undefined) text.textContent = labels[e.name];\n    });\n  }","data":{"2024":"Correlation r = 0.68, 4 countries"}}]}}
```
