test_that("the tabs of the countries draw their charts", {
  data <- tidy_countries(raw_unemployment)
  local_mocked_bindings(get_indicator = function(id) data)
  testServer(mod_country_comp_server, {
    session$setInputs(indicator = "unemployment", countries = c("EL", "BG"))
    expect_no_error(output$plot)
  })
  testServer(mod_bar_server, {
    session$setInputs(indicator = "unemployment", country = "EL", top_n = "30")
    expect_no_error(output$plot)
  })
  testServer(mod_map_server, {
    session$setInputs(indicator = "unemployment")
    expect_no_error(output$plot)
  })
  testServer(mod_scatter_server, {
    session$setInputs(x = "unemployment", y = "unemployment")
    expect_no_error(output$plot)
  })
})

test_that("the tabs say when Eurostat cannot be reached", {
  local_mocked_bindings(get_indicator = function(id) NULL, get_regional = function(id) NULL)
  testServer(mod_country_comp_server, {
    session$setInputs(indicator = "unemployment", countries = "EL")
    expect_error(output$plot, "Eurostat cannot be reached")
  })
  testServer(mod_regions_server, {
    session$setInputs(indicator = "r_gdp_pps")
    expect_error(output$plot, "cannot be reached")
  })
})

test_that("the regions and the table of the indicators are drawn", {
  local_mocked_bindings(get_regional = function(id) regions)
  testServer(mod_regions_server, {
    session$setInputs(indicator = "r_gdp_pps")
    expect_no_error(output$plot)
  })
  testServer(mod_index_table_server, {
    expect_no_error(output$table)
  })
})

test_that("the new tabs of golemworldbank draw their charts and tables", {
  data <- tidy_countries(raw_unemployment)
  pyramid <- data.frame(sex = rep(c("Male", "Female"), each = 2), age = factor(c("0-4", "5-9")), year = 2025L, value = c(48, 52, 49, 51))
  local_mocked_bindings(get_indicator = function(id) data, get_pyramid = function(country) pyramid)
  testServer(mod_indicator_comp_server, {
    session$setInputs(indicators = c("unemployment", "youth_unemployment"), country = "EL")
    expect_no_error(output$plot)
  })
  testServer(mod_pyramid_server, {
    session$setInputs(country = "EL")
    expect_no_error(output$plot)
  })
  testServer(mod_change_server, {
    session$setInputs(country = "EL", year1 = "2015", year2 = "2024", rates = FALSE, sign = FALSE)
    expect_match(output$summary, "indicators increased and .* of them percentages")
    expect_no_error(output$increased)
    expect_no_error(output$percentages_increased)
    session$setInputs(year2 = "2015")
    expect_error(output$summary, "two different years")
  })
  expect_match(as.character(mod_about_ui("about")), "Eurostat")
})

test_that("the indicators that the tabs show at first are in the catalogue", {
  # some are generated indicators: one that a rebuild of the catalogue left out would leave its tab
  # with nothing picked
  picked <- character(0)
  local_mocked_bindings(fill_indicators = function(session, input_id, selected, level = "country") {
    picked <<- c(picked, selected)
  })
  for (server in list(mod_country_comp_server, mod_indicator_comp_server, mod_bar_server, mod_scatter_server, mod_map_server, mod_regions_server)) {
    testServer(server, {})
  }
  expect_length(picked, 8)
  expect_true(all(picked %in% indicators()$id))
})

test_that("the tabs of one country say when Eurostat cannot be reached", {
  local_mocked_bindings(get_indicator = function(id) NULL, get_pyramid = function(country) NULL)
  testServer(mod_indicator_comp_server, {
    session$setInputs(indicators = "unemployment", country = "EL")
    expect_error(output$plot, "Eurostat cannot be reached")
  })
  testServer(mod_pyramid_server, {
    session$setInputs(country = "EL")
    expect_error(output$plot, "Eurostat cannot be reached")
  })
})

test_that("the select boxes offer only the countries with values of the indicators, and keep those set aside", {
  indicator_of <- function(geo) {
    known <- countries()[match(geo, countries()$code), ]
    data.frame(geo = geo, country = known$name, group = known$group, year = 2024L, value = seq_along(geo))
  }
  # Ukraine and the EU-27 without homicides, and youth unemployment for Bulgaria only
  data <- list(
    unemployment = indicator_of(c("EL", "BG", "UA", eu_average)),
    homicides = indicator_of(c("EL", "BG")),
    youth_unemployment = indicator_of("BG")
  )
  local_mocked_bindings(get_indicator = function(id) data[[id]])
  # what the select box of the countries is sent; the browser shows it, and sends it back
  sent <- NULL
  local_mocked_bindings(updateSelectizeInput = function(session, inputId, choices = NULL, selected = NULL, ...) {
    if (inputId %in% c("countries", "country")) sent <<- list(choices = choices, selected = selected)
  })
  testServer(mod_country_comp_server, {
    session$setInputs(indicator = "unemployment", countries = c("EL", "BG"))
    expect_equal(names(sent$choices), c("Bulgaria", "Greece", "Ukraine"))
    session$setInputs(countries = c("EL", "BG", "UA"))
    expect_equal(countries(), c("EL", "BG", "UA"))
    # Ukraine leaves the select box and the chart, but is not forgotten
    session$setInputs(indicator = "homicides")
    expect_equal(names(sent$choices), c("Bulgaria", "Greece"))
    expect_equal(sent$selected, c("EL", "BG"))
    session$setInputs(countries = sent$selected)
    expect_equal(countries(), c("EL", "BG"))
    # a country taken out by the user is
    session$setInputs(countries = "EL")
    session$setInputs(indicator = "unemployment")
    expect_equal(sent$selected, c("EL", "UA"))
    expect_equal(countries(), c("EL", "UA"))
    expect_match(output$plot, "Ukraine", fixed = TRUE)
    expect_no_match(output$plot, "Bulgaria", fixed = TRUE)
    session$setInputs(countries = character(0))
    expect_error(output$plot, "Pick one or more countries")
  })
  testServer(mod_indicator_comp_server, {
    session$setInputs(indicators = c("homicides", "unemployment"), country = "EL")
    expect_equal(names(sent$choices), c("EU-27", "Bulgaria", "Greece", "Ukraine"))
    session$setInputs(country = "UA")
    # without unemployment, the country the tab opens with, until Ukraine has values again
    session$setInputs(indicators = "homicides")
    expect_equal(sent$selected, "EL")
    session$setInputs(country = sent$selected)
    expect_equal(country(), "EL")
    session$setInputs(indicators = c("homicides", "unemployment"))
    expect_equal(sent$selected, "UA")
    expect_equal(country(), "UA")
  })
  testServer(mod_bar_server, {
    session$setInputs(indicator = "homicides", country = "EL", top_n = "30")
    expect_equal(names(sent$choices), c("Bulgaria", "Greece"))
    # without values for Greece either, the first country with values
    session$setInputs(indicator = "youth_unemployment")
    expect_equal(sent$selected, "BG")
    expect_equal(country(), "BG")
  })
})
