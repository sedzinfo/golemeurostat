# Eurostat Indicators Explorer

A Shiny app, built as a golem package, for exploring indicators of [Eurostat](https://ec.europa.eu/eurostat), the statistical office of the European Union: for the 27 countries of the EU, the 4 of EFTA and the 9 candidate countries, with the EU-27 average for comparison, and for the regions of Europe. It follows the layout of [golemworldbank](https://github.com/sedzinfo/golemworldbank).

# Tabs
- **Country Comparison**: an indicator over the years for the countries you pick, with the EU-27 average as a dashed line
- **Barplot**: the countries ranked by an indicator, as a race through the years, with the country you pick in red
- **Map**: the countries colored by an indicator, animated by year
- **Regions**: the regions of Europe (NUTS 2) colored by an indicator, such as GDP per inhabitant or unemployment, animated by year
- **Scatterplot**: the countries by two indicators, animated by year, with the correlation of the two in each year
- **Indicators**: every indicator of the app, with its unit, definition and a link to its dataset at Eurostat

# Usage
From the package folder:
```r
pkgload::load_all()
run_app()
```

The data and the charts can also be used from R:
```r
indicators()                       # the catalogue of indicators
unemployment <- get_indicator("unemployment")
plot_country_comp(unemployment, c("EL", "BG", "PT"), "unemployment")
plot_regions(get_regional("r_gdp_pps"), "r_gdp_pps")
```
Eurostat codes the countries with two letters, as ISO does, except Greece, which is `EL`.

# Adding an indicator
The indicators are rows of `inst/extdata/indicators.csv`, so adding one needs no R code:

| Column | Contents |
|---|---|
| `id` | A short name, lower case letters, digits and `_` |
| `level` | `country`, or `region` for the Regions tab |
| `topic`, `name`, `unit` | How the app shows it |
| `dataset` | The code of the Eurostat dataset, such as `une_rt_a` |
| `filters` | The value of each of the other dimensions of the dataset, such as `sex=T;age=Y15-74;unit=PC_ACT`, so that one value is left per country and year |
| `definition` | A sentence for the Indicators tab |

The code of a dataset and of its dimensions are in the [Eurostat data browser](https://ec.europa.eu/eurostat/databrowser/). `check_indicators("your_id")` tries a new row: it reports the countries or regions and the years it has, or what is wrong with it, such as a dimension that Eurostat does not know or one left open, which gives more than one value per country and year. Run `check_indicators()` now and then to check them all, as Eurostat sometimes renames or retires a dataset.

# Data
Each indicator is downloaded from the Eurostat API, which needs no key, the first time a tab shows it, and kept on disk for a day, in `tools::R_user_dir("golemeurostat", "cache")`; set `options(golemeurostat.cache_dir = )` to keep it elsewhere. The outlines of the countries and regions of the maps, the NUTS 2024 classification, come from [GISCO](https://ec.europa.eu/eurostat/web/gisco) and are downloaded once.

Source of the data: Eurostat. Administrative boundaries: © EuroGeographics.

# Development
Run the tests with `devtools::test()`, which use saved Eurostat answers and need no internet, and the full package check with `devtools::check()`.
