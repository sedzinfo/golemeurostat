##########################################################################################
# THE VALUES SAVED IN THE PACKAGE
##########################################################################################
# Writes inst/extdata/values.rds: every value of every indicator of the countries in
# indicators(), hand-written and generated, for the countries of the app and the EU-27, as
# the app tidies them (tidy_countries(), which also leaves out the errors of units). The
# Change (%) tab compares all the indicators of a country between two years, which needs
# them all at once; the other tabs download the indicator they show from Eurostat.
#
# Then, for the examples of the charts and to work offline, as saved_indicator() does with
# values.rds: inst/extdata/regions.rds, every value of every indicator of the regions, with
# the names of the regions (saved_regional()), and inst/extdata/pyramids.rds, the population
# by sex and five-year age group of every country and the EU-27 (saved_pyramid()). Last, the
# outlines of the countries of the Map tab, in inst/app/www.
#
# The values of inst/extdata/errors.csv, plainly wrong in the data of Eurostat, are left out,
# as the app leaves them out of its downloads.
#
# build_indicators.R runs it at its end, after writing the catalogue; it can also be run
# alone, from the package folder:
#   source("data-raw/build_values.R")
# The generated indicators come from the tables build_indicators.R keeps in data-raw/cache;
# the hand-written ones are downloaded, and kept there for a week too.
#
# The functions come first, documented as those of R/ are (#' blocks, with examples), for
# reading: roxygen2 reads only R/, so they have no help pages. The data wrangling follows,
# in the order it runs. The functions use its settings (such as cache and max_age_days),
# so their examples run once those are set.
##########################################################################################
# THE FUNCTIONS
##########################################################################################
#' @title A file of the cache, if it is there and young enough
#' @description Whether a download kept in data-raw/cache can be used again: the file exists
#' and is younger than `max_age_days` days. The same as in build_indicators.R, so that this
#' script runs alone too.
#' @param path The file, such as `file.path(cache, "series", "pyramids.rds")`.
#' @return `TRUE` or `FALSE`.
#' @examples
#' fresh(file.path(cache, "series", "pyramids.rds"))  # TRUE within a week of a run
#' fresh("no/such/file")                              # FALSE
fresh <- function(path) {
  file.exists(path) && difftime(Sys.time(), file.mtime(path), units = "days") < max_age_days
}
##########################################################################################
#
##########################################################################################
#' @title A download, from the cache when it is fresh
#' @description Reads `path` when it is fresh (see `fresh()`); otherwise calls `get` and saves
#' what it returns there, for the next runs. A failed download, `NULL`, is not saved, so the
#' next run tries again. The same as in build_indicators.R, so that this script runs alone too.
#' @param path The .rds file of the cache, such as `file.path(cache, "series", "pyramids.rds")`.
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
#' @title The rows of an indicator, as get_eurostat() gives them
#' @description A generated indicator comes from its table, which build_indicators.R downloaded
#' whole into data-raw/cache/tables: the rows of its filters, yearly. A hand-written one, or a
#' generated one whose table is not in the cache, is downloaded with its filters
#' (`fetch_eurostat()`), and kept in data-raw/cache/series for `max_age_days` days.
#' @param info An indicator, a row of `indicators()`, with at least its `id`, `dataset`,
#'   `filters` and `generated`.
#' @return A data frame, one row per value, with the year in `time`; `NULL`, with a message,
#'   when the download fails.
#' @examples
#' info <- indicator_info("unemployment")  # hand-written: une_rt_a, sex=T;age=Y15-74;unit=PC_ACT
#' info[c("id", "dataset", "filters", "generated")]
#' \dontrun{
#' # downloads it the first time; then it reads data-raw/cache/series/unemployment.rds
#' head(raw_series(info))
#' }
raw_series <- function(info) {
  filters <- parse_filters(info$filters)
  table <- file.path(cache, "tables", paste0(info$dataset, ".rds"))
  if (info$generated && file.exists(table)) {
    raw <- readRDS(table)
    names(raw)[names(raw) == "TIME_PERIOD"] <- "time"
    for (dim in names(filters)) {
      if (dim %in% names(raw)) raw <- raw[raw[[dim]] %in% filters[[dim]], ]
    }
    if ("freq" %in% names(raw)) raw <- raw[raw$freq == "A", ]
    return(raw[grepl("^[0-9]{4}$", raw$time), ])
  }
  cached_rds(file.path(cache, "series", paste0(info$id, ".rds")), function() {
    tryCatch(as.data.frame(fetch_eurostat(info$dataset, filters)), error = function(e) {
      message("Could not download ", info$id, ": ", conditionMessage(e))
      NULL
    })
  })
}
##########################################################################################
#
##########################################################################################
#' @title A file of GISCO, the geographic service of Eurostat, from the cache when it is fresh
#' @description Downloads https://gisco-services.ec.europa.eu/distribution/v2/ followed by `file`
#' into data-raw/cache/outlines (again when it is older than `max_age_days` days), and reads it.
#' @param file The file, under distribution/v2, such as
#'   `paste0("nuts/geojson/", nuts_file_name(0))` (the outlines of the countries, NUTS 2024).
#' @return The GeoJSON, as a list (`jsonlite::read_json()`).
#' @examples
#' \dontrun{
#' # needs the internet the first time, and the folder data-raw/cache/outlines
#' nuts <- gisco(paste0("nuts/geojson/", nuts_file_name(0)))
#' length(nuts$features)
#' }
gisco <- function(file) {
  path <- file.path(cache, "outlines", basename(file))
  if (!fresh(path)) utils::download.file(paste0("https://gisco-services.ec.europa.eu/distribution/v2/", file), path, quiet = TRUE, mode = "wb")
  jsonlite::read_json(path)
}
##########################################################################################
# THE DATA WRANGLING, in the order it runs
##########################################################################################
# THE SETTINGS
##########################################################################################
max_age_days <- 7
pkgload::load_all(quiet = TRUE)
cache <- file.path("data-raw", "cache")
dir.create(file.path(cache, "series"), recursive = TRUE, showWarnings = FALSE)
output <- file.path("inst", "extdata", "values.rds")
##########################################################################################
# The values of the indicators of the countries, as the app tidies them (tidy_countries())
##########################################################################################
table <- indicators()
table <- table[table$level == "country", ]
message("Collecting the values of ", nrow(table), " indicators")
values <- lapply(seq_len(nrow(table)), function(i) {
  info <- table[i, ]
  if (i %% 200 == 0) message(i, " of ", nrow(table))
  raw <- raw_series(info)
  if (is.null(raw) || nrow(raw) == 0) {
    return(NULL)
  }
  data <- suppressMessages(tidy_countries(raw, info$id))
  if (anyDuplicated(data[c("geo", "year")]) > 0) {
    message("Left out ", info$id, ": more than one value for a country and year")
    return(NULL)
  }
  if (nrow(data) == 0) NULL else data.frame(id = info$id, geo = data$geo, year = data$year, value = data$value)
})
values <- do.call(rbind, values)
values$id <- factor(values$id, levels = table$id)
values$geo <- factor(values$geo)
values <- values[order(values$id, values$geo, values$year), ]
rownames(values) <- NULL
attr(values, "built") <- Sys.Date()
# version 2, which R older than 3.5 reads too, as R CMD build asks of the files of a package
saveRDS(values, output, compress = "xz", version = 2)
message(
  "Wrote ", nrow(values), " values of ", length(unique(values$id)), " indicators to ", output,
  " (", round(file.size(output) / 1024^2, 1), " MB)"
)
##########################################################################################
# The values of the indicators of the regions, as the app tidies them (tidy_regions()), with
# the names of the regions, from the outlines of the map
##########################################################################################
output <- file.path("inst", "extdata", "regions.rds")
region_names <- nuts_names(2)
if (is.null(region_names)) stop("The outlines of the regions cannot be downloaded from GISCO")
table <- indicators()
table <- table[table$level == "region", ]
message("Collecting the values of ", nrow(table), " indicators of the regions")
regional <- lapply(seq_len(nrow(table)), function(i) {
  info <- table[i, ]
  raw <- raw_series(info)
  if (is.null(raw) || nrow(raw) == 0) {
    return(NULL)
  }
  data <- suppressMessages(tidy_regions(raw, region_names, info$id))
  if (anyDuplicated(data[c("geo", "year")]) > 0) {
    message("Left out ", info$id, ": more than one value for a region and year")
    return(NULL)
  }
  if (nrow(data) == 0) NULL else data.frame(id = info$id, geo = data$geo, year = data$year, value = data$value)
})
regional <- do.call(rbind, regional)
regional$id <- factor(regional$id, levels = table$id)
regional$geo <- factor(regional$geo)
regional <- regional[order(regional$id, regional$geo, regional$year), ]
rownames(regional) <- NULL
attr(regional, "regions") <- region_names[levels(regional$geo)]
attr(regional, "built") <- Sys.Date()
saveRDS(regional, output, compress = "xz", version = 2)
message(
  "Wrote ", nrow(regional), " values of ", length(unique(regional$id)), " indicators to ", output,
  " (", round(file.size(output) / 1024^2, 1), " MB)"
)
##########################################################################################
# The population pyramids: the population on 1 January by sex and five-year age group,
# as Eurostat counts it (demo_pjangroup), which tidy_pyramid() turns into shares, as for
# get_pyramid(); the counts take a third of the room of the shares
##########################################################################################
output <- file.path("inst", "extdata", "pyramids.rds")
raw <- cached_rds(file.path(cache, "series", "pyramids.rds"), function() {
  as.data.frame(fetch_eurostat("demo_pjangroup", list(sex = c("M", "F"), age = pyramid_ages, unit = "NR")))
})
raw <- raw[!is.na(raw$values) & raw$geo %in% countries()$code, ]
pyramids <- data.frame(
  geo = factor(raw$geo),
  sex = factor(raw$sex),
  age = factor(raw$age, levels = pyramid_ages),
  time = as.integer(raw$time),
  values = as.integer(raw$values)
)
pyramids <- pyramids[order(pyramids$geo, pyramids$time, pyramids$sex, pyramids$age), ]
rownames(pyramids) <- NULL
attr(pyramids, "built") <- Sys.Date()
saveRDS(pyramids, output, compress = "xz", version = 2)
message(
  "Wrote the population pyramids of ", length(unique(pyramids$geo)), " countries to ", output,
  " (", round(file.size(output) / 1024^2, 1), " MB)"
)
##########################################################################################
# The outlines of the countries for the Map tab: GISCO's outlines of the NUTS 2024 classification
# at level 0, with those of the countries of the app that it leaves out, Moldova and Georgia, from
# GISCO's outlines of the countries at the same scale, 1:20 million (add_outlines(), gisco()). The
# app serves them from inst/app/www; the regions are downloaded by the app itself (nuts_file(2)).
##########################################################################################
output <- file.path("inst", "app", "www", country_outlines)
dir.create(file.path(cache, "outlines"), recursive = TRUE, showWarnings = FALSE)
nuts <- gisco(paste0("nuts/geojson/", nuts_file_name(0)))
outlined <- vapply(nuts$features, function(f) f$properties$NUTS_ID, "")
missing <- setdiff(countries()$code, c(outlined, eu_average))
extra <- lapply(missing, function(code) gisco(sprintf("countries/distribution/%s-region-20m-4326-2024.geojson", code)))
jsonlite::write_json(add_outlines(nuts, extra), output, auto_unbox = TRUE, digits = NA, null = "null")
message(
  "Wrote ", length(outlined) + length(missing), " outlines, those of ", paste(missing, collapse = " and "),
  " from GISCO's countries, to ", output, " (", round(file.size(output) / 1024^2, 1), " MB)"
)
