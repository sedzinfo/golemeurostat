##########################################################################################
# THE GENERATED CATALOGUE OF INDICATORS
##########################################################################################
# Writes inst/extdata/indicators_generated.csv: the indicators of the app beyond the
# hand-written ones of inst/extdata/indicators.csv, taken from the main tables of Eurostat,
# its own selection of headline indicators with few breakdowns (codes such as tps00001,
# tec00115 or sdg_08_10).
#
# For each main table with yearly data, the script downloads the table once and keeps each
# combination of its dimensions (other than the country or region and the year), a series,
# that has values for enough countries or regions and recent years. Each series kept is a
# row, with the same columns as indicators.csv, so the app reads both files the same way.
# The names come from the titles of the tables and the labels of the codes, and the units from
# the labels of the units; data-raw/corrections.csv corrects those that do not describe their
# series, such as a unit of "Percentage" for amounts, and gives the units that Eurostat leaves out.
#
# Run it from the package folder, with internet, now and then, as Eurostat adds, renames
# and retires tables:
#   source("data-raw/build_indicators.R")
# The first run downloads about 680 tables and takes about 10 minutes. The downloads are kept
# in data-raw/cache, which git ignores, for a week, so a second run is quick; delete the
# folder to download everything again. At its end, it runs build_values.R, which writes the
# values of the indicators for the Change (%) tab, inst/extdata/values.rds.
#
# The functions come first, documented as those of R/ are (#' blocks, with examples), for
# reading: roxygen2 reads only R/, so they have no help pages. The data wrangling follows,
# in the order it runs. The functions use its settings (such as cache and min_last_year),
# so their examples run once those are set.
##########################################################################################
# THE FUNCTIONS
##########################################################################################
#' @title A file of the cache, if it is there and young enough
#' @description Whether a download kept in data-raw/cache can be used again: the file exists
#' and is younger than `max_age_days` days.
#' @param path The file, such as `file.path(cache, "toc.txt")`.
#' @return `TRUE` or `FALSE`.
#' @examples
#' fresh(file.path(cache, "toc.txt"))  # TRUE within a week of a run
#' fresh("no/such/file")               # FALSE
fresh <- function(path) {
  file.exists(path) && difftime(Sys.time(), file.mtime(path), units = "days") < max_age_days
}
##########################################################################################
#
##########################################################################################
#' @title A download, from the cache when it is fresh
#' @description Reads `path` when it is fresh (see `fresh()`); otherwise calls `get` and saves
#' what it returns there, for the next runs. A failed download, `NULL`, is not saved, so the
#' next run tries again.
#' @param path The .rds file of the cache, such as `file.path(cache, "tables", "tps00001.rds")`.
#' @param get A function without arguments that downloads the value, and returns `NULL` when
#'   the download fails.
#' @return The value, from the cache or from `get()`.
#' @examples
#' example_file <- file.path(tempdir(), "example.rds")
#' cached_rds(example_file, function() data.frame(year = 2024, value = 1.5))  # gets and saves it
#' cached_rds(example_file, function() stop("not called"))                  # reads the cache
#' cached_rds(file.path(tempdir(), "failed.rds"), function() NULL)          # NULL, nothing saved
cached_rds <- function(path, get) {
  if (fresh(path)) {
    return(readRDS(path))
  }
  value <- get()
  if (!is.null(value)) saveRDS(value, path)
  value
}
##########################################################################################
#
##########################################################################################
#' @title A main table of Eurostat, downloaded once, whole
#' @description With `eurostat::get_eurostat()`: all its countries, years and series, with the
#' years as Eurostat writes them ("2024"). Kept in data-raw/cache/tables for `max_age_days`
#' days (see `cached_rds()`).
#' @param code The code of the table, such as "tps00001" (the population on 1 January).
#' @return A data frame, one row per value: a column per dimension (such as `freq`, `unit` and
#'   `geo`), the year (`TIME_PERIOD`) and `values`; `NULL`, with a message, when the download
#'   fails.
#' @examples
#' \dontrun{
#' # needs the internet the first time; then it reads data-raw/cache/tables/tps00001.rds
#' population <- download_table("tps00001")
#' head(population)
#' }
download_table <- function(code) {
  cached_rds(file.path(cache, "tables", paste0(code, ".rds")), function() {
    tryCatch(
      as.data.frame(suppressMessages(eurostat::get_eurostat(code, time_format = "raw", cache = FALSE))),
      error = function(e) {
        message("Could not download ", code, ": ", conditionMessage(e))
        NULL
      }
    )
  })
}
##########################################################################################
#
##########################################################################################
#' @title The series of a table worth a row, for the countries or the regions
#' @description A series is a combination of the codes of the dimensions of a table other
#' than the country or region and the year, such as unit=PC_ACT. It is kept when it has values
#' for at least `least` of `areas`, and a value in `min_last_year` or later. A table with more
#' than `max_series` such series is left out, as its rows would crowd the lists of the app.
#' @param raw The table, as `get_eurostat()` gives it, with the year in `time` (THE TABLES,
#'   below, renames `TIME_PERIOD` and keeps the yearly rows with values).
#' @param areas The codes of the countries, or of the regions, such as `c("EL", "IT")`.
#' @param least How many of `areas` a series needs values for.
#' @return The codes of the dimensions of each series kept, one row per series, or `NULL` when
#'   there is none or more than `max_series`.
#' @examples
#' toy <- data.frame(
#'   freq = "A", unit = rep(c("PC", "NR"), each = 4), geo = c("EL", "IT"),
#'   time = rep(c("2023", "2024"), each = 2), values = 1:8
#' )
#' series_of(toy, c("EL", "IT", "FR"), least = 2)  # both units, two series
#' series_of(toy, c("EL", "IT", "FR"), least = 3)  # NULL: no unit has three countries
series_of <- function(raw, areas, least) {
  dims <- setdiff(names(raw), c("freq", "geo", "time", "values"))
  raw <- raw[raw$geo %in% areas, ]
  if (nrow(raw) == 0) {
    return(NULL)
  }
  key <- if (length(dims) > 0) do.call(paste, c(raw[dims], sep = "\r")) else rep("", nrow(raw))
  count <- tapply(raw$geo, key, function(g) length(unique(g)))
  last <- tapply(as.integer(raw$time), key, max)
  kept <- names(count)[count >= least & last >= min_last_year]
  if (length(kept) == 0 || length(kept) > max_series) {
    return(NULL)
  }
  unique(raw[key %in% kept, dims, drop = FALSE])
}
##########################################################################################
#
##########################################################################################
#' @title The label of a code of a dimension
#' @description From the labels Eurostat gives the codes of each dimension (`labels`, read in
#' THE LABELS, below).
#' @param dim The dimension, such as "unit".
#' @param code The codes, one or more, such as "PC_ACT".
#' @return The labels, such as "Percentage of population in the labour force"; the code itself
#'   where Eurostat has no label for it.
#' @examples
#' label_of("unit", c("PC_ACT", "NO_SUCH_CODE"))
label_of <- function(dim, code) {
  label <- unname(labels[[dim]][code])
  ifelse(is.na(label), code, label)
}
##########################################################################################
#
##########################################################################################
#' @title The correction of a series, if data-raw/corrections.csv has one
#' @description The first row of corrections.csv (`corrections`, read in THE CORRECTIONS,
#' below) for the table whose `filter` matches the codes of the series (such as "unit=RT"; an
#' empty filter is for every series of the table). The row is marked in `used`, so that the
#' end of the script can list the corrections that no series takes any more.
#' @param table The code of the table, such as "sdg_10_10".
#' @param codes The codes of the dimensions of the series, named by dimension.
#' @return The row of corrections.csv (`table`, `filter`, `unit`, `name`, `definition` and
#'   `reason`), or `NULL` when it has none for this series.
#' @examples
#' # one series of sdg_10_10 is labelled Percentage, but its values are amounts in PPS
#' correction_of("sdg_10_10", c(freq = "A", indic_ppp = "EXP_PPS_EU27_2020_HAB"))$unit
#' correction_of("sdg_10_10", c(freq = "A", indic_ppp = "OTHER"))  # NULL
correction_of <- function(table, codes) {
  for (k in which(corrections$table == table)) {
    wanted <- if (nzchar(corrections$filter[k])) parse_filters(corrections$filter[k]) else list()
    if (all(vapply(names(wanted), function(d) identical(unname(codes[d]), wanted[[d]]), TRUE))) {
      used[k] <<- TRUE
      return(corrections[k, ])
    }
  }
  NULL
}
##########################################################################################
# THE DATA WRANGLING, in the order it runs
##########################################################################################
# THE SETTINGS
##########################################################################################
# a table with more series than this is left out: its rows would crowd the lists of the app
max_series <- 10
# a series needs values for at least this many countries of the app (not counting the EU-27)
min_countries <- 10
# or, for the Regions tab, this many regions of the map (NUTS 2024, level 2)
min_regions <- 50
# and a value in this year or later
min_last_year <- 2015
# downloads older than this many days are downloaded again
max_age_days <- 7
# the codes of the units and currencies of amounts in national currency, such as MIO_NAC
# (million units of national currency) or CP_MNAC (current prices, million units of national
# currency), whose series are left out
national_currency <- "^((MIO|THS|BN)_)?NAC(_HAB)?$|^(CP|PYP|CLV[0-9]+)_MNAC$"
##########################################################################################
# the package's own countries() and nuts_names(), so that a row is kept by the same rules
# as the app uses to draw it
pkgload::load_all(quiet = TRUE)
cache <- file.path("data-raw", "cache")
dir.create(file.path(cache, "tables"), recursive = TRUE, showWarnings = FALSE)
dir.create(file.path(cache, "labels"), recursive = TRUE, showWarnings = FALSE)
output <- file.path("inst", "extdata", "indicators_generated.csv")
##########################################################################################
# THE TABLE OF CONTENTS: the main tables, with their titles and topics
##########################################################################################
toc_file <- file.path(cache, "toc.txt")
if (!fresh(toc_file)) {
  utils::download.file("https://ec.europa.eu/eurostat/api/dissemination/catalogue/toc/txt?lang=en", toc_file, quiet = TRUE, mode = "wb")
}
toc <- utils::read.delim(toc_file, quote = "\"", stringsAsFactors = FALSE, check.names = FALSE, encoding = "UTF-8", colClasses = "character")
names(toc) <- trimws(names(toc))
toc[] <- lapply(toc, function(x) sub("\\s+$", "", x))
# the titles are indented by four spaces a level: the root ("Database by themes"), the theme
# ("Economy and finance"), then the topic ("Prices"), which becomes the group of the indicator
# in the lists of the app
depth <- (nchar(toc$title) - nchar(sub("^ +", "", toc$title))) %/% 4
toc$title <- trimws(toc$title)
path <- character(0)
toc$root <- toc$theme <- toc$topic <- NA_character_
for (i in seq_len(nrow(toc))) {
  path <- c(path[seq_len(depth[i])], toc$title[i])
  toc$root[i] <- path[1]
  toc$theme[i] <- if (depth[i] >= 2) path[2] else NA
  # a table right under a theme takes the theme as its topic
  toc$topic[i] <- if (depth[i] >= 3) path[3] else toc$theme[i]
}
tables <- toc[toc$type == "table" & grepl("^[0-9]{4}$", toc$`data end`) & !is.na(toc$topic), ]
tables <- tables[as.integer(tables$`data end`) >= min_last_year, ]
# a table sits in several folders; its topic is that of its place among the themes, before the
# general statistics and the cross-cutting topics, which repeat tables of the themes
tables$rank <- ifelse(tables$root == "Database by themes" & tables$theme != "General and regional statistics", 1, 2)
tables <- tables[order(tables$rank, seq_len(nrow(tables))), ]
tables <- tables[!duplicated(tables$code), ]
message(nrow(tables), " main tables with yearly data up to ", min_last_year, " or later")
##########################################################################################
# THE METABASE: the dimensions and codes of every dataset, to leave out, before downloading,
# the tables without the countries or with far too many series
##########################################################################################
metabase_file <- file.path(cache, "metabase.txt.gz")
if (!fresh(metabase_file)) {
  utils::download.file("https://ec.europa.eu/eurostat/api/dissemination/catalogue/metabase.txt.gz", metabase_file, quiet = TRUE, mode = "wb")
}
metabase <- utils::read.delim(gzfile(metabase_file), header = FALSE, col.names = c("dataset", "dim", "code"), quote = "", colClasses = "character")
metabase <- metabase[metabase$dataset %in% tables$code, ]
known <- countries()
country_codes <- known$code[known$code != eu_average]
region_names <- nuts_names(2)
candidate <- vapply(split(metabase, metabase$dataset), function(d) {
  geo <- d$code[d$dim == "geo"]
  other <- d[!d$dim %in% c("geo", "time", "freq"), ]
  # the metabase lists the codes of each dimension, not the combinations with data, so a
  # table is downloaded when it may have up to five times max_series
  combinations <- if (nrow(other) > 0) prod(table(other$dim)) else 1
  (sum(geo %in% country_codes) >= min_countries || sum(geo %in% names(region_names)) >= min_regions) &&
    combinations <= 5 * max_series
}, TRUE)
tables <- tables[tables$code %in% names(candidate)[candidate], ]
message(nrow(tables), " of them with the countries or regions and few enough series: downloading them")
##########################################################################################
# THE TABLES: each downloaded once, whole (download_table()), and the series of each that
# are worth a row (series_of())
##########################################################################################
found <- list()
for (i in seq_len(nrow(tables))) {
  code <- tables$code[i]
  if (i %% 50 == 0) message(i, " of ", nrow(tables), " tables")
  raw <- download_table(code)
  if (is.null(raw)) next
  names(raw)[names(raw) == "TIME_PERIOD"] <- "time"
  has_freq <- "freq" %in% names(raw)
  if (has_freq) raw <- raw[raw$freq == "A", ]
  raw <- raw[grepl("^[0-9]{4}$", raw$time) & !is.na(raw$values), ]
  # amounts in national currency, million forint next to million euro, cannot be compared
  # between countries; indices and rates of change based on them can, and are kept
  for (dim in intersect(c("unit", "currency"), names(raw))) {
    raw <- raw[!grepl(national_currency, raw[[dim]]), ]
  }
  for (level in c("country", "region")) {
    series <- if (level == "country") series_of(raw, country_codes, min_countries) else series_of(raw, names(region_names), min_regions)
    if (!is.null(series)) {
      found[[length(found) + 1]] <- list(code = code, level = level, series = series, has_freq = has_freq)
    }
  }
}
message(length(found), " tables with series to keep (a table may count twice, for the countries and the regions)")
##########################################################################################
# THE LABELS of the codes, such as "Percentage of population in the labour force" for PC_ACT
##########################################################################################
dims <- unique(unlist(lapply(found, function(f) names(f$series))))
labels <- lapply(stats::setNames(dims, dims), function(dim) {
  dic <- cached_rds(file.path(cache, "labels", paste0(dim, ".rds")), function() {
    tryCatch(as.data.frame(suppressMessages(eurostat::get_eurostat_dic(dim, lang = "en"))), error = function(e) {
      message("No labels for the codes of ", dim, ": ", conditionMessage(e))
      NULL
    })
  })
  if (is.null(dic)) character(0) else stats::setNames(dic$full_name, dic$code_name)
})
##########################################################################################
# THE CORRECTIONS of the labels of Eurostat that do not describe their series, or leave out their
# unit: data-raw/corrections.csv, one row for the series of a table (`table`), or for those of
# them with the codes of `filter` (such as unit=RT), with the unit to show (`unit`), and the name
# and the definition when they are wrong too; `reason` says what is wrong. A unit that is a
# dimension of the table changes in the name and the definition too.
##########################################################################################
corrections <- utils::read.csv(file.path("data-raw", "corrections.csv"), stringsAsFactors = FALSE, encoding = "UTF-8", colClasses = "character", na.strings = character(0))
used <- rep(FALSE, nrow(corrections))
##########################################################################################
# THE ROWS
##########################################################################################
rows <- do.call(rbind, lapply(found, function(f) {
  info <- tables[tables$code == f$code, ]
  series <- f$series
  dims <- names(series)
  # the dimensions that tell the series of the table apart name them; the others are the same
  # for each, and only go in the definition
  open <- dims[vapply(series, function(x) length(unique(x)) > 1, TRUE)]
  do.call(rbind, lapply(seq_len(nrow(series)), function(s) {
    codes <- unlist(series[s, , drop = FALSE])
    named <- vapply(dims, function(d) label_of(d, codes[[d]]), "")
    fix <- correction_of(f$code, codes)
    corrected <- function(field) !is.null(fix) && nzchar(fix[[field]])
    unit_dim <- intersect(c("unit", "currency"), dims)[1]
    if (corrected("unit") && !is.na(unit_dim)) named[[unit_dim]] <- fix$unit
    id <- tolower(paste(c(if (f$level == "region") "r", f$code, codes[open]), collapse = "_"))
    unit <- if (corrected("unit")) fix$unit else if (!is.na(unit_dim)) named[[unit_dim]] else ""
    name <- if (length(open) > 0) paste0(info$title, ": ", paste(named[open], collapse = ", ")) else info$title
    definition <- if (length(dims) > 0) paste0(info$title, " (", paste(named, collapse = "; "), ").") else paste0(info$title, ".")
    data.frame(
      id = gsub("_+$", "", gsub("[^a-z0-9]+", "_", id)),
      level = f$level,
      topic = info$topic,
      name = if (corrected("name")) fix$name else name,
      unit = unit,
      dataset = f$code,
      # all the dimensions, fixed and open, so that a code Eurostat adds later to a table
      # cannot give a second value for a country and year
      filters = paste(c(if (f$has_freq) "freq=A", if (length(dims) > 0) paste0(dims, "=", codes)), collapse = ";"),
      definition = if (corrected("definition")) fix$definition else definition
    )
  }))
}))
# a correction no series takes any more, as Eurostat changed or retired its table, is to be removed
if (!all(used)) {
  message("Corrections that no series takes: ", paste(corrections$table[!used], corrections$filter[!used], collapse = ", "))
}
# in the order of the tables: those of the themes, in the order of the table of contents, so
# that the topics follow the themes of Eurostat, then those only among the cross-cutting topics
rows <- rows[order(match(rows$dataset, tables$code), rows$level, rows$id), ]
# a series is often in several main tables, such as healthy life years in tps00150 (Health)
# and sdg_03_11 (Sustainable development indicators), under the same name; the first is kept
repeated <- duplicated(rows[c("level", "name")])
message("Left out ", sum(repeated), " series with the name of one kept, mostly the same series in another table")
rows <- rows[!repeated, ]
# two codes can give the same id once the signs are replaced by _
rows$id <- ave(rows$id, rows$id, FUN = function(x) if (length(x) > 1) paste0(x, "_", seq_along(x)) else x)
utils::write.csv(rows, output, row.names = FALSE, fileEncoding = "UTF-8")
message(
  "Wrote ", nrow(rows), " indicators to ", output, ": ", sum(rows$level == "country"), " for the countries, ",
  sum(rows$level == "region"), " for the regions, from ", length(unique(rows$dataset)), " tables"
)
##########################################################################################
# THE VALUES of every indicator of the countries, for the Change (%) tab, from the tables
# just downloaded (see build_values.R)
##########################################################################################
source(file.path("data-raw", "build_values.R"))
