# Ranked bars of an indicator, animated by year

One bar per country, the largest at the top, re-ranked each year as the
animation plays, and the picked country in red. A country's gaps between
its first and last year are filled in a straight line, so that it does
not drop out of the race for a year. As in golemworldbank, only the
`top_n` largest are shown each year, and the year is printed large and
gray in the bottom right corner.

## Usage

``` r
plot_bar(data, indicator, country = NULL, top_n = Inf)
```

## Arguments

- data:

  Data frame from
  [`get_indicator()`](https://sedzinfo.github.io/golemeurostat/reference/get_indicator.md).

- indicator:

  The `id` of the indicator in
  [`indicators()`](https://sedzinfo.github.io/golemeurostat/reference/indicators.md),
  for the title and the unit.

- country:

  Eurostat code of the country to draw in red.

- top_n:

  How many countries to show each year, the largest; all of them by
  default.

## Value

A plotly object.

## Examples

``` r
data <- data.frame(
  geo = rep(c("EL", "BG", "DE"), each = 3),
  country = rep(c("Greece", "Bulgaria", "Germany"), each = 3),
  group = "EU",
  year = rep(2022:2024, 3),
  value = c(12.4, 11.1, 10.1, 4.3, 4.3, 4.2, 3.1, 3.0, 3.4)
)
plot_bar(data, "unemployment", "EL")

{"x":{"visdat":{"106b45e491e76":["function () ","plotlyVisDat"]},"cur_data":"106b45e491e76","attrs":{"106b45e491e76":{"x":{},"y":{},"ids":{},"orientation":"h","marker":{"color":{}},"text":{},"textposition":"auto","cliponaxis":false,"hovertext":{},"hoverinfo":"text","frame":{},"alpha_stroke":1,"sizes":[10,100],"spans":[1,20],"type":"bar"}},"layout":{"margin":{"b":100,"l":50,"t":100,"r":50,"pad":0},"title":{"text":"Unemployment rate","yref":"paper","y":1,"yanchor":"bottom","pad":{"b":50}},"yaxis":{"domain":[0,1],"automargin":true,"title":"","autorange":"reversed","dtick":1,"zeroline":false,"range":[0.90000000000000002,3.1000000000000001]},"xaxis":{"domain":[0,1],"automargin":true,"title":"% of the labour force","showticklabels":false,"zeroline":true,"showgrid":false,"range":[2.5299999999999998,12.870000000000001]},"font":{"size":20,"color":"gray25","weight":"bold"},"showlegend":false,"updatemenus":[{"type":"buttons","direction":"right","x":0,"y":0,"showactive":false,"buttons":[{"label":"Pause","method":"animate","args":[[[]],{"mode":"immediate","frame":{"duration":0,"redraw":true},"transition":{"duration":0}}]},{"label":"Stop","method":"animate","args":[["2022"],{"mode":"immediate","frame":{"duration":0,"redraw":true},"transition":{"duration":0}}]}]},{"type":"buttons","direction":"right","showactive":false,"y":0,"x":0,"yanchor":"top","xanchor":"right","pad":{"t":60,"r":5},"buttons":[{"label":"Play","method":"animate","args":[null,{"fromcurrent":true,"mode":"afterall","transition":{"duration":0,"easing":"linear"},"frame":{"duration":1000,"redraw":true}}]}]}],"hovermode":"closest","sliders":[{"currentvalue":{"prefix":"Year: ","xanchor":"right","font":{"size":16,"color":"rgba(204,204,204,1)"}},"steps":[{"method":"animate","args":[["2022"],{"transition":{"duration":0,"easing":"linear"},"frame":{"duration":1000,"redraw":true},"mode":"afterall"}],"label":"2022","value":"2022"},{"method":"animate","args":[["2023"],{"transition":{"duration":0,"easing":"linear"},"frame":{"duration":1000,"redraw":true},"mode":"afterall"}],"label":"2023","value":"2023"},{"method":"animate","args":[["2024"],{"transition":{"duration":0,"easing":"linear"},"frame":{"duration":1000,"redraw":true},"mode":"afterall"}],"label":"2024","value":"2024"}],"visible":true,"pad":{"t":40},"active":2}],"annotations":[{"text":"2024","xref":"paper","yref":"paper","x":1,"y":0,"xanchor":"right","yanchor":"bottom","showarrow":false,"font":{"size":480,"color":"rgba(128,128,128,0.35)"}}]},"source":"A","config":{"modeBarButtonsToAdd":["hoverclosest","hovercompare"],"showSendToCloud":false,"responsive":true},"data":[{"x":[10.1,4.2000000000000002,3.3999999999999999],"y":[1,2,3],"ids":["EL","BG","DE"],"orientation":"h","marker":{"color":["#d62728","#1f77b4","#1f77b4"],"line":{"color":"rgba(31,119,180,1)"}},"text":["Greece  10.1","Bulgaria  4.2","Germany  3.4"],"textposition":["auto","auto","auto"],"cliponaxis":false,"hovertext":["Rank 1<br>Greece: 10.1 % of the labour force","Rank 2<br>Bulgaria: 4.2 % of the labour force","Rank 3<br>Germany: 3.4 % of the labour force"],"hoverinfo":["text","text","text"],"frame":"2024","type":"bar","error_y":{"color":"rgba(31,119,180,1)"},"error_x":{"color":"rgba(31,119,180,1)"},"xaxis":"x","yaxis":"y","visible":true}],"highlight":{"on":"plotly_click","persistent":false,"dynamic":false,"selectize":false,"opacityDim":0.20000000000000001,"selected":{"opacity":1},"debounce":0},"frames":[{"name":"2022","data":[{"x":[12.4,4.2999999999999998,3.1000000000000001],"y":[1,2,3],"ids":["EL","BG","DE"],"orientation":"h","marker":{"color":["#d62728","#1f77b4","#1f77b4"],"line":{"color":"rgba(31,119,180,1)"}},"text":["Greece  12.4","Bulgaria  4.3","Germany  3.1"],"textposition":["auto","auto","auto"],"cliponaxis":false,"hovertext":["Rank 1<br>Greece: 12.4 % of the labour force","Rank 2<br>Bulgaria: 4.3 % of the labour force","Rank 3<br>Germany: 3.1 % of the labour force"],"hoverinfo":["text","text","text"],"frame":"2022","type":"bar","error_y":{"color":"rgba(31,119,180,1)"},"error_x":{"color":"rgba(31,119,180,1)"},"xaxis":"x","yaxis":"y","visible":true}],"traces":[0],"layout":{"annotations":[{"text":"2022","xref":"paper","yref":"paper","x":1,"y":0,"xanchor":"right","yanchor":"bottom","showarrow":false,"font":{"size":480,"color":"rgba(128,128,128,0.35)"}}]}},{"name":"2023","data":[{"x":[11.1,4.2999999999999998,3],"y":[1,2,3],"ids":["EL","BG","DE"],"orientation":"h","marker":{"color":["#d62728","#1f77b4","#1f77b4"],"line":{"color":"rgba(31,119,180,1)"}},"text":["Greece  11.1","Bulgaria  4.3","Germany  3"],"textposition":["auto","auto","auto"],"cliponaxis":false,"hovertext":["Rank 1<br>Greece: 11.1 % of the labour force","Rank 2<br>Bulgaria: 4.3 % of the labour force","Rank 3<br>Germany: 3 % of the labour force"],"hoverinfo":["text","text","text"],"frame":"2023","type":"bar","error_y":{"color":"rgba(31,119,180,1)"},"error_x":{"color":"rgba(31,119,180,1)"},"xaxis":"x","yaxis":"y","visible":true}],"traces":[0],"layout":{"annotations":[{"text":"2023","xref":"paper","yref":"paper","x":1,"y":0,"xanchor":"right","yanchor":"bottom","showarrow":false,"font":{"size":480,"color":"rgba(128,128,128,0.35)"}}]}},{"name":"2024","data":[{"x":[10.1,4.2000000000000002,3.3999999999999999],"y":[1,2,3],"ids":["EL","BG","DE"],"orientation":"h","marker":{"color":["#d62728","#1f77b4","#1f77b4"],"line":{"color":"rgba(31,119,180,1)"}},"text":["Greece  10.1","Bulgaria  4.2","Germany  3.4"],"textposition":["auto","auto","auto"],"cliponaxis":false,"hovertext":["Rank 1<br>Greece: 10.1 % of the labour force","Rank 2<br>Bulgaria: 4.2 % of the labour force","Rank 3<br>Germany: 3.4 % of the labour force"],"hoverinfo":["text","text","text"],"frame":"2024","type":"bar","error_y":{"color":"rgba(31,119,180,1)"},"error_x":{"color":"rgba(31,119,180,1)"},"xaxis":"x","yaxis":"y","visible":true}],"traces":[0],"layout":{"annotations":[{"text":"2024","xref":"paper","yref":"paper","x":1,"y":0,"xanchor":"right","yanchor":"bottom","showarrow":false,"font":{"size":480,"color":"rgba(128,128,128,0.35)"}}]}}],"shinyEvents":["plotly_hover","plotly_click","plotly_selected","plotly_relayout","plotly_brushed","plotly_brushing","plotly_clickannotation","plotly_doubleclick","plotly_deselect","plotly_afterplot","plotly_sunburstclick"],"base_url":"https://plot.ly"},"evals":[],"jsHooks":{"render":[{"code":"function(el, x, labels) {\n    el.on('plotly_animatingframe', function(e) {\n      var text = el.querySelector('.annotation-text');\n      if (text && labels[e.name] !== undefined) text.textContent = labels[e.name];\n    });\n  }","data":{"2022":"2022","2023":"2023","2024":"2024"}},{"code":"function(el) {\n    function fit() {\n      var size = el._fullLayout && el._fullLayout._size, year = el.layout.annotations && el.layout.annotations[0];\n      if (!size || !year) return;\n      var font = Math.round(Math.min(480, 0.8 * size.h, size.w / 3));\n      if (Math.abs(year.font.size - font) < 2) return;\n      // the frames carry the year too, and would put back its size\n      (el._transitionData._frames || []).forEach(function(f) {\n        if (f.layout && f.layout.annotations) f.layout.annotations[0].font.size = font;\n      });\n      Plotly.relayout(el, {'annotations[0].font.size': font});\n    }\n    el.on('plotly_afterplot', fit);\n    fit();\n  }","data":null}]}}
```
