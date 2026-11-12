# The indicators of the app

The catalogue in `inst/extdata/indicators.csv`, one row per indicator:
its `id`, whether it is for countries or regions (`level`), its `topic`,
`name` and `unit`, the Eurostat `dataset` it comes from, the values that
fix the other dimensions of that dataset (`filters`, such as
`sex=T;age=Y15-74`) and a short `definition`. A row added to the file
adds an indicator to the app.

## Usage

``` r
indicators()
```

## Value

A data frame with one row per indicator.

## Examples

``` r
indicators()[, c("id", "level", "name", "unit")]
#>                        id   level                                                            name                                          unit
#> 1                 gdp_pps country                                       GDP per inhabitant in PPS                            Index, EU-27 = 100
#> 2                 gdp_eur country                                              GDP per inhabitant                         EUR at current prices
#> 3              gdp_growth country                                                 Real GDP growth                 % change on the previous year
#> 4             price_level country                                              Price level of GDP                            Index, EU-27 = 100
#> 5                 exports country                                   Exports of goods and services                                      % of GDP
#> 6              investment country                      Investment (gross fixed capital formation)                                      % of GDP
#> 7             rd_spending country                            Research and development expenditure                                      % of GDP
#> 8                gov_debt country                                           Government gross debt                                      % of GDP
#> 9             gov_balance country                           Government deficit (-) or surplus (+)                                      % of GDP
#> 10            tax_revenue country                                  Taxes and social contributions                                      % of GDP
#> 11        gov_expenditure country                                          Government expenditure                                      % of GDP
#> 12              inflation country                                                Inflation (HICP)              Annual average rate of change, %
#> 13           house_prices country                                               House price index                             Index, 2015 = 100
#> 14           net_earnings country                                 Net earnings of a single worker                                  EUR per year
#> 15         gender_pay_gap country                                                  Gender pay gap      % of men's average gross hourly earnings
#> 16           unemployment country                                               Unemployment rate                         % of the labour force
#> 17     youth_unemployment country                                         Youth unemployment rate           % of the labour force aged 15 to 24
#> 18 long_term_unemployment country                                     Long-term unemployment rate                         % of the labour force
#> 19        employment_rate country                                                 Employment rate             % of the population aged 20 to 64
#> 20  gender_employment_gap country                                           Gender employment gap                             Percentage points
#> 21              part_time country                                            Part-time employment                               % of employment
#> 22                   neet country Young people neither in employment nor in education or training                       % of 15 to 29 year olds
#> 23                  arope country                          At risk of poverty or social exclusion                           % of the population
#> 24           poverty_rate country                                         At-risk-of-poverty rate                           % of the population
#> 25          median_income country                                   Median equivalised net income                                  EUR per year
#> 26                   gini country                            Income inequality (Gini coefficient)                  0 = equal, 100 = one has all
#> 27           income_ratio country                           Income quintile share ratio (S80/S20)                                         Ratio
#> 28            deprivation country                          Severe material and social deprivation                           % of the population
#> 29           housing_cost country                                    Housing cost overburden rate                           % of the population
#> 30           overcrowding country                                               Overcrowding rate                           % of the population
#> 31             population country                                                      Population                          Persons on 1 January
#> 32      population_growth country                                               Population growth                         Per 1,000 inhabitants
#> 33             birth_rate country                                                      Birth rate             Live births per 1,000 inhabitants
#> 34              fertility country                                                  Fertility rate                         Live births per woman
#> 35          net_migration country                                                   Net migration                         Per 1,000 inhabitants
#> 36             median_age country                                                      Median age                                         Years
#> 37     old_age_dependency country                                        Old-age dependency ratio People aged 65 and over per 100 aged 15 to 64
#> 38        life_expectancy country                                        Life expectancy at birth                                         Years
#> 39     healthy_life_years country                                     Healthy life years at birth                                         Years
#> 40       infant_mortality country                                           Infant mortality rate                  Deaths per 1,000 live births
#> 41        health_spending country                                              Health expenditure                                      % of GDP
#> 42          early_leavers country                       Early leavers from education and training                       % of 18 to 24 year olds
#> 43               tertiary country                                   Tertiary education attainment                       % of 25 to 34 year olds
#> 44         adult_learning country                                 Adult participation in learning                       % of 25 to 64 year olds
#> 45         internet_daily country                                              Daily internet use                     % of people aged 16 to 74
#> 46        online_shopping country                                                 Online shopping                     % of people aged 16 to 74
#> 47             renewables country                                                Renewable energy           % of gross final energy consumption
#> 48         energy_imports country                                        Energy import dependency                   % of gross available energy
#> 49         ghg_per_capita country                     Net greenhouse gas emissions per inhabitant                      Tonnes of CO2 equivalent
#> 50        municipal_waste country                                                 Municipal waste                      Kilograms per inhabitant
#> 51              recycling country                               Recycling rate of municipal waste                          % of municipal waste
#> 52                   cars country                                                  Passenger cars                         Per 1,000 inhabitants
#> 53              homicides country                                            Intentional homicide                       Per 100,000 inhabitants
#> 54              r_gdp_pps  region                                       GDP per inhabitant in PPS                        % of the EU-27 average
#> 55                   r_rd  region                            Research and development expenditure                                      % of GDP
#> 56         r_unemployment  region                                               Unemployment rate                         % of the labour force
#> 57           r_employment  region                                                 Employment rate             % of the population aged 20 to 64
#> 58                r_arope  region                          At risk of poverty or social exclusion                           % of the population
#> 59    r_population_growth  region                                               Population growth                         Per 1,000 inhabitants
#> 60              r_density  region                                              Population density                  Persons per square kilometre
#> 61      r_life_expectancy  region                                        Life expectancy at birth                                         Years
#> 62             r_tertiary  region                                   Tertiary education attainment                       % of 25 to 64 year olds
```
