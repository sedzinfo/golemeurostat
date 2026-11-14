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

{"x":{"visdat":{"103a81c595622":["function () ","plotlyVisDat"]},"cur_data":"103a81c595622","attrs":{"103a81c595622":{"geojson":"https://gisco-services.ec.europa.eu/distribution/v2/nuts/geojson/NUTS_RG_20M_2024_4326_LEVL_2.geojson","featureidkey":"properties.NUTS_ID","locations":{},"z":{},"zmin":58,"zmax":105,"marker":{"line":{"width":0.29999999999999999,"color":"white"}},"colorbar":{"title":""},"text":{},"hoverinfo":"text","frame":{},"colors":"Blues","alpha_stroke":1,"sizes":[10,100],"spans":[1,20],"type":"choropleth"}},"layout":{"margin":{"b":100,"l":50,"t":100,"r":50,"pad":0},"title":{"text":"GDP per inhabitant in PPS","yref":"paper","y":1,"yanchor":"bottom","pad":{"b":50}},"font":{"size":20,"color":"gray25","weight":"bold"},"geo":{"visible":false,"projection":{"type":"mercator"},"lonaxis":{"range":[-25,45]},"lataxis":{"range":[34,72]},"bgcolor":"rgba(0,0,0,0)"},"annotations":[{"text":"Boundaries: © EuroGeographics","xref":"paper","yref":"paper","x":1,"y":0,"xanchor":"right","yanchor":"bottom","showarrow":false,"font":{"size":11,"color":"gray"}}],"updatemenus":[{"type":"buttons","direction":"right","x":0,"y":0,"showactive":false,"buttons":[{"label":"Pause","method":"animate","args":[[[]],{"mode":"immediate","frame":{"duration":0,"redraw":true},"transition":{"duration":0}}]},{"label":"Stop","method":"animate","args":[["2024"],{"mode":"immediate","frame":{"duration":0,"redraw":true},"transition":{"duration":0}}]}]}],"scene":{"zaxis":{"title":"value"}},"hovermode":"closest","showlegend":false,"legend":{"yanchor":"top","y":0.5}},"source":"A","config":{"modeBarButtonsToAdd":["hoverclosest","hovercompare"],"showSendToCloud":false,"responsive":true},"data":[{"colorbar":{"title":"","ticklen":2,"len":0.5,"lenmode":"fraction","y":1,"yanchor":"top"},"colorscale":[["0","rgba(247,251,255,1)"],["0.0416666666666667","rgba(239,246,252,1)"],["0.0833333333333333","rgba(230,240,250,1)"],["0.125","rgba(222,235,247,1)"],["0.166666666666667","rgba(214,230,244,1)"],["0.208333333333333","rgba(206,224,242,1)"],["0.25","rgba(198,219,239,1)"],["0.291666666666667","rgba(185,213,234,1)"],["0.333333333333333","rgba(172,208,230,1)"],["0.375","rgba(158,202,225,1)"],["0.416666666666667","rgba(142,193,221,1)"],["0.458333333333333","rgba(125,183,218,1)"],["0.5","rgba(107,174,214,1)"],["0.541666666666667","rgba(94,165,209,1)"],["0.583333333333333","rgba(81,155,203,1)"],["0.625","rgba(66,146,198,1)"],["0.666666666666667","rgba(57,135,192,1)"],["0.708333333333333","rgba(46,124,187,1)"],["0.75","rgba(33,113,181,1)"],["0.791666666666667","rgba(27,102,173,1)"],["0.833333333333333","rgba(19,91,164,1)"],["0.875","rgba(8,81,156,1)"],["0.916666666666667","rgba(9,70,139,1)"],["0.958333333333333","rgba(9,59,123,1)"],["1","rgba(8,48,107,1)"]],"showscale":true,"geojson":"https://gisco-services.ec.europa.eu/distribution/v2/nuts/geojson/NUTS_RG_20M_2024_4326_LEVL_2.geojson","featureidkey":"properties.NUTS_ID","locations":["EL30","EL52"],"z":[105,58],"zmin":58,"zmax":105,"marker":{"line":{"color":"white","width":0.29999999999999999}},"text":["Attiki (Greece)<br>2024: 105 % of the EU-27 average","Kentriki Makedonia (Greece)<br>2024: 58 % of the EU-27 average"],"hoverinfo":["text","text"],"frame":"2024","type":"choropleth"}],"highlight":{"on":"plotly_click","persistent":false,"dynamic":false,"selectize":false,"opacityDim":0.20000000000000001,"selected":{"opacity":1},"debounce":0},"shinyEvents":["plotly_hover","plotly_click","plotly_selected","plotly_relayout","plotly_brushed","plotly_brushing","plotly_clickannotation","plotly_doubleclick","plotly_deselect","plotly_afterplot","plotly_sunburstclick"],"base_url":"https://plot.ly"},"evals":[],"jsHooks":[]}
```
