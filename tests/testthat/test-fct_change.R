# values of Greece in two years: an increase and a decrease, a rate of change, a change of sign and
# a starting value of 0, and percentages (% of GDP, % of the labour force) that fall, start at 0 and
# change sign
change_values <- data.frame(
  id = rep(c("gdp_eur", "net_earnings", "gdp_growth", "net_migration", "homicides", "unemployment", "rd_spending", "gov_balance"), each = 2),
  geo = "EL",
  year = rep(c(2023L, 2024L), 8),
  value = c(20000, 21000, 20000, 19000, 1, 2, -1, 2, 0, 1, 11.1, 10.1, 0, 0.5, -1, 1)
)

test_that("indicator_change() splits the indicators that rose and fell, the largest change first", {
  res <- indicator_change("EL", 2023, 2024, values = change_values)
  expect_equal(names(res$increased), c("Indicator", "Unit", "2023", "2024", "Change", "Change %"))
  expect_equal(res$increased$Indicator, indicator_info("gdp_eur")$name)
  expect_equal(res$increased$`Change %`, 5)
  expect_equal(res$decreased$Indicator, indicator_info("net_earnings")$name)
  expect_equal(res$decreased$`Change %`, -5)
  expect_equal(res$zero_base, indicator_info("homicides")$name)
  expect_equal(res$sign_change, indicator_info("net_migration")$name)
})

test_that("indicator_change() gives the percentages by their change in percentage points, also from 0 and across 0", {
  res <- indicator_change("EL", 2023, 2024, values = change_values)
  expect_equal(names(res$percentages_increased), c("Indicator", "Unit", "2023", "2024", "Change"))
  expect_equal(res$percentages_increased$Indicator, c(indicator_info("gov_balance")$name, indicator_info("rd_spending")$name))
  expect_equal(res$percentages_increased$Change, c(2, 0.5))
  expect_equal(res$percentages_decreased$Indicator, indicator_info("unemployment")$name)
  expect_equal(res$percentages_decreased$Change, -1)
  expect_equal(
    is_percentage(c("% of GDP", "Percentage point", "Percentual share of total current health expenditure (CHE)", "Per 1,000 inhabitants", "EUR per year", "Index, EU-27 = 100")),
    c(TRUE, TRUE, TRUE, FALSE, FALSE, FALSE)
  )
  # without a unit, by the name
  expect_equal(is_percentage(c("", "", "Number"), c("Outward FDI stocks in % of GDP", "Holdings", "Share (%)")), c(TRUE, FALSE, FALSE))
})

test_that("indicator_change() keeps the rates of change and the changes of sign when asked", {
  res <- indicator_change("EL", 2023, 2024, include_rates = TRUE, include_sign_change = TRUE, values = change_values)
  # a rate of change in % is a percentage
  expect_true(indicator_info("gdp_growth")$name %in% res$percentages_increased$Indicator)
  expect_true(indicator_info("net_migration")$name %in% res$increased$Indicator)
})

test_that("indicator_change() says when the country has no values in the two years", {
  expect_error(indicator_change("BG", 2023, 2024, values = change_values), "No values for BG")
})

test_that("the Change (%) tab compares the latest year with most values and the year before", {
  values <- data.frame(id = "x", geo = "EL", year = rep(c(2022L, 2023L, 2024L), c(10, 10, 2)), value = 1)
  expect_equal(change_years(values)[c("from", "to")], list(from = "2022", to = "2023"))
  expect_equal(change_years(values)$years, c("2024", "2023", "2022"))
})

test_that("the package has the values of every indicator of the countries, from one day", {
  values <- all_values()
  expect_s3_class(attr(values, "built"), "Date")
  expect_true(all(levels(values$id) %in% indicators()$id[indicators()$level == "country"]))
  expect_equal(anyDuplicated(values[c("id", "geo", "year")]), 0)
})

test_that("render_change_table() gives a DataTable", {
  res <- indicator_change("EL", 2023, 2024, values = change_values)
  expect_s3_class(render_change_table(res$increased), "datatables")
  expect_s3_class(render_change_table(res$percentages_increased), "datatables")
})
