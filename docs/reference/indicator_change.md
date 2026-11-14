# Indicators that rose or fell between two years for one country

As in golemworldbank: compares every indicator a country has a value for
in both years, and splits them into two tables, those that increased
from `year1` to `year2` and those that decreased, each sorted by percent
change, the largest first. The percent change is
`(value2 - value1) / |value1| * 100`; it is undefined when the `year1`
value is 0, so those indicators are in neither table (they are in
`zero_base`), nor are those that did not change.

Rates of change, whose name or unit says "change" or "growth" (such as
"Real GDP growth" or "Percentage change on previous period"), are left
out unless `include_rates = TRUE`: a percent change of a rate of change
means little (a rate going from 0.1 to 1.7 reads as +1,600%).

For indicators that are percentages, such as the unemployment rate, the
percent change is relative to the old percentage, not a difference in
percentage points; the `Change` column gives the plain difference.

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

  Keep the indicators whose value changed sign between the two years,
  whose percent change means little; either way they are listed in
  `sign_change`.

- values:

  Data frame of
  [`all_values()`](https://sedzinfo.github.io/golemeurostat/reference/all_values.md).

## Value

A list with `increased` and `decreased` (data frames with the columns
`Indicator`, `Unit`, one named after each year with its value, `Change`
and `Change %`), `zero_base` and `sign_change` (names of indicators).
Stops with an error when the country has no values in either year.

## Examples

``` r
res <- indicator_change("EL", 2015, 2024)
head(res$increased)
#>                                                                                                                 Indicator                                       Unit    2015     2024   Change Change %
#> 1                                                                             First permits by reason: Employment reasons                                     Person 1111.00 22290.00 21179.00  1906.30
#> 2 Share of government allocations for R&D (GBARD) allocated to defence and total civil socio-economic objectives: Defence                  Percentage of total GBARD    0.09     1.31     1.22  1355.56
#> 3                Private sector debt: debt securities by sectors, non-consolidated - % of GDP: Non-financial corporations Percentage of gross domestic product (GDP)    0.20     2.90     2.70  1350.00
#> 4                   Private sector debt: debt securities, by sectors, consolidated - % of GDP: Non-financial corporations Percentage of gross domestic product (GDP)    0.20     2.80     2.60  1300.00
#> 5                        Total financial sector liabilities, by instruments, non-consolidated - % of GDP: Debt securities Percentage of gross domestic product (GDP)    1.00    12.10    11.10  1110.00
#> 6                                                   Asylum applicants considered to be unaccompanied minors - annual data                                     Person  420.00  4710.00  4290.00  1021.43
head(res$decreased)
#>                                                                                         Indicator                                       Unit    2015     2024   Change Change %
#> 1                             Current account transactions - credits, debits and balance: Balance                               Million euro -1438.0 -17795.0 -16357.0 -1137.48
#> 2       Current account, main components, net balance - annual data, % of GDP: Goods and services Percentage of gross domestic product (GDP)    -0.6     -5.8     -5.2  -866.67
#> 3          Current account, main components, net balance - annual data, % of GDP: Current account Percentage of gross domestic product (GDP)    -0.8     -7.5     -6.7  -837.50
#> 4                                                           Current account balance - annual data Percentage of gross domestic product (GDP)    -0.8     -7.5     -6.7  -837.50
#> 5                                                        Current account balance - 3 year average     Percentage of GDP - three-year average    -1.0     -8.3     -7.3  -730.00
#> 6 Extra-EU27 (from 2020) trade, by Member State, total product: Trade balance in million ECU/EURO                                            -7533.7 -18824.5 -11290.8  -149.87
```
