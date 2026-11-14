##########################################################################################
# DIRECTORIES
##########################################################################################
# R CMD check golemeurostat
# R CMD Rd2pdf golemeurostat
# R CMD build golemeurostat --resave-data
library(devtools)
library(roxygen2)
rm(list = ls())
graphics.off()
cat("\014")
##########################################################################################
# FUNCTIONS PACKAGE
##########################################################################################
directory <- dirname(rstudioapi::getActiveDocumentContext()$path)
setwd(directory)
# rebuild inst/extdata/indicators_generated.csv from the main tables of Eurostat, and the values of the
# Change (%) tab, inst/extdata/values.rds (about 12 minutes the first time)
# source("data-raw/build_indicators.R")
document()
if ("golemeurostat" %in% loadedNamespaces()) unloadNamespace("golemeurostat")
if ("golemeurostat" %in% rownames(installed.packages())) remove.packages("golemeurostat")
install()
library(golemeurostat)

pkgdown::build_site(getwd(), lazy = TRUE)
system("R CMD Rd2pdf . --force --no-preview --output=golemeurostat.pdf")
if (.Platform$OS.type == "windows") shell.exec("golemeurostat.pdf") else system("evince golemeurostat.pdf")
system("R CMD build . --resave-data")

# rsconnect::writeManifest(appDir = ".", appPrimaryDoc = "app.R")

golemeurostat::run_app()
