test_that("the files shared by the apps (dark_mode.js) come from sedzinfo.github.io, not from inst/app/www", {
  head <- htmltools::renderTags(app_ui(NULL))$head
  expect_match(head, "https://sedzinfo.github.io/shiny/dark_mode.js", fixed = TRUE)
  expect_no_match(head, "www/dark_mode.js", fixed = TRUE)
})
