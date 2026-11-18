# Launch the ShinyApp (Do not remove this comment)
# To deploy, run: rsconnect::deployApp()
# Or use the blue button on top of this file

# RStudio's "Run App" button launches this file in a separate R process that inherits
# RSTUDIO=1 but is not connected to the RStudio API, which makes cli (used by pkgload)
# fail with "RStudio not running"; clearing the variable avoids it
Sys.unsetenv("RSTUDIO")

pkgload::load_all(export_all = FALSE, helpers = FALSE, attach_testthat = FALSE)
options("golem.app.prod" = TRUE)
# run_app() without the golemeurostat:: prefix: load_all() has attached it already, and the prefix
# makes renv (rsconnect::deployApp) list golemeurostat itself as a dependency, which fails the deploy
# with "packages installed from an unknown source" whenever the package is installed locally
run_app(analytics = TRUE) # Google Analytics, after the visitor accepts the cookie banner

# rsconnect::writeManifest(appDir = ".", appPrimaryDoc = "app.R")
