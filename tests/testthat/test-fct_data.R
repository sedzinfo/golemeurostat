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
  expect_true(all(nzchar(table$name) & nzchar(table$unit) & nzchar(table$definition)))
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
  raw <- rbind(raw_unemployment, data.frame(freq = "A", age = "Y15-74", unit = "PC_ACT", sex = "T", geo = "TR", time = 2022, values = 9e6))
  expect_message(data <- tidy_countries(raw), "TR 2022")
  expect_false("TR" %in% data$geo)
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
