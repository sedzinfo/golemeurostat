# Package index

## App

- [`run_app()`](https://sedzinfo.github.io/golemeurostat/reference/run_app.md)
  : Run the Eurostat Indicators Explorer

## Data

The catalogue of indicators and countries, downloading an indicator from
Eurostat for the countries or the regions, or the population of a
country by age and sex, checking the catalogue against Eurostat, and the
values of all the indicators that the Change (%) tab compares; the
values of an indicator of the countries or the regions, or the
population of a country by age and sex, as saved in the package, without
internet, which the examples of the charts use

- [`all_values()`](https://sedzinfo.github.io/golemeurostat/reference/all_values.md)
  : The values of all the indicators
- [`check_indicators()`](https://sedzinfo.github.io/golemeurostat/reference/check_indicators.md)
  : Check the catalogue against Eurostat
- [`countries()`](https://sedzinfo.github.io/golemeurostat/reference/countries.md)
  : The countries of the app
- [`get_indicator()`](https://sedzinfo.github.io/golemeurostat/reference/get_indicator.md)
  : Get an indicator for the countries
- [`get_pyramid()`](https://sedzinfo.github.io/golemeurostat/reference/get_pyramid.md)
  : Get the population of a country by age group and sex
- [`get_regional()`](https://sedzinfo.github.io/golemeurostat/reference/get_regional.md)
  : Get an indicator for the regions
- [`indicator_change()`](https://sedzinfo.github.io/golemeurostat/reference/indicator_change.md)
  : Indicators that rose or fell between two years for one country
- [`indicators()`](https://sedzinfo.github.io/golemeurostat/reference/indicators.md)
  : The indicators of the app
- [`saved_indicator()`](https://sedzinfo.github.io/golemeurostat/reference/saved_indicator.md)
  : Get an indicator for the countries, as saved in the package
- [`saved_pyramid()`](https://sedzinfo.github.io/golemeurostat/reference/saved_pyramid.md)
  : Get the population of a country by age group and sex, as saved in
  the package
- [`saved_regional()`](https://sedzinfo.github.io/golemeurostat/reference/saved_regional.md)
  : Get an indicator for the regions, as saved in the package

## Plot

The plotly charts of the tabs: country and indicator comparisons,
population pyramid, ranked bars, maps of the countries and of the
regions, scatter plot

- [`plot_bar()`](https://sedzinfo.github.io/golemeurostat/reference/plot_bar.md)
  : Ranked bars of an indicator, animated by year
- [`plot_country_comp()`](https://sedzinfo.github.io/golemeurostat/reference/plot_country_comp.md)
  : Line chart of an indicator for several countries
- [`plot_indicator_comp()`](https://sedzinfo.github.io/golemeurostat/reference/plot_indicator_comp.md)
  : Line chart of several indicators for one country
- [`plot_map()`](https://sedzinfo.github.io/golemeurostat/reference/plot_map.md)
  : Map of the countries, animated by year
- [`plot_pyramid()`](https://sedzinfo.github.io/golemeurostat/reference/plot_pyramid.md)
  : Population pyramid, animated by year
- [`plot_regions()`](https://sedzinfo.github.io/golemeurostat/reference/plot_regions.md)
  : Map of the regions, animated by year
- [`plot_scatter()`](https://sedzinfo.github.io/golemeurostat/reference/plot_scatter.md)
  : Scatter plot of two indicators, animated by year

## Render

The tables of the Change (%) and Indicators tabs

- [`render_change_table()`](https://sedzinfo.github.io/golemeurostat/reference/render_change_table.md)
  :

  One table of
  [`indicator_change()`](https://sedzinfo.github.io/golemeurostat/reference/indicator_change.md)
  as a DataTable

- [`render_index_table()`](https://sedzinfo.github.io/golemeurostat/reference/render_index_table.md)
  : Table of the indicators

## UI

Internal functions not meant to run independently

- [`mod_about_ui()`](https://sedzinfo.github.io/golemeurostat/reference/mod_about_ui.md)
  : About module - UI
- [`mod_bar_ui()`](https://sedzinfo.github.io/golemeurostat/reference/mod_bar_ui.md)
  : Barplot module - UI
- [`mod_change_ui()`](https://sedzinfo.github.io/golemeurostat/reference/mod_change_ui.md)
  : Change (%) module - UI
- [`mod_country_comp_ui()`](https://sedzinfo.github.io/golemeurostat/reference/mod_country_comp_ui.md)
  : Country Comparison module - UI
- [`mod_index_table_ui()`](https://sedzinfo.github.io/golemeurostat/reference/mod_index_table_ui.md)
  : Indicators module - UI
- [`mod_indicator_comp_ui()`](https://sedzinfo.github.io/golemeurostat/reference/mod_indicator_comp_ui.md)
  : Indicator Comparison module - UI
- [`mod_map_ui()`](https://sedzinfo.github.io/golemeurostat/reference/mod_map_ui.md)
  : Map module - UI
- [`mod_pyramid_ui()`](https://sedzinfo.github.io/golemeurostat/reference/mod_pyramid_ui.md)
  : Pyramid module - UI
- [`mod_regions_ui()`](https://sedzinfo.github.io/golemeurostat/reference/mod_regions_ui.md)
  : Regions module - UI
- [`mod_scatter_ui()`](https://sedzinfo.github.io/golemeurostat/reference/mod_scatter_ui.md)
  : Scatterplot module - UI

## Server

Internal functions not meant to run independently

- [`mod_bar_server()`](https://sedzinfo.github.io/golemeurostat/reference/mod_bar_server.md)
  : Barplot module - server
- [`mod_change_server()`](https://sedzinfo.github.io/golemeurostat/reference/mod_change_server.md)
  : Change (%) module - server
- [`mod_country_comp_server()`](https://sedzinfo.github.io/golemeurostat/reference/mod_country_comp_server.md)
  : Country Comparison module - server
- [`mod_index_table_server()`](https://sedzinfo.github.io/golemeurostat/reference/mod_index_table_server.md)
  : Indicators module - server
- [`mod_indicator_comp_server()`](https://sedzinfo.github.io/golemeurostat/reference/mod_indicator_comp_server.md)
  : Indicator Comparison module - server
- [`mod_map_server()`](https://sedzinfo.github.io/golemeurostat/reference/mod_map_server.md)
  : Map module - server
- [`mod_pyramid_server()`](https://sedzinfo.github.io/golemeurostat/reference/mod_pyramid_server.md)
  : Pyramid module - server
- [`mod_regions_server()`](https://sedzinfo.github.io/golemeurostat/reference/mod_regions_server.md)
  : Regions module - server
- [`mod_scatter_server()`](https://sedzinfo.github.io/golemeurostat/reference/mod_scatter_server.md)
  : Scatterplot module - server
