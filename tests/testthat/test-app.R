test_that("the files shared by the apps (dark_mode.js) come from sedzinfo.github.io, not from inst/app/www", {
  head <- htmltools::renderTags(app_ui(NULL))$head
  expect_match(head, "https://sedzinfo.github.io/shiny/dark_mode.js", fixed = TRUE)
  expect_no_match(head, "www/dark_mode.js", fixed = TRUE)
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
    tabs[!tabs %in% c("Increased", "Decreased")],
    c("Country Comparison", "Indicator Comparison", "Pyramid", "Barplot", "Scatterplot", "Map", "Regions", "Change (%)", "Indicators", "About")
  )
})
