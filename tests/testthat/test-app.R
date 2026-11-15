# app_ui() serves the outlines of the regions under nuts/, as the app does; outside the app, as in
# the tests of the other files, the map of the regions takes them from GISCO
withr::defer(if ("nuts" %in% names(shiny::resourcePaths())) shiny::removeResourcePath("nuts"))

test_that("the files shared by the apps (dark_mode.js, layout.css, layout.js) come from sedzinfo.github.io, not from inst/app/www", {
  head <- htmltools::renderTags(app_ui(NULL))$head
  for (file in c("dark_mode.js", "layout.css", "layout.js")) {
    expect_match(head, paste0("https://sedzinfo.github.io/shiny/", file), fixed = TRUE)
    expect_false(file.exists(app_sys("app/www", file)))
  }
  # the layout, as golemworldbank's, is the shared one only
  expect_no_match(head, ".navbar {min-height", fixed = TRUE)
  expect_false(file.exists(app_sys("app/www/mobile.css")))
  expect_false(file.exists(app_sys("app/www/mobile.js")))
})

test_that("the page has a description, for search engines and link previews, as golemworldbank", {
  head <- htmltools::renderTags(app_ui(NULL))$head
  expect_match(head, '<meta name="description" content="Explore Eurostat indicators', fixed = TRUE)
  expect_match(head, '<meta property="og:title" content="Eurostat"', fixed = TRUE)
  # no address or screenshot of the live app yet
  expect_no_match(head, "og:url", fixed = TRUE)
})

test_that("the stylesheet shared by the apps is in the page, before the app's own", {
  rendered <- htmltools::renderTags(app_ui(NULL))
  # as shiny draws the head: the dependencies first (the shared stylesheet is one; those with only
  # a local folder, such as jQuery, shiny serves itself), then the rest of the head
  deps <- Filter(function(d) !is.null(d$src$href), htmltools::resolveDependencies(rendered$dependencies))
  page <- paste(htmltools::renderDependencies(deps, "href"), rendered$head)
  shared <- regexpr("https://sedzinfo.github.io/shiny/apps.css", page, fixed = TRUE)
  expect_gt(shared, 0)
  own <- regexpr("href=\"www/[A-Za-z0-9_.-]+\\.css\"", page)
  if (own > 0) expect_lt(shared, own)
})

test_that("the cookie banner and Google Analytics are in the page only with analytics = TRUE", {
  off <- htmltools::renderTags(app_ui(NULL))
  expect_no_match(off$head, "consent.js", fixed = TRUE)
  expect_no_match(off$html, "cookie-settings", fixed = TRUE)
  on <- htmltools::renderTags(app_ui(NULL, analytics = TRUE))
  expect_match(on$head, "https://sedzinfo.github.io/consent.js", fixed = TRUE)
  expect_match(on$head, "https://sedzinfo.github.io/shiny/analytics.js", fixed = TRUE)
  expect_match(on$html, "#cookie-settings", fixed = TRUE)
})

test_that("the app has the tabs of golemworldbank, with two maps", {
  html <- htmltools::renderTags(app_ui(NULL))$html
  # the navbar links, in their order, without the tabs inside the Change (%) tab
  tabs <- regmatches(html, gregexpr('data-toggle="tab" data-bs-toggle="tab" data-value="[^"]+"', html))[[1]]
  tabs <- sub('.*data-value="([^"]+)"', "\\1", tabs)
  expect_equal(
    tabs[!tabs %in% c("Increased", "Decreased", "Percentages increased", "Percentages decreased")],
    c("Country Comparison", "Indicator Comparison", "Pyramid", "Barplot", "Scatterplot", "Map", "Regions", "Change (%)", "Indicators", "About")
  )
})
