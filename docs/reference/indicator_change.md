# Indicators that rose or fell between two years for one country

As in golemworldbank: compares every indicator a country has a value for
in both years, and splits them into two tables, those that increased
from `year1` to `year2` and those that decreased, each sorted by percent
change, the largest first. The percent change is
`(value2 - value1) / |value1| * 100`; it is undefined when the `year1`
value is 0, so those indicators are in neither table (they are in
`zero_base`), nor are those that did not change.

The indicators that are percentages, whose unit is one (such as "% of
GDP", "Percentage of total population" or "Percentage point"), or whose
name says so when they have no unit (such as "Outward FDI stocks in % of
GDP"), are in two tables of their own, by their change in percentage
points, the largest first, without a percent change: relative to the old
percentage, it misleads (a share going from 0.2% to 1% reads as +400%).
A change in points needs no starting value other than 0, nor the same
sign in both years, so these tables keep those indicators.

Rates of change, whose name or unit says "change" or "growth" (such as
"Real GDP growth" or "Percentage change on previous period"), are left
out unless `include_rates = TRUE`: a percent change of a rate of change
means little (a rate going from 0.1 to 1.7 reads as +1,600%).

## Usage

``` r
indicator_change(
  country,
  year1,
  year2,
  include_rates = FALSE,
  include_sign_change = FALSE,
  values = all_values()
)
```

## Arguments

- country:

  Eurostat code of the country, such as "EL", or "EU27_2020".

- year1, year2:

  The two years to compare.

- include_rates:

  Keep the rates of change.

- include_sign_change:

  Keep the indicators, other than the percentages, whose value changed
  sign between the two years, whose percent change means little; either
  way they are listed in `sign_change`.

- values:

  Data frame of
  [`all_values()`](https://sedzinfo.github.io/golemeurostat/reference/all_values.md).

## Value

A list with `increased` and `decreased` (data frames with the columns
`Indicator`, `Unit`, one named after each year with its value, `Change`
and `Change %`), `percentages_increased` and `percentages_decreased`
(the same without `Change %`), `zero_base` and `sign_change` (names of
indicators). Stops with an error when the country has no values in
either year.

## Examples

``` r
res <- indicator_change("EL", 2015, 2024)
head(res$increased)
#>                                                                                                                          Indicator                               Unit    2015    2024  Change Change %
#> 1                                                                                      First permits by reason: Employment reasons                             Person  1111.0 22290.0 21179.0  1906.30
#> 2                                                            Asylum applicants considered to be unaccompanied minors - annual data                             Person   420.0  4710.0  4290.0  1021.43
#> 3 First instance decisions on asylum applications by type of decision - annual aggregated data: Positive decision - refugee status                             Person  3665.0 39270.0 35605.0   971.49
#> 4                  First instance decisions on asylum applications by type of decision - annual aggregated data: Positive decision                             Person  4030.0 39565.0 35535.0   881.76
#> 5                                                                                       Residential building permits - annual data Square metres per 1000 inhabitants    46.4   347.1   300.7   648.06
#> 6                                                         Asylum applicants by type - annual aggregated data: First time applicant                             Person 11370.0 68995.0 57625.0   506.82
head(res$decreased)
#>                                                                                         Indicator         Unit      2015      2024    Change Change %
#> 1                             Current account transactions - credits, debits and balance: Balance Million euro  -1438.00 -17795.00 -16357.00 -1137.48
#> 2 Extra-EU27 (from 2020) trade, by Member State, total product: Trade balance in million ECU/EURO               -7533.70 -18824.50 -11290.80  -149.87
#> 3     Gender differences in the at-risk-of-poverty rate by age - EU-SILC survey: 65 years or over       Number     -4.92    -12.27     -7.35  -149.39
#> 4   Gender differences in the at-risk-of-poverty rate by age - EU-SILC survey: Less than 65 years       Number     -1.38     -3.35     -1.97  -142.75
#> 5     International trade, by reporting country, total product: Trade balance in million ECU/EURO Million euro -16457.70 -35598.80 -19141.10  -116.30
#> 6                      Current account transactions - goods: credits, debits and balance: Balance Million euro -17666.00 -36449.00 -18783.00  -106.32
head(res$percentages_increased)
#>                                                                                               Indicator                      Unit      2015      2024   Change
#> 1              Purchasing power adjusted GDP per capita: Real expenditure per capita (in PPS_EU27_2020)                Percentage 19100.000 27400.000 8300.000
#> 2                                                   Individuals using the internet for internet banking Percentage of individuals    13.870    54.150   40.280
#> 3                                                         Employment rates of recent graduates: Females                Percentage    44.100    74.600   30.500
#> 4 Share of renewable energy in gross final energy consumption by sector: Renewable energy - electricity                Percentage    22.089    51.248   29.159
#> 5                                                           Employment rates of recent graduates: Total                Percentage    45.200    73.200   28.000
#> 6                                                                                    Daily internet use % of people aged 16 to 74    54.590    82.530   27.940
```
