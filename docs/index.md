# Eurostat Indicators Explorer

[Website](https://sedzinfo.github.io/golemeurostat/)

A Shiny app, built as a golem package, for exploring indicators of
[Eurostat](https://ec.europa.eu/eurostat), the statistical office of the
European Union: for the 27 countries of the EU, the 4 of EFTA and the 9
candidate countries, with the EU-27 average for comparison, and for the
regions of Europe. It follows the design of
[golemworldbank](https://github.com/sedzinfo/golemworldbank), and shares
its stylesheets and scripts, which both apps load from
[sedzinfo.github.io](https://github.com/sedzinfo/sedzinfo.github.io/tree/main/shiny):
the layout of the page, on a desktop and on a phone, and the dark mode.

# Tabs

The tabs of golemworldbank, with two maps: - **Country Comparison**: an
indicator over the years for the countries you pick, with the EU-27
average as a dashed line - **Indicator Comparison**: several indicators
over the years for one country, or the EU-27 - **Pyramid**: the
population of a country by five-year age group and sex, animated by
year - **Barplot**: the countries ranked by an indicator, as a race
through the years, with the country you pick in red - **Scatterplot**:
the countries by two indicators, as bubbles as large as their
population, animated by year, with the correlation of the two in each
year - **Map**: the countries colored by an indicator, from red for the
lowest through white to dark blue for the highest, animated by year -
**Regions**: the regions of Europe (NUTS 2) colored in the same way by
an indicator, such as GDP per inhabitant or unemployment, animated by
year - **Change (%)**: the indicators of a country that rose and fell
between two years, by how much - **Indicators**: every indicator of the
app, with its unit, definition and a link to its dataset at Eurostat -
**About**: where the data comes from, the acknowledgments and the
license

The indicators are the 62 chosen by hand and, after them, the series of
Eurostat’s main tables, about 1,500 more, in the groups of Eurostat’s
themes. Type in a list of indicators to search their names, or the code
of a dataset, such as `une_rt_a`.

# Installation

Open RStudio (or an R console) and run:

`# Install devtools if you haven't already`` `[`install.packages`](https://rdrr.io/r/utils/install.packages.html)`(``"devtools"``)`` ``# Install golemeurostat from GitHub`` ``devtools``::`[`install_github`](https://devtools.r-lib.org/reference/install-deprecated.html)`(``"sedzinfo/golemeurostat"``)`

Without devtools, install the source tarball of the [latest
release](https://github.com/sedzinfo/golemeurostat/releases/tag/latest),
which is rebuilt from `main` on every change, together with the PDF
manual:

[`install.packages`](https://rdrr.io/r/utils/install.packages.html)`(`` `` ``"https://github.com/sedzinfo/golemeurostat/releases/download/latest/golemeurostat_0.0.0.9000.tar.gz"``,`` `` repos ``=`` ``NULL``, type ``=`` ``"source"`` ``)`

# Usage

From the package folder:

`pkgload``::`[`load_all`](https://pkgload.r-lib.org/reference/load_all.html)`(``)`` `[`run_app`](https://sedzinfo.github.io/golemeurostat/reference/run_app.md)`(``)`

`app.R`, which the deployment runs, starts it with
`run_app(analytics = TRUE)`: Google Analytics, through the cookie banner
shared with the sites of sedzinfo.github.io, which loads it only after
the visitor accepts, and a footer with the Cookie settings and Privacy
links, as in golemworldbank. Without it, the app sends nothing.

The data and the charts can also be used from R:

[`indicators`](https://sedzinfo.github.io/golemeurostat/reference/indicators.md)`(``)`` ``# the catalogue of indicators`` ``unemployment`` ``<-`` `[`get_indicator`](https://sedzinfo.github.io/golemeurostat/reference/get_indicator.md)`(``"unemployment"``)`` `[`plot_country_comp`](https://sedzinfo.github.io/golemeurostat/reference/plot_country_comp.md)`(``unemployment``, `[`c`](https://rdrr.io/r/base/c.html)`(``"EL"``, ``"BG"``, ``"PT"``)``, ``"unemployment"``)`` `[`plot_regions`](https://sedzinfo.github.io/golemeurostat/reference/plot_regions.md)`(`[`get_regional`](https://sedzinfo.github.io/golemeurostat/reference/get_regional.md)`(``"r_gdp_pps"``)``, ``"r_gdp_pps"``)`

Eurostat codes the countries with two letters, as ISO does, except
Greece, which is `EL`.

# Adding an indicator

The indicators come from two files of `inst/extdata`, with the same
columns: `indicators.csv`, written by hand, and
`indicators_generated.csv`, written by a script from the catalogue of
Eurostat.

## By hand

An indicator added to `indicators.csv` comes first in the lists, under
its own topic, and needs no R code:

| Column | Contents |
|----|----|
| `id` | A short name, lower case letters, digits and `_` |
| `level` | `country`, or `region` for the Regions tab |
| `topic`, `name`, `unit` | How the app shows it |
| `dataset` | The code of the Eurostat dataset, such as `une_rt_a` |
| `filters` | The value of each of the other dimensions of the dataset, such as `sex=T;age=Y15-74;unit=PC_ACT`, so that one value is left per country and year |
| `definition` | A sentence for the Indicators tab |

The code of a dataset and of its dimensions are in the [Eurostat data
browser](https://ec.europa.eu/eurostat/databrowser/).
`check_indicators("your_id")` tries a new row: it reports the countries
or regions and the years it has, or what is wrong with it, such as a
dimension that Eurostat does not know or one left open, which gives more
than one value per country and year. Run
[`check_indicators()`](https://sedzinfo.github.io/golemeurostat/reference/check_indicators.md)
now and then to check them all, as Eurostat sometimes renames or retires
a dataset.

## From Eurostat’s main tables

`indicators_generated.csv` holds the series of the [main
tables](https://ec.europa.eu/eurostat/web/main/data/database) of
Eurostat, its own selection of headline indicators with few breakdowns
(codes such as `tps00001`, `tec00115` or `sdg_08_10`). To rebuild it, as
Eurostat adds, renames and retires tables, run from the package folder:

[`source`](https://rdrr.io/r/base/source.html)`(``"data-raw/build_indicators.R"``)`

The script reads Eurostat’s table of contents and the dimensions of
every dataset, downloads each main table with yearly data once (about
680 tables, about 10 minutes the first time; the downloads are kept a
week in `data-raw/cache`), and writes a row for each series, a
combination of the dimensions other than the country and the year, that
has values for at least 10 countries, or 50 regions for the Regions tab,
up to 2015 or later. A table with more than 10 such series is left out,
and so are amounts in national currency, which cannot be compared
between countries, and a series that another table already has under the
same name. The names come from the titles of the tables and the labels
of the codes; the topic is the folder of the table in Eurostat’s themes.
These limits are at the top of the script. At its end, it runs
`data-raw/build_values.R`, which writes `inst/extdata/values.rds`, the
values of every indicator of the countries (about 750,000, 1 MB), for
the Change (%) tab.

A generated row that downloads the same as a hand-written one is left
out, so to rename or describe a generated indicator better, copy its row
to `indicators.csv` and change it there.

# Data

Each indicator is downloaded from the Eurostat API, which needs no key,
the first time a tab shows it, and kept on disk for a day, in
`tools::R_user_dir("golemeurostat", "cache")`; set
`options(golemeurostat.cache_dir = )` to keep it elsewhere. The outlines
of the countries and regions of the maps, the NUTS 2024 classification,
come from [GISCO](https://ec.europa.eu/eurostat/web/gisco) and are
downloaded once. The Change (%) tab, which compares all the indicators
of a country at once, uses instead the values written into the package
by `data-raw/build_values.R`, and says their date.

Source of the data: Eurostat. Administrative boundaries: ©
EuroGeographics.

# Development

Run the tests with
[`devtools::test()`](https://devtools.r-lib.org/reference/test.html),
which use saved Eurostat answers and need no internet, and the full
package check with
[`devtools::check()`](https://devtools.r-lib.org/reference/check.html).
