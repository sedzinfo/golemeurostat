# The countries of the app

The countries of the European Union, of EFTA and the candidate
countries, by their Eurostat codes (Greece is EL), with their English
names and their group, and the EU-27 average.

## Usage

``` r
countries()
```

## Value

A data frame with `code`, `name` and `group`.

## Examples

``` r
countries()
#>         code                   name     group
#> 1         BE                Belgium        EU
#> 2         BG               Bulgaria        EU
#> 3         CZ                Czechia        EU
#> 4         DK                Denmark        EU
#> 5         DE                Germany        EU
#> 6         EE                Estonia        EU
#> 7         IE                Ireland        EU
#> 8         EL                 Greece        EU
#> 9         ES                  Spain        EU
#> 10        FR                 France        EU
#> 11        HR                Croatia        EU
#> 12        IT                  Italy        EU
#> 13        CY                 Cyprus        EU
#> 14        LV                 Latvia        EU
#> 15        LT              Lithuania        EU
#> 16        LU             Luxembourg        EU
#> 17        HU                Hungary        EU
#> 18        MT                  Malta        EU
#> 19        NL            Netherlands        EU
#> 20        AT                Austria        EU
#> 21        PL                 Poland        EU
#> 22        PT               Portugal        EU
#> 23        RO                Romania        EU
#> 24        SI               Slovenia        EU
#> 25        SK               Slovakia        EU
#> 26        FI                Finland        EU
#> 27        SE                 Sweden        EU
#> 28        IS                Iceland      EFTA
#> 29        LI          Liechtenstein      EFTA
#> 30        NO                 Norway      EFTA
#> 31        CH            Switzerland      EFTA
#> 32        BA Bosnia and Herzegovina Candidate
#> 33        ME             Montenegro Candidate
#> 34        MD                Moldova Candidate
#> 35        MK        North Macedonia Candidate
#> 36        GE                Georgia Candidate
#> 37        AL                Albania Candidate
#> 38        RS                 Serbia Candidate
#> 39        TR                Türkiye Candidate
#> 40        UA                Ukraine Candidate
#> 41 EU27_2020                  EU-27     EU-27
```
