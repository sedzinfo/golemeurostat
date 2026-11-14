##########################################################################################
# THE VALUES OF THE INDICATORS, FOR THE CHANGE (%) TAB
##########################################################################################
# Writes inst/extdata/values.rds: every value of every indicator of the countries in
# indicators(), hand-written and generated, for the countries of the app and the EU-27, as
# the app tidies them (tidy_countries(), which also leaves out the errors of units). The
# Change (%) tab compares all the indicators of a country between two years, which needs
# them all at once; the other tabs download the indicator they show from Eurostat.
#
# build_indicators.R runs it at its end, after writing the catalogue; it can also be run
# alone, from the package folder:
#   source("data-raw/build_values.R")
# The generated indicators come from the tables build_indicators.R keeps in data-raw/cache;
# the hand-written ones are downloaded, and kept there for a week too.
##########################################################################################
max_age_days <- 7
pkgload::load_all(quiet = TRUE)
cache <- file.path("data-raw", "cache")
dir.create(file.path(cache, "series"), recursive = TRUE, showWarnings = FALSE)
output <- file.path("inst", "extdata", "values.rds")
fresh <- function(path) {
  file.exists(path) && difftime(Sys.time(), file.mtime(path), units = "days") < max_age_days
}
cached_rds <- function(path, get) {
  if (fresh(path)) {
    return(readRDS(path))
  }
  value <- get()
  if (!is.null(value)) saveRDS(value, path)
  value
}
##########################################################################################
# The rows of an indicator, as get_eurostat() gives them: from its table, downloaded whole by
# build_indicators.R, or downloaded with its filters
##########################################################################################
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
  data <- suppressMessages(tidy_countries(raw))
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
