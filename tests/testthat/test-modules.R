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
    expect_match(output$summary, "indicators increased and")
    expect_no_error(output$increased)
    session$setInputs(year2 = "2015")
    expect_error(output$summary, "two different years")
  })
  expect_match(as.character(mod_about_ui("about")), "Eurostat")
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
