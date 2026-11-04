test_that("the tabs of the countries draw their charts", {
  data <- tidy_countries(raw_unemployment)
  local_mocked_bindings(get_indicator = function(id) data)
  testServer(mod_country_comp_server, {
    session$setInputs(indicator = "unemployment", countries = c("EL", "BG"))
    expect_no_error(output$plot)
  })
  testServer(mod_bar_server, {
    session$setInputs(indicator = "unemployment", country = "EL")
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
