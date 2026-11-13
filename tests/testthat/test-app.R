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
