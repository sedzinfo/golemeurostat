test_that("every chart builds", {
  data <- tidy_countries(raw_unemployment)
  expect_no_error(plotly::plotly_build(plot_country_comp(data, c("EL", "BG"), "unemployment")))
  expect_no_error(plotly::plotly_build(plot_bar(data, "unemployment", "EL")))
  expect_no_error(plotly::plotly_build(plot_map(data, "unemployment")))
  expect_no_error(plotly::plotly_build(plot_regions(regions, "r_gdp_pps")))
  expect_no_error(plotly::plotly_build(plot_scatter(data, transform(data, value = value + 70), "unemployment", "life_expectancy")))
  expect_s3_class(render_index_table(), "datatables")
})

test_that("the bar race ranks the countries of each year, without the EU-27 average, the picked one in red", {
  built <- plotly::plotly_build(plot_bar(tidy_countries(raw_unemployment), "unemployment", "EL"))$x
  expect_length(built$frames, 3)
  bars <- built$frames[[1]]$data[[1]]
  expect_equal(as.vector(bars$y), c(1, 2))
  expect_equal(as.vector(bars$marker$color), c("#d62728", "#1f77b4"))
  # it opens at the last year, with that year's bars
  expect_equal(built$layout$annotations[[1]]$text, "2024")
  expect_equal(built$layout$sliders[[1]]$active, 2)
  expect_equal(built$layout$sliders[[1]]$currentvalue$prefix, "Year: ")
  expect_equal(as.vector(built$data[[1]]$x), c(10.1, 4.2))
})

test_that("the bar race shows the top_n largest countries of each year", {
  built <- plotly::plotly_build(plot_bar(tidy_countries(raw_unemployment), "unemployment", "EL", top_n = 1))$x
  expect_true(all(vapply(built$frames, function(f) length(f$data[[1]]$y) == 1, TRUE)))
})

test_that("the maps color the outlines (from GISCO, or served by the app), on one scale for all the years", {
  built <- plotly::plotly_build(plot_regions(regions, "r_gdp_pps"))$x
  expect_equal(built$data[[1]]$geojson, "https://gisco-services.ec.europa.eu/distribution/v2/nuts/geojson/NUTS_RG_20M_2024_4326_LEVL_2.geojson")
  expect_equal(c(built$data[[1]]$zmin, built$data[[1]]$zmax), c(57, 105))
  # inside the app, the outlines it serves
  shiny::addResourcePath("nuts", tempdir())
  expect_equal(nuts_url(2), "nuts/NUTS_RG_20M_2024_4326_LEVL_2.geojson")
  shiny::removeResourcePath("nuts")
})

test_that("the scatter plot gives the correlation of each year, and nothing without a common year", {
  data <- tidy_countries(raw_unemployment)
  built <- plotly::plotly_build(plot_scatter(data, transform(data, value = 2 * value), "unemployment", "life_expectancy"))$x
  # two countries only, too few for a correlation
  expect_equal(built$layout$annotations[[1]]$text, "")
  # each year has the three groups, in the same traces, also those without a country that year
  expect_true(all(lengths(lapply(built$frames, `[[`, "data")) == 3))
  names <- lapply(built$frames, function(f) vapply(f$data, `[[`, "", "name"))
  expect_true(all(vapply(names, identical, TRUE, names[[1]])))
  expect_null(plot_scatter(data, transform(data, year = year + 10L), "unemployment", "life_expectancy"))
})

test_that("with_unit() leaves out the brackets of an indicator without a unit", {
  expect_equal(with_unit(list(name = "Unemployment rate", unit = "%")), "Unemployment rate (%)")
  expect_equal(with_unit(list(name = "Population on 1 January", unit = "")), "Population on 1 January")
})

test_that("chart_title() wraps a long title and makes room for its lines", {
  short <- chart_title("Unemployment rate", 100)
  expect_equal(short$title$text, "Unemployment rate")
  expect_equal(short$top, 100)
  long <- chart_title(strrep("word ", 40), 100)
  expect_equal(lengths(regmatches(long$title$text, gregexpr("<br>", long$title$text))), 2)
  expect_equal(long$top, 100 + 2 * 37)
})

test_that("axis_title() puts a long name on several lines, in a smaller font", {
  info <- list(name = "Life expectancy at birth", unit = "Years")
  expect_equal(axis_title(info, 45), list(text = "Life expectancy at birth (Years)"))
  expect_equal(axis_title(info, 20), list(text = "Life expectancy at<br>birth (Years)", font = list(size = 14)))
})
