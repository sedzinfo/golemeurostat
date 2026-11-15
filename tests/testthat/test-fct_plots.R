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
  # it opens at the first year, with that year's bars, as golemworldbank
  expect_equal(built$layout$annotations[[1]]$text, "2022")
  expect_null(built$layout$sliders[[1]]$active)
  expect_equal(built$layout$sliders[[1]]$currentvalue$prefix, "Year: ")
  expect_equal(as.vector(built$data[[1]]$x), c(12.4, 4.3))
})

test_that("the bars of the race start at 0, also when the values are close", {
  # plotly fixes the axis of an animation at the span of the values, which cut off the start of
  # every bar, and the names inside the bars ran over the ranks
  data <- transform(tidy_countries(raw_unemployment), value = value + 100)
  built <- plotly::plotly_build(plot_bar(data, "unemployment", "EL"))$x
  expect_equal(built$layout$xaxis$range[1], 0)
  expect_gt(built$layout$xaxis$range[2], max(data$value[data$geo != eu_average]))
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

test_that("the indicator comparison draws a line per indicator with values for the country", {
  data <- tidy_countries(raw_unemployment)
  built <- plotly::plotly_build(plot_indicator_comp(list(unemployment = data, gdp_eur = data[0, ]), "EL", c("unemployment", "gdp_eur")))$x
  expect_length(built$data, 1)
  expect_equal(built$data[[1]]$name, "Unemployment rate (% of the labour force)")
  expect_equal(built$layout$yaxis$title$text, "% of the labour force")
  expect_equal(built$layout$title, "Country: Greece")
  expect_null(plot_indicator_comp(list(unemployment = data), "DE", "unemployment"))
})

test_that("the titles of the y axes keep clear of the tick labels, however wide", {
  # without a standoff, plotly puts the title at a set distance from the axis, and pushes it back
  # over wide labels (100) when the margin is short of it; the line charts keep it at the left edge
  # of the chart, about 12px short of the standoff
  data <- tidy_countries(raw_unemployment)
  y_axis <- function(p) plotly::plotly_build(p)$x$layout$yaxis
  standoffs <- list(
    `20` = y_axis(plot_country_comp(data, c("EL", "BG"), "unemployment")),
    `20` = y_axis(plot_indicator_comp(list(unemployment = data), "EL", "unemployment")),
    `10` = y_axis(plot_scatter(data, transform(data, value = value + 70), "unemployment", "life_expectancy"))
  )
  for (k in seq_along(standoffs)) {
    expect_equal(standoffs[[k]]$title$standoff, as.numeric(names(standoffs)[k]))
    expect_true(standoffs[[k]]$automargin)
  }
})

test_that("the pyramid draws the men to the left, opens at the first year and keeps the legend clicks", {
  data <- data.frame(
    sex = rep(c("Male", "Female"), each = 4),
    age = factor(rep(c("0-4", "5-9"), 4), levels = c("0-4", "5-9")),
    year = rep(c(2024, 2024, 2025, 2025), 2),
    value = c(48, 52, 47, 53, 49, 51, 48, 52)
  )
  built <- plotly::plotly_build(plot_pyramid(data, "EL"))$x
  expect_length(built$frames, 2)
  # as in golemworldbank
  expect_equal(built$layout$title, "Country: Greece")
  male <- built$data[[which(vapply(built$data, `[[`, "", "name") == "Male")]]
  expect_equal(as.vector(male$x), c(-48, -52))
  expect_null(built$layout$sliders[[1]]$active)
  # returned visibly, as the example and the console draw only a visible result
  expect_true(withVisible(plot_pyramid(data, "EL"))$visible)
  expect_null(built$frames[[1]]$data[[1]]$visible)
})

test_that("an animated chart of one year has no slider", {
  data <- tidy_countries(raw_unemployment)
  data <- data[data$year == 2024, ]
  expect_no_error(built <- plotly::plotly_build(plot_bar(data, "unemployment", "EL"))$x)
  expect_length(built$layout$sliders, 0)
})

test_that("the pyramid leaves out the years that jump back and forth, and names them", {
  # two age structures: one that ages slowly, and another far from it, every other year from 1961 to 1969
  steady <- function(year) c(50 - (year - 1960) * 0.1, 50 + (year - 1960) * 0.1)
  jumping <- c(1961, 1963, 1965, 1967, 1969)
  data <- do.call(rbind, lapply(1961:1975, function(year) {
    value <- if (year %in% jumping) c(65, 35) else steady(year)
    data.frame(sex = rep(c("Male", "Female"), each = 2), age = factor(c("0-4", "5-9")), year = year, value = rep(value, 2))
  }))
  expect_equal(jumping_years(data), jumping)
  built <- plotly::plotly_build(plot_pyramid(data, "EL"))$x
  expect_equal(vapply(built$frames, `[[`, "", "name"), as.character(setdiff(1961:1975, jumping)))
  expect_match(built$layout$annotations[[1]]$text, "1961, 1963, 1965, 1967, 1969", fixed = TRUE)
  # a year a decade before the next has changed by a decade's worth, and is kept
  decade <- data[data$year == 1975, ]
  decade$year <- 1965
  decade$value <- rep(c(65, 35), 2)
  expect_equal(jumping_years(rbind(decade, data[data$year >= 1975, ], transform(data[data$year == 1975, ], year = 1976))), integer(0))
})

test_that("the charts of one indicator are titled with it, as in golemworldbank", {
  data <- tidy_countries(raw_unemployment)
  title <- function(p) plotly::plotly_build(p)$x$layout$title$text
  expect_equal(title(plot_country_comp(data, c("EL", "BG"), "unemployment")), "Indicator: Unemployment rate")
  expect_equal(title(plot_map(data, "unemployment")), "Indicator: Unemployment rate")
  expect_equal(title(plot_regions(regions, "r_gdp_pps")), "Indicator: GDP per inhabitant in PPS")
})

test_that("the indicator comparison colors its lines as the country comparison its countries, in the order picked", {
  data <- tidy_countries(raw_unemployment)
  colors <- function(p) vapply(plotly::plotly_build(p)$x$data, function(t) t$line$color, "")
  two <- list(unemployment = data, youth_unemployment = transform(data, value = 2 * value))
  expect_equal(colors(plot_indicator_comp(two, "EL", names(two))), colors(plot_country_comp(data, c("EL", "BG"), "unemployment"))[1:2])
  built <- plotly::plotly_build(plot_indicator_comp(two, "EL", rev(names(two))))$x
  expect_match(built$data[[1]]$name, "^Youth unemployment rate")
  expect_equal(as.vector(built$data[[1]]$y), c(24.8, 22.2, 20.2))
})

test_that("the maps go from red for the lowest through white to dark blue for the highest, with dark borders, as in golemworldbank", {
  built <- plotly::plotly_build(plot_map(tidy_countries(raw_unemployment), "unemployment"))$x
  scale <- built$data[[1]]$colorscale
  expect_equal(c(scale[1, 2], scale[nrow(scale), 2]), c("rgba(178,24,43,1)", "rgba(8,48,107,1)"))
  middle <- scale[ceiling(nrow(scale) / 2), 2]
  middle <- as.numeric(regmatches(middle, gregexpr("[0-9]+", middle))[[1]][1:3])
  expect_true(all(middle >= 250))
  expect_equal(built$data[[1]]$marker$line$color, "#444")
  # thinner between the small regions
  expect_equal(plotly::plotly_build(plot_regions(regions, "r_gdp_pps"))$x$data[[1]]$marker$line$width, 0.5)
})

test_that("the scatter plot draws bubbles as large as the population, in plotly's colors, as golemworldbank", {
  data <- tidy_countries(raw_unemployment)
  population <- transform(data, value = ifelse(geo == "EL", 10.4e6, 6.4e6))
  expect_no_warning(
    built <- plotly::plotly_build(plot_scatter(data, transform(data, value = 2 * value), "unemployment", "life_expectancy", population))$x
  )
  names <- vapply(built$data, `[[`, "", "name")
  # Bulgaria the smallest bubble and Greece the largest, in every year
  for (frame in built$frames) {
    eu <- frame$data[[which(names == "EU")]]
    expect_equal(as.vector(eu$text), c("BG", "EL"))
    expect_equal(as.vector(eu$marker$size), c(10, 60))
    # the codes in the font of the chart, not as large as the bubbles
    expect_null(eu$textfont$size)
  }
  expect_match(built$data[[which(names == "EU")]]$hovertext[2], "Population: 10.4M", fixed = TRUE)
  expect_equal(
    vapply(built$data, function(t) t$marker$color, "")[match(c("EU", "EFTA", "Candidate"), names)],
    c("rgba(102,194,165,1)", "rgba(252,141,98,1)", "rgba(141,160,203,1)")
  )
  # without the population, bubbles all of the smallest size
  plain <- plotly::plotly_build(plot_scatter(data, transform(data, value = 2 * value), "unemployment", "life_expectancy"))$x
  expect_true(all(unlist(lapply(plain$data, function(t) t$marker$size)) == 10))
})

test_that("the population of a year between two of Eurostat's is in a straight line, and that of the nearest outside them", {
  population <- data.frame(geo = "EL", year = c(2020, 2022), value = c(100, 200))
  rows <- data.frame(geo = c("EL", "EL", "EL", "BG"), year = c(2019, 2021, 2024, 2021))
  expect_equal(population_of(rows, population), c(100, 150, 200, NA))
  expect_equal(population_of(rows, NULL), rep(NA_real_, 4))
})

test_that("the table of the indicators is one long page, as in golemworldbank, that the browser fits to the page", {
  expect_false(render_index_table()$x$options$paging)
  # autoWidth made the table creep wider than the page after it opened
  expect_false(render_index_table()$x$options$autoWidth)
})
