test_that("parse_filters() turns the filters of the catalogue into a list for Eurostat", {
  expect_equal(parse_filters("sex=T;age=Y15-74;unit=PC_ACT"), list(sex = "T", age = "Y15-74", unit = "PC_ACT"))
})

test_that("the catalogue has unique ids, a known level, filters and a definition for each indicator", {
  table <- indicators()
  expect_false(anyDuplicated(table$id) > 0)
  # the ids name the downloads in the disk cache
  expect_true(all(grepl("^[a-z0-9_]+$", table$id)))
  expect_true(all(table$level %in% c("country", "region")))
  expect_true(all(lengths(lapply(table$filters, parse_filters)) > 0))
  expect_true(all(nzchar(table$name) & nzchar(table$definition) & nzchar(table$topic)))
  # some of Eurostat's main tables have no unit; the hand-written rows all have one
  expect_true(all(nzchar(table$unit[!table$generated])))
})

test_that("the generated rows come after the hand-written ones and repeat none of them", {
  table <- indicators()
  expect_true(any(table$generated))
  expect_false(is.unsorted(table$generated))
  expect_false(anyDuplicated(series_key(table)) > 0)
})

test_that("series_key() finds the same series whatever the order of the filters and freq=A", {
  row <- function(filters, level = "country") data.frame(level = level, dataset = "une_rt_a", filters = filters)
  expect_equal(series_key(row("freq=A;unit=PC_ACT;sex=T")), series_key(row("sex=T;unit=PC_ACT")))
  expect_false(series_key(row("sex=T")) == series_key(row("sex=F")))
  # the same filters for the regions are another series
  expect_false(series_key(row("sex=T")) == series_key(row("sex=T", "region")))
})

test_that("indicator_choices() gives the indicators of a level, each topic in one group", {
  countries <- indicator_choices()
  regions <- indicator_choices("region")
  expect_named(countries, c("label", "value", "optgroup", "dataset"))
  expect_true(all(regions$value %in% indicators()$id[indicators()$level == "region"]))
  expect_false(any(regions$value %in% countries$value))
  # selectize shows a group where its first option is, so the options of a topic must be together
  runs <- rle(countries$optgroup)$values
  expect_false(anyDuplicated(runs) > 0)
})

test_that("countries() has the EU, EFTA and candidate countries and the EU-27 average", {
  known <- countries()
  expect_equal(sum(known$group == "EU"), 27)
  expect_true(all(c("EL", "NO", "RS", "EU27_2020") %in% known$code))
})

test_that("tidy_countries() keeps the countries and the EU-27 average, with their names", {
  data <- tidy_countries(raw_unemployment)
  expect_setequal(unique(data$geo), c("EL", "BG", "EU27_2020"))
  expect_equal(unique(data$country[data$geo == "EL"]), "Greece")
  expect_equal(unique(data$group[data$geo == "EU27_2020"]), "EU-27")
  expect_false(anyNA(data$value))
})

test_that("tidy_countries() leaves out values in the wrong units, a million times too large", {
  # Turkiye in old lira the first year, in new lira the next two
  raw <- rbind(raw_unemployment, data.frame(freq = "A", age = "Y15-74", unit = "PC_ACT", sex = "T", geo = "TR", time = 2022:2024, values = c(9e6, 9, 9)))
  expect_message(data <- tidy_countries(raw), "TR 2022")
  expect_equal(data$year[data$geo == "TR"], 2023:2024)
})

test_that("tidy_countries() keeps a country far larger than the others every year", {
  raw <- data.frame(geo = rep(c("DE", "MT", "CY", "LU"), each = 2), time = 2023:2024, values = c(3e5, 3.2e5, 10, 12, 50, 40, 30, 20))
  expect_no_message(data <- tidy_countries(raw))
  expect_equal(nrow(data), 8)
})

test_that("tidy_regions() keeps the regions of the map, with their names and countries", {
  raw <- data.frame(geo = c("EL30", "EL3", "XX99"), time = 2024, values = c(105, 100, 1))
  data <- tidy_regions(raw, c(EL30 = "Attiki", EL52 = "Kentriki Makedonia"))
  expect_equal(data$geo, "EL30")
  expect_equal(c(data$region, data$country), c("Attiki", "Greece"))
})

test_that("get_indicator() keeps a download for a day, and passes on that Eurostat cannot be reached", {
  old <- options(golemeurostat.cache_dir = tempfile("cache"))
  downloads <- 0
  local_mocked_bindings(download_eurostat = function(dataset, filters) {
    downloads <<- downloads + 1
    raw_unemployment
  })
  first <- get_indicator("unemployment")
  expect_equal(get_indicator("unemployment"), first)
  expect_equal(downloads, 1)
  local_mocked_bindings(download_eurostat = function(dataset, filters) NULL)
  expect_null(get_indicator("inflation"))
  options(old)
})

test_that("check_indicators() reports the countries and years of a row, or what is wrong with it", {
  local_mocked_bindings(fetch_eurostat = function(dataset, filters) raw_unemployment)
  good <- check_indicators("unemployment")
  expect_true(good$ok)
  expect_equal(c(good$areas, good$first, good$last), c(2, 2022, 2024))
  # a dimension left open gives two values for a country and year
  local_mocked_bindings(fetch_eurostat = function(dataset, filters) rbind(raw_unemployment, transform(raw_unemployment, sex = "F")))
  open <- check_indicators("unemployment")
  expect_false(open$ok)
  expect_match(open$problem, "dimension of the dataset is left open")
  local_mocked_bindings(fetch_eurostat = function(dataset, filters) stop("HTTP status: 400 (Bad request)\nError id: 150"))
  refused <- check_indicators("unemployment")
  expect_false(refused$ok)
  expect_equal(refused$problem, "HTTP status: 400 (Bad request)")
})

test_that("the pyramid gives each age group as a share of its sex, for the years with every group", {
  ages <- pyramid_ages
  raw <- data.frame(
    unit = "NR",
    sex = rep(c("M", "F"), each = length(ages)),
    age = ages,
    geo = "EL",
    time = rep(c(2024, 2025), each = 2 * length(ages)),
    values = 1:(4 * length(ages))
  )
  # 2024 lacks the group of 85 and over of the men, so it is left out
  raw <- raw[!(raw$time == 2024 & raw$sex == "M" & raw$age == "Y_GE85"), ]
  data <- tidy_pyramid(raw)
  expect_equal(unique(data$year), 2025L)
  expect_equal(as.vector(tapply(data$value, data$sex, sum)), c(100, 100))
  expect_equal(levels(data$age)[c(1, 2, 18)], c("0-4", "5-9", "85+"))
})

test_that("an indicator saved in the package has the columns of a download, with the names of the countries", {
  data <- saved_indicator("unemployment")
  expect_named(data, c("geo", "country", "group", "year", "value"))
  expect_type(data$geo, "character")
  expect_equal(unique(data$country[data$geo == "EL"]), "Greece")
  expect_true(all(data$geo %in% countries()$code))
  expect_error(saved_indicator("nonsense"), "No indicator has the id")
})

test_that("the regional indicators and the pyramids saved in the package have the columns of a download", {
  regional <- saved_regional("r_gdp_pps")
  expect_named(regional, c("geo", "region", "country", "year", "value"))
  expect_type(regional$geo, "character")
  expect_false(anyNA(regional$region))
  expect_equal(unique(regional$country[startsWith(regional$geo, "EL")]), "Greece")
  expect_error(saved_regional("nonsense"), "No indicator has the id")
  pyramid <- saved_pyramid("EL")
  expect_named(pyramid, c("sex", "age", "year", "value"))
  # the shares of the age groups of each sex add up to 100 in every year
  expect_true(all(abs(tapply(pyramid$value, list(pyramid$year, pyramid$sex), sum) - 100) < 1e-6))
})
