##########################################################################################
#
##########################################################################################
#' @title The values of all the indicators
#' @description Every value of every indicator of the countries in
#' [indicators()], for the countries of the app and the EU-27, as of the day
#' `data-raw/build_values.R` wrote them into the package (the `built`
#' attribute). The Change (%) tab compares all the indicators of a country
#' between two years, which needs them all at once; the other tabs download
#' the indicator they show from Eurostat, and so have the latest values.
#' @return A data frame with `id` (the indicator), `geo` (the Eurostat code of
#'   the country), `year` and `value`, or `NULL` when the package has no
#'   values.
#' @export
#' @examples
#' values <- all_values()
#' attr(values, "built")
#' head(values)
all_values <- function() {
  saved_file("values")
}
##########################################################################################
#
##########################################################################################
#' @title The years of the Change (%) tab
#' @description The years of [all_values()], latest first, and the two compared at
#' first: the latest year with values for at least half as many indicators as
#' the year with the most, as the latest years have few, and the year before.
#' @param values Data frame of [all_values()].
#' @return A list: `years`, `from` and `to`.
#' @noRd
change_years <- function(values = all_values()) {
  if (is.null(values)) {
    return(list(years = character(0), from = NULL, to = NULL))
  }
  count <- table(values$year)
  full <- as.integer(names(count)[count >= max(count) / 2])
  to <- max(full)
  list(years = as.character(sort(unique(values$year), decreasing = TRUE)), from = as.character(to - 1), to = as.character(to))
}
##########################################################################################
#
##########################################################################################
#' @title Indicators that rose or fell between two years for one country
#' @description As in golemworldbank: compares every indicator a country has a
#' value for in both years, and splits them into two tables, those that
#' increased from `year1` to `year2` and those that decreased, each sorted by
#' percent change, the largest first. The percent change is
#' `(value2 - value1) / |value1| * 100`; it is undefined when the `year1` value
#' is 0, so those indicators are in neither table (they are in `zero_base`), nor
#' are those that did not change.
#'
#' Rates of change, whose name or unit says "change" or "growth" (such as
#' "Real GDP growth" or "Percentage change on previous period"), are left out
#' unless `include_rates = TRUE`: a percent change of a rate of change means
#' little (a rate going from 0.1 to 1.7 reads as +1,600%).
#'
#' For indicators that are percentages, such as the unemployment rate, the
#' percent change is relative to the old percentage, not a difference in
#' percentage points; the `Change` column gives the plain difference.
#' @param country Eurostat code of the country, such as "EL", or "EU27_2020".
#' @param year1,year2 The two years to compare.
#' @param include_rates Keep the rates of change.
#' @param include_sign_change Keep the indicators whose value changed sign
#'   between the two years, whose percent change means little; either way they
#'   are listed in `sign_change`.
#' @param values Data frame of [all_values()].
#' @return A list with `increased` and `decreased` (data frames with the columns
#'   `Indicator`, `Unit`, one named after each year with its value, `Change` and
#'   `Change %`), `zero_base` and `sign_change` (names of indicators). Stops
#'   with an error when the country has no values in either year.
#' @export
#' @examples
#' res <- indicator_change("EL", 2015, 2024)
#' head(res$increased)
#' head(res$decreased)
indicator_change <- function(country, year1, year2, include_rates = FALSE, include_sign_change = FALSE, values = all_values()) {
  if (is.null(values)) {
    stop("The package has no values: run data-raw/build_values.R", call. = FALSE)
  }
  values <- values[values$geo == country & values$year %in% as.integer(c(year1, year2)), ]
  if (nrow(values) == 0) {
    stop("No values for ", country, " in ", year1, " or ", year2, call. = FALSE)
  }
  v1 <- values[values$year == as.integer(year1), c("id", "value")]
  v2 <- values[values$year == as.integer(year2), c("id", "value")]
  both <- merge(v1, v2, by = "id", suffixes = c("_1", "_2"))
  both$id <- as.character(both$id)
  info <- indicators()[match(both$id, indicators()$id), ]
  both$name <- info$name
  both$unit <- info$unit
  if (!include_rates) {
    both <- both[!grepl("\\b(change|growth)\\b", paste(both$name, both$unit), ignore.case = TRUE, perl = TRUE), ]
  }
  zero_base <- both$name[both$value_1 == 0]
  both <- both[both$value_1 != 0, ]
  flipped <- sign(both$value_1) != sign(both$value_2) & both$value_2 != 0
  sign_change <- both$name[flipped]
  if (!include_sign_change) both <- both[!flipped, ]
  both$change <- both$value_2 - both$value_1
  both$pct <- both$change / abs(both$value_1) * 100
  as_table <- function(x) {
    out <- data.frame(x$name, x$unit, x$value_1, x$value_2, x$change, round(x$pct, 2), check.names = FALSE, stringsAsFactors = FALSE)
    names(out) <- c("Indicator", "Unit", as.character(year1), as.character(year2), "Change", "Change %")
    row.names(out) <- NULL
    out
  }
  increased <- both[both$pct > 0, ]
  decreased <- both[both$pct < 0, ]
  list(
    increased = as_table(increased[order(-increased$pct), ]),
    decreased = as_table(decreased[order(decreased$pct), ]),
    zero_base = zero_base,
    sign_change = sign_change
  )
}
##########################################################################################
#
##########################################################################################
#' @title One table of [indicator_change()] as a DataTable
#' @description As in golemworldbank: the values of the two years and the change
#' to 3 significant digits (6.02M, 1.42B, 0.0752), while sorting still uses the
#' full numbers, and the percent change with one decimal, in bold green for an
#' increase and red for a decrease, on one long page with compact rows (by
#' their padding: golemworldbank's line height of 80% would make the long names
#' of Eurostat's indicators, on two lines, run into each other).
#' @param tab One of the data frames of [indicator_change()], `increased` or
#'   `decreased`.
#' @return A DT table.
#' @export
#' @examples
#' render_change_table(indicator_change("EL", 2015, 2024)$increased)
render_change_table <- function(tab) {
  # display-only formatting: the cells keep their numbers, so sorting is numeric
  compact <- DT::JS(
    "function(data, type) {",
    "  if (type !== 'display' || data === null) return data;",
    "  return new Intl.NumberFormat('en', {notation: 'compact', maximumSignificantDigits: 3}).format(data);",
    "}"
  )
  result <- DT::datatable(tab,
    rownames = FALSE,
    class = "display compact",
    options = list(
      paging = FALSE,
      columnDefs = list(list(targets = 2:4, render = compact, className = "dt-right"))
    )
  )
  result <- DT::formatRound(result, "Change %", digits = 1)
  DT::formatStyle(result, "Change %", color = DT::styleInterval(0, c("#B3261E", "#1E7B34")), fontWeight = "bold")
}
