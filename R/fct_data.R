##########################################################################################
#
##########################################################################################
#' @title What the package keeps in memory
#' @description The catalogue of indicators, the names of the regions and the
#' disk cache, once read or opened.
#' @noRd
memory <- new.env(parent = emptyenv())
##########################################################################################
#
##########################################################################################
#' @title Eurostat code of the EU-27 average
#' @description The charts show it next to the countries, for comparison.
#' @export
#' @noRd
eu_average <- "EU27_2020"
##########################################################################################
#
##########################################################################################
#' @title The indicators of the app
#' @description The catalogue, one row per indicator: its `id`, whether it is
#' for countries or regions (`level`), its `topic`, `name` and `unit`, the
#' Eurostat `dataset` it comes from, the values that fix the other dimensions
#' of that dataset (`filters`, such as `sex=T;age=Y15-74`) and a short
#' `definition`.
#'
#' The rows come from two files of `inst/extdata`: `indicators.csv`, written
#' by hand, whose rows come first, and `indicators_generated.csv`, the series
#' of the main tables of Eurostat, written by `data-raw/build_indicators.R`
#' (`generated` is `TRUE` for these). A generated row with the same `id`, or
#' the same `level`, `dataset` and `filters`, as a hand-written one is left
#' out. A row added to `indicators.csv` adds an indicator to the app.
#' @return A data frame with one row per indicator.
#' @export
#' @examples
#' indicators()[, c("id", "level", "name", "unit")]
indicators <- function() {
  if (is.null(memory$indicators)) {
    read <- function(file) {
      path <- app_sys("extdata", file)
      if (!nzchar(path)) {
        return(NULL)
      }
      table <- utils::read.csv(path, stringsAsFactors = FALSE, encoding = "UTF-8", na.strings = character(0), colClasses = "character")
      table$generated <- file == "indicators_generated.csv"
      table
    }
    hand <- read("indicators.csv")
    generated <- read("indicators_generated.csv")
    if (!is.null(generated)) {
      same <- generated$id %in% hand$id | series_key(generated) %in% series_key(hand)
      hand <- rbind(hand, generated[!same, ])
    }
    rownames(hand) <- NULL
    memory$indicators <- hand
  }
  memory$indicators
}
##########################################################################################
#
##########################################################################################
#' @title What a row of the catalogue shows
#' @description The level, the dataset and its filters in one text, the same
#' whatever the order of the filters and with or without `freq=A`, to find a
#' generated row that repeats a hand-written one. A table can give a row for
#' the countries and one for the regions with the same filters; the level
#' tells them apart.
#' @param table Rows of the catalogue.
#' @noRd
series_key <- function(table) {
  vapply(seq_len(nrow(table)), function(i) {
    pairs <- setdiff(strsplit(table$filters[i], ";", fixed = TRUE)[[1]], "freq=A")
    paste(c(table$level[i], table$dataset[i], sort(pairs)), collapse = ";")
  }, "")
}
##########################################################################################
#
##########################################################################################
#' @title One indicator of the catalogue
#' @param id The `id` of the indicator in [indicators()].
#' @return The row of the indicator, an error for an unknown id.
#' @export
#' @noRd
indicator_info <- function(id) {
  table <- indicators()
  if (!id %in% table$id) {
    stop("No indicator has the id \"", id, "\", see indicators()$id", call. = FALSE)
  }
  table[table$id == id, ]
}
##########################################################################################
#
##########################################################################################
#' @title The filters of an indicator, as Eurostat takes them
#' @param text The `filters` of the catalogue, such as "sex=T;age=Y15-74".
#' @return A named list, such as `list(sex = "T", age = "Y15-74")`.
#' @noRd
parse_filters <- function(text) {
  pairs <- strsplit(strsplit(text, ";", fixed = TRUE)[[1]], "=", fixed = TRUE)
  stats::setNames(lapply(pairs, `[`, 2), vapply(pairs, `[`, "", 1))
}
##########################################################################################
#
##########################################################################################
#' @title The countries of the app
#' @description The countries of the European Union, of EFTA and the candidate
#' countries, by their Eurostat codes (Greece is EL), with their English names
#' and their group, and the EU-27 average.
#' @return A data frame with `code`, `name` and `group`.
#' @export
#' @examples
#' countries()
countries <- function() {
  groups <- list(
    EU = eurostat::eu_countries,
    EFTA = eurostat::efta_countries,
    Candidate = eurostat::eu_candidate_countries
  )
  rbind(
    do.call(rbind, lapply(names(groups), function(group) {
      data.frame(code = groups[[group]]$code, name = groups[[group]]$name, group = group)
    })),
    data.frame(code = eu_average, name = "EU-27", group = "EU-27")
  )
}
##########################################################################################
#
##########################################################################################
#' @title The folder of the downloads
#' @description Set with `options(golemeurostat.cache_dir = )`, by default the
#' cache folder of R for this package.
#' @noRd
cache_dir <- function() {
  getOption("golemeurostat.cache_dir", tools::R_user_dir("golemeurostat", which = "cache"))
}
##########################################################################################
#
##########################################################################################
#' @title The downloads kept on disk
#' @description A disk cache whose entries expire after a day, so the app asks
#' Eurostat at most once a day for each indicator, and shares the downloads
#' with every session and app run.
#' @noRd
data_cache <- function() {
  dir <- file.path(cache_dir(), "data")
  if (!identical(memory$cache_dir, dir)) {
    memory$cache <- cachem::cache_disk(dir, max_age = 24 * 60 * 60, max_size = 200 * 1024^2)
    memory$cache_dir <- dir
  }
  memory$cache
}
##########################################################################################
#
##########################################################################################
#' @title A download, from the disk cache when it is there
#' @param key Name of the download in the cache: lower case letters, digits
#'   and `_`.
#' @param download Function that downloads it, returning `NULL` when it
#'   cannot, which is not kept.
#' @noRd
cached <- function(key, download) {
  kept <- data_cache()$get(key)
  if (!cachem::is.key_missing(kept)) {
    return(kept)
  }
  value <- download()
  if (!is.null(value)) {
    data_cache()$set(key, value)
  }
  value
}
##########################################################################################
#
##########################################################################################
#' @title Ask Eurostat for a dataset
#' @description The one call of the API, shared by the app and
#' [check_indicators()].
#' @param dataset Code of the dataset, such as "une_rt_a".
#' @param filters Named list of the values of its dimensions to keep.
#' @return The data frame of [eurostat::get_eurostat()]; an error when
#'   Eurostat cannot be reached, refuses the query or has no values for it.
#' @noRd
fetch_eurostat <- function(dataset, filters) {
  suppressMessages(eurostat::get_eurostat(dataset, filters = filters, time_format = "num", cache = FALSE))
}
##########################################################################################
#
##########################################################################################
#' @title Download a dataset from Eurostat
#' @param dataset Code of the dataset, such as "une_rt_a".
#' @param filters Named list of the values of its dimensions to keep.
#' @return The data frame of [eurostat::get_eurostat()], or `NULL` with a
#'   message when Eurostat cannot be reached or refuses the query.
#' @noRd
download_eurostat <- function(dataset, filters) {
  tryCatch(
    fetch_eurostat(dataset, filters),
    error = function(e) {
      message("Could not download ", dataset, " from Eurostat: ", conditionMessage(e))
      NULL
    }
  )
}
##########################################################################################
#
##########################################################################################
#' @title Keep the countries of the app
#' @description Leaves out the other areas of a Eurostat download, such as the
#' euro area, and the missing values, and adds the names and groups of the
#' countries.
#' @param raw Data frame from [eurostat::get_eurostat()].
#' @return A data frame with `geo`, `country`, `group`, `year` and `value`.
#' @noRd
tidy_countries <- function(raw) {
  known <- countries()
  raw <- raw[!is.na(raw$values) & raw$geo %in% known$code, ]
  # a value more than 1,000 times the median of the countries of its year, and of the years of
  # its country, is an error of units in the data of Eurostat, such as the net earnings of
  # Turkiye of 2000 to 2003, in old lira that are a million times too large, which would
  # squeeze every other value of a chart; a country far larger than most, such as Germany
  # among the countries for the number of asylum decisions, is so every year, and is kept
  typical <- stats::ave(abs(raw$values), raw$time, FUN = stats::median)
  usual <- stats::ave(abs(raw$values), raw$geo, FUN = stats::median)
  wrong <- typical > 0 & abs(raw$values) > 1000 * typical & usual > 0 & abs(raw$values) > 1000 * usual
  if (any(wrong)) {
    message("Left out, as more than 1,000 times the median of their year and of their country: ", paste(raw$geo[wrong], raw$time[wrong], collapse = ", "))
    raw <- raw[!wrong, ]
  }
  row <- match(raw$geo, known$code)
  data.frame(
    geo = raw$geo,
    country = known$name[row],
    group = known$group[row],
    year = as.integer(raw$time),
    value = raw$values
  )
}
##########################################################################################
#
##########################################################################################
#' @title Get an indicator for the countries
#' @description Downloads one indicator of [indicators()] from Eurostat, or takes
#' it from the disk cache when it was downloaded less than a day ago, for the
#' countries of [countries()] and the EU-27 average.
#' @param id The `id` of the indicator in [indicators()], such as
#'   "unemployment".
#' @return A data frame with `geo` (the Eurostat code), `country`, `group`,
#'   `year` and `value`, or `NULL` with a message when Eurostat cannot be
#'   reached.
#' @export
#' @examples
#' \dontrun{
#' get_indicator("unemployment")
#' }
get_indicator <- function(id) {
  info <- indicator_info(id)
  cached(paste0("country_", id), function() {
    raw <- download_eurostat(info$dataset, parse_filters(info$filters))
    if (is.null(raw)) NULL else tidy_countries(raw)
  })
}
##########################################################################################
#
##########################################################################################
#' @title Get an indicator for the countries, as saved in the package
#' @description The values of one indicator of [all_values()], in the shape of
#' [get_indicator()], without internet: those of Eurostat on the day the package
#' was built (the `built` attribute of [all_values()]), for the examples of the
#' charts and to work offline.
#' @param id The `id` of the indicator in [indicators()], such as
#'   "unemployment".
#' @return A data frame with `geo` (the Eurostat code), `country`, `group`,
#'   `year` and `value`, or `NULL` when the package has no values.
#' @export
#' @examples
#' head(saved_indicator("unemployment"))
saved_indicator <- function(id) {
  indicator_info(id)
  values <- all_values()
  if (is.null(values)) {
    return(NULL)
  }
  values <- values[values$id == id, ]
  known <- countries()
  row <- match(values$geo, known$code)
  data.frame(
    geo = as.character(values$geo),
    country = known$name[row],
    group = known$group[row],
    year = values$year,
    value = values$value
  )
}
##########################################################################################
#
##########################################################################################
#' @title Keep the regions that are on the map
#' @description Leaves out the regions that are not in the outlines of the map,
#' such as those of older versions of the classification, and the missing
#' values, and adds the names of the regions and of their countries.
#' @param raw Data frame from [eurostat::get_eurostat()].
#' @param names Names of the regions by their code, from `nuts_names(2)`.
#' @return A data frame with `geo`, `region`, `country`, `year` and `value`.
#' @noRd
tidy_regions <- function(raw, names) {
  raw <- raw[!is.na(raw$values) & raw$geo %in% names(names), ]
  known <- countries()
  data.frame(
    geo = raw$geo,
    region = unname(names[raw$geo]),
    country = known$name[match(substr(raw$geo, 1, 2), known$code)],
    year = as.integer(raw$time),
    value = raw$values
  )
}
##########################################################################################
#
##########################################################################################
#' @title Get an indicator for the regions
#' @description Downloads one regional indicator of [indicators()] from
#' Eurostat, or takes it from the disk cache when it was downloaded less than a
#' day ago, for the regions of the NUTS 2024 classification at level 2.
#' @param id The `id` of a regional indicator in [indicators()], such as
#'   "r_unemployment".
#' @return A data frame with `geo` (the NUTS code), `region`, `country`, `year`
#'   and `value`, or `NULL` with a message when Eurostat or the outlines of
#'   the regions cannot be reached.
#' @export
#' @examples
#' \dontrun{
#' get_regional("r_gdp_pps")
#' }
get_regional <- function(id) {
  info <- indicator_info(id)
  cached(paste0("region_", id), function() {
    names <- nuts_names(2)
    raw <- if (!is.null(names)) download_eurostat(info$dataset, parse_filters(info$filters))
    if (is.null(raw)) NULL else tidy_regions(raw, names)
  })
}
##########################################################################################
#
##########################################################################################
#' @title The age groups of the population pyramid
#' @description The five-year groups of Eurostat's population by age group and
#' sex (`demo_pjangroup`), from under 5 to 85 and over.
#' @noRd
pyramid_ages <- c("Y_LT5", paste0("Y", seq(5, 80, 5), "-", seq(9, 84, 5)), "Y_GE85")
##########################################################################################
#
##########################################################################################
#' @title The population by age group and sex of a Eurostat download
#' @description The share of each age group in the population of its sex, in
#' percent, as golemworldbank shows it, for the years that have every age group
#' of both sexes: the oldest years of some countries stop at 75 or 80 and over.
#' @param raw Data frame from [eurostat::get_eurostat()].
#' @return A data frame with `sex` ("Male" or "Female"), `age` (a factor, "0-4"
#'   to "85+"), `year` and `value`.
#' @noRd
tidy_pyramid <- function(raw) {
  label <- function(age) sub("^Y", "", sub("^Y_GE85$", "85+", sub("^Y_LT5$", "0-4", age)))
  raw <- raw[!is.na(raw$values) & raw$age %in% pyramid_ages & raw$sex %in% c("M", "F"), ]
  groups <- tapply(paste(raw$sex, raw$age), raw$time, function(x) length(unique(x)))
  raw <- raw[as.character(raw$time) %in% names(groups)[groups == 2 * length(pyramid_ages)], ]
  total <- stats::ave(raw$values, raw$time, raw$sex, FUN = sum)
  data.frame(
    sex = ifelse(raw$sex == "M", "Male", "Female"),
    age = factor(label(raw$age), levels = label(pyramid_ages)),
    year = as.integer(raw$time),
    value = raw$values / total * 100
  )
}
##########################################################################################
#
##########################################################################################
#' @title The years of a population pyramid that jump back and forth
#' @description Eurostat's population of Greece by age group alternates, from
#' 1961 to 1970, between two age structures from one year to the next: the men
#' aged 55 to 59 are 165,000, 237,000, 175,000, 246,000..., which no real
#' population does. The years are checked from the latest back, against the
#' last year kept: a year whose age structure differs from it by more than
#' `least` points a year (the sum of the differences of the shares of the age
#' groups of the two sexes, over the years between the two; most years move by
#' about 4), and by more than twice as much as the year before it does, is a
#' jump, and the year before it is checked against the same year kept; the
#' first year, which has none before it, is compared with the step between the
#' two years kept after it. A real change, such as a new border, moves the
#' years before it too, and is kept, and so is a year a decade before the
#' next, such as the census of Luxembourg of 1961, whose age structure has
#' changed by a decade's worth.
#' @param data Data frame of `tidy_pyramid()`.
#' @param least The smallest jump, in points.
#' @return The years that jump, in order.
#' @noRd
jumping_years <- function(data, least = 10) {
  shares <- tapply(data$value, list(data$year, paste(data$sex, data$age)), sum)
  years <- as.integer(rownames(shares))
  if (length(years) < 3) {
    return(integer(0))
  }
  # a year apart
  distance <- function(a, b) sum(abs(shares[a, ] - shares[b, ])) / abs(years[a] - years[b])
  # the rows of the years kept, the latest first
  kept <- length(years)
  for (i in rev(seq_len(length(years) - 1))) {
    last <- kept[length(kept)]
    jump <- distance(i, last)
    reference <- if (i > 1) distance(i - 1, last) else if (length(kept) > 1) distance(last, kept[length(kept) - 1]) else Inf
    if (jump <= least || jump <= 2 * reference) kept <- c(kept, i)
  }
  sort(years[-kept])
}
##########################################################################################
#
##########################################################################################
#' @title Get the population of a country by age group and sex
#' @description Downloads the population on 1 January by five-year age group
#' and sex of one country from Eurostat (`demo_pjangroup`), or takes it from
#' the disk cache when it was downloaded less than a day ago.
#' @param country Eurostat code of the country, such as "EL", or "EU27_2020".
#' @return A data frame with `sex`, `age`, `year` and `value`, the share of the
#'   age group in the population of its sex, in percent, or `NULL` with a
#'   message when Eurostat cannot be reached.
#' @export
#' @examples
#' \dontrun{
#' get_pyramid("EL")
#' }
get_pyramid <- function(country) {
  cached(paste0("pyramid_", tolower(country)), function() {
    raw <- download_eurostat("demo_pjangroup", list(geo = country, sex = c("M", "F"), age = pyramid_ages, unit = "NR"))
    if (is.null(raw)) NULL else tidy_pyramid(raw)
  })
}
##########################################################################################
#
##########################################################################################
#' @title The file of the outlines of the countries or regions
#' @description The outlines of the NUTS 2024 classification at level 0, the
#' countries, or 2, the regions, from GISCO, the geographic information service
#' of the European Commission, as GeoJSON.
#' @param level 0 or 2.
#' @noRd
nuts_file_name <- function(level) {
  sprintf("NUTS_RG_20M_2024_4326_LEVL_%d.geojson", level)
}
##########################################################################################
#
##########################################################################################
#' @title The folder of the outlines
#' @description Next to the other downloads; the app serves it to the browser
#' under `nuts/`.
#' @noRd
nuts_dir <- function() {
  dir <- file.path(cache_dir(), "nuts")
  dir.create(dir, recursive = TRUE, showWarnings = FALSE)
  dir
}
##########################################################################################
#
##########################################################################################
#' @title Download the outlines once
#' @param level 0 or 2.
#' @return The path of the file, or `NULL` with a message when GISCO cannot be
#'   reached.
#' @noRd
nuts_file <- function(level) {
  path <- file.path(nuts_dir(), nuts_file_name(level))
  if (!file.exists(path)) {
    url <- paste0("https://gisco-services.ec.europa.eu/distribution/v2/nuts/geojson/", nuts_file_name(level))
    downloaded <- tryCatch(utils::download.file(url, path, quiet = TRUE, mode = "wb") == 0, error = function(e) FALSE, warning = function(w) FALSE)
    if (!downloaded) {
      unlink(path)
      message("Could not download the outlines of the map from GISCO: ", url)
      return(NULL)
    }
  }
  path
}
##########################################################################################
#
##########################################################################################
#' @title Where the browser finds the outlines
#' @param level 0 or 2.
#' @noRd
nuts_url <- function(level) {
  if ("nuts" %in% names(shiny::resourcePaths())) {
    # the app serves the files it downloaded
    paste0("nuts/", nuts_file_name(level))
  } else {
    # the website and the R console: GISCO lets any page fetch them
    paste0("https://gisco-services.ec.europa.eu/distribution/v2/nuts/geojson/", nuts_file_name(level))
  }
}
##########################################################################################
#
##########################################################################################
#' @title The names of the countries or regions of the outlines
#' @param level 0 or 2.
#' @return The names, in the Latin alphabet, by their NUTS code, or `NULL`
#'   when the outlines cannot be downloaded.
#' @noRd
nuts_names <- function(level) {
  key <- paste0("names_", level)
  if (is.null(memory[[key]])) {
    path <- nuts_file(level)
    if (is.null(path)) {
      return(NULL)
    }
    features <- jsonlite::read_json(path)$features
    memory[[key]] <- stats::setNames(
      vapply(features, function(f) f$properties$NAME_LATN, ""),
      vapply(features, function(f) f$properties$NUTS_ID, "")
    )
  }
  memory[[key]]
}
##########################################################################################
#
##########################################################################################
#' @title Check the catalogue against Eurostat
#' @description Downloads each indicator of [indicators()] from Eurostat, past
#' the disk cache, and reports how many countries or regions and which years it
#' has, or what is wrong with its row: Eurostat refuses the query, often for a
#' wrong dimension in `filters`; it has no values, often for a value the
#' dataset does not have; or it has more than one value for a country and year,
#' when a dimension of the dataset is left open. Run it after adding or
#' changing a row, and now and then, as Eurostat renames or retires datasets.
#' The generated rows are checked when `data-raw/build_indicators.R` writes
#' them, so by default only the hand-written rows are checked here.
#' @param ids The `id`s of the indicators to check, by default those written
#'   by hand.
#' @return A data frame with one row per indicator: `id`, `ok`, `areas` (the
#'   countries or regions with values), `first` and `last` (years), `problem`
#'   and `note` (values left out as errors of units, see
#'   [get_indicator()]).
#' @export
#' @examples
#' \dontrun{
#' check_indicators()
#' check_indicators(c("unemployment", "r_gdp_pps"))
#' }
check_indicators <- function(ids = indicators()$id[!indicators()$generated]) {
  do.call(rbind, lapply(ids, function(id) {
    info <- indicator_info(id)
    result <- data.frame(id = id, ok = FALSE, areas = 0L, first = NA_integer_, last = NA_integer_, problem = "", note = "")
    raw <- tryCatch(fetch_eurostat(info$dataset, parse_filters(info$filters)), error = function(e) e)
    if (inherits(raw, "error")) {
      result$problem <- strsplit(conditionMessage(raw), "\n")[[1]][1]
      return(result)
    }
    data <- withCallingHandlers(
      if (info$level == "region") tidy_regions(raw, nuts_names(2)) else tidy_countries(raw),
      message = function(m) {
        result$note <<- trimws(conditionMessage(m))
        invokeRestart("muffleMessage")
      }
    )
    if (nrow(data) == 0) {
      result$problem <- "no values for the countries or regions of the app"
      return(result)
    }
    result$areas <- length(unique(data$geo[data$geo != eu_average]))
    result$first <- min(data$year)
    result$last <- max(data$year)
    if (anyDuplicated(data[c("geo", "year")]) > 0) {
      result$problem <- "more than one value for a country and year: a dimension of the dataset is left open in filters"
      return(result)
    }
    result$ok <- TRUE
    result
  }))
}
