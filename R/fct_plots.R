##########################################################################################
#
##########################################################################################
#' @title A chart title that fits
#' @description Wraps a long title, such as the names of the indicators of
#' Eurostat's main tables, on several lines at the top of the chart. The first
#' line is where plotly puts a title of one line, in the middle of the top
#' margin; the others go under it, and the chart and its legend lower down by
#' as much.
#' @param text The title.
#' @param top The top margin of the chart with a title of one line.
#' @param width The most characters on a line.
#' @return A list: `title`, for the layout, and `top`, the top margin.
#' @noRd
chart_title <- function(text, top, width = 70) {
  lines <- strwrap(text, width)
  # plotly writes a title 1.4 times the size of the font of the chart, and 1.3 times that
  # from one line to the next
  extra <- ceiling(1.3 * 1.4 * font_style$size) * (length(lines) - 1)
  list(
    # anchored at the bottom, plotly puts the first line of a title at the anchor and the others
    # under it (anchored at the top, it moves a title of several lines up, out of the chart)
    title = list(text = paste(lines, collapse = "<br>"), yref = "paper", y = 1, yanchor = "bottom", pad = list(b = top / 2 + extra)),
    top = top + extra
  )
}
##########################################################################################
#
##########################################################################################
#' @title The name of an indicator with its unit
#' @description Such as "Unemployment rate (% of the labour force)", or the
#' name alone for the indicators of Eurostat's main tables that have no unit.
#' @param info The row of the indicator in [indicators()].
#' @noRd
with_unit <- function(info) {
  if (nzchar(info$unit)) paste0(info$name, " (", info$unit, ")") else info$name
}
##########################################################################################
#
##########################################################################################
#' @title The title of an axis that fits
#' @description The name of an indicator with its unit; a long one, such as
#' the names of Eurostat's main tables, in a smaller font on lines of at most
#' `width` characters, which would otherwise run past the end of the axis.
#' @param info The row of the indicator in [indicators()].
#' @param width The most characters on a line.
#' @return A list for the `title` of a plotly axis.
#' @noRd
axis_title <- function(info, width) {
  text <- with_unit(info)
  if (nchar(text) <= width) {
    return(list(text = text))
  }
  list(text = paste(strwrap(text, width), collapse = "<br>"), font = list(size = 14))
}
##########################################################################################
#
##########################################################################################
#' @title A label of an animated chart that changes with the year
#' @description Sets the one annotation of a chart with frames to the label of
#' each frame, and keeps it right while the animation plays, when plotly does
#' not redraw the annotations of the frames.
#' @param p A plotly object with frames, built with [plotly::plotly_build()].
#' @param labels Text of each frame, named by the name of the frame.
#' @param annotation The annotation, without its `text`.
#' @return The plotly object.
#' @importFrom plotly %>%
#' @noRd
label_frames <- function(p, labels, annotation) {
  annotate <- function(name) list(c(list(text = unname(labels[name])), annotation))
  p$x$layout$annotations <- annotate(p$x$frames[[1]]$name)
  for (k in seq_along(p$x$frames)) {
    p$x$frames[[k]]$layout <- list(annotations = annotate(p$x$frames[[k]]$name))
  }
  htmlwidgets::onRender(p, "function(el, x, labels) {
    el.on('plotly_animatingframe', function(e) {
      var text = el.querySelector('.annotation-text');
      if (text && labels[e.name] !== undefined) text.textContent = labels[e.name];
    });
  }", data = as.list(labels))
}
##########################################################################################
#
##########################################################################################
#' @title The slider of the years of an animated chart
#' @description Labelled "Year: 2024", as in golemworldbank, rather than with
#' the name of the column of the frames.
#' @param p A plotly object with frames.
#' @return The plotly object, built.
#' @noRd
year_slider <- function(p) {
  plotly::animation_slider(p, currentvalue = list(prefix = "Year: "))
}
##########################################################################################
#
##########################################################################################
#' @title Open an animated chart at its last year
#' @description An animated chart opens at its first frame, the first year; this
#' gives it the data of its last frame instead, and moves the slider there, so
#' that it opens at the latest year, and Play still runs through the years from
#' the first. Done before the chart reaches the browser, where moving it after
#' it is drawn left plotly with a wrong range on the axis of the bars.
#' @param p A plotly object with frames.
#' @return The plotly object, built.
#' @noRd
start_at_last_year <- function(p) {
  p <- plotly::plotly_build(p)
  frames <- p$x$frames
  if (length(frames) < 2) {
    return(p)
  }
  last <- frames[[length(frames)]]
  traces <- if (is.null(last$traces)) seq_along(last$data) else unlist(last$traces) + 1
  for (i in seq_along(last$data)) {
    p$x$data[[traces[i]]] <- utils::modifyList(p$x$data[[traces[i]]], last$data[[i]])
  }
  if (length(p$x$layout$sliders) > 0) {
    p$x$layout$sliders[[1]]$active <- length(frames) - 1
  }
  if (!is.null(last$layout$annotations)) {
    p$x$layout$annotations <- last$layout$annotations
  }
  p
}
##########################################################################################
#
##########################################################################################
#' @title Line chart of an indicator for several countries
#' @description One line per country, and the EU-27 average as a dashed gray
#' line, for comparison.
#' @param data Data frame from [get_indicator()].
#' @param countries Eurostat codes of the countries, such as `c("EL", "BG")`.
#' @param indicator The `id` of the indicator in [indicators()], for the title
#'   and the unit.
#' @return A plotly object.
#' @export
#' @examples
#' data <- data.frame(
#'   geo = rep(c("EL", "BG", "EU27_2020"), each = 3),
#'   country = rep(c("Greece", "Bulgaria", "EU-27"), each = 3),
#'   group = rep(c("EU", "EU", "EU-27"), each = 3),
#'   year = rep(2022:2024, 3),
#'   value = c(12.4, 11.1, 10.1, 4.3, 4.3, 4.2, 6.2, 6.1, 5.9)
#' )
#' plot_country_comp(data, c("EL", "BG"), "unemployment")
plot_country_comp <- function(data, countries, indicator) {
  info <- indicator_info(indicator)
  hover <- function(d) paste0(d$country, "<br>", d$year, ": ", format_value(d$value), " ", info$unit)
  picked <- data[data$geo %in% countries, ]
  average <- data[data$geo == eu_average, ]
  p <- plotly::plot_ly()
  if (nrow(picked) > 0) {
    p <- plotly::add_trace(p,
      x = picked$year, y = picked$value, color = picked$country,
      type = "scatter", mode = "lines+markers", text = hover(picked), hoverinfo = "text"
    )
  }
  if (nrow(average) > 0) {
    p <- plotly::add_trace(p,
      x = average$year, y = average$value, name = "EU-27",
      type = "scatter", mode = "lines", line = list(color = "gray", dash = "dash", width = 2),
      text = hover(average), hoverinfo = "text"
    )
  }
  heading <- chart_title(info$name, 100)
  p %>%
    plotly::layout(
      title = heading$title,
      # as in golemworldbank: the title in the top margin, the legend at the top of the plot
      margin = list(l = 50, r = 50, b = 0, t = heading$top, pad = 0),
      legend = list(orientation = "h", xanchor = "center", x = 0.5, y = 1),
      xaxis = list(title = "", tickangle = -90),
      yaxis = list(title = info$unit),
      font = font_style
    ) %>%
    plotly::config(responsive = TRUE)
}
##########################################################################################
#
##########################################################################################
#' @title Ranked bars of an indicator, animated by year
#' @description One bar per country, the largest at the top, re-ranked each
#' year as the animation plays, and the picked country in red. A country's gaps
#' between its first and last year are filled in a straight line, so that it
#' does not drop out of the race for a year. As in golemworldbank, only the
#' `top_n` largest are shown each year, and the year is printed large and gray
#' in the bottom right corner.
#' @inheritParams plot_country_comp
#' @param country Eurostat code of the country to draw in red.
#' @param top_n How many countries to show each year, the largest; all of them
#'   by default.
#' @return A plotly object.
#' @export
#' @examples
#' data <- data.frame(
#'   geo = rep(c("EL", "BG", "DE"), each = 3),
#'   country = rep(c("Greece", "Bulgaria", "Germany"), each = 3),
#'   group = "EU",
#'   year = rep(2022:2024, 3),
#'   value = c(12.4, 11.1, 10.1, 4.3, 4.3, 4.2, 3.1, 3.0, 3.4)
#' )
#' plot_bar(data, "unemployment", "EL")
plot_bar <- function(data, indicator, country = NULL, top_n = Inf) {
  info <- indicator_info(indicator)
  heading <- chart_title(info$name, 100)
  data <- data[data$geo != eu_average, ]
  years <- sort(unique(data$year))
  data <- do.call(rbind, lapply(split(data, data$geo), function(d) {
    d <- d[order(d$year), ]
    span <- years[years >= min(d$year) & years <= max(d$year)]
    value <- if (nrow(d) < 2) d$value else stats::approx(d$year, d$value, xout = span)$y
    data.frame(geo = d$geo[1], country = d$country[1], year = span, value = value)
  }))
  data <- data[order(data$year, -data$value), ]
  data$rank <- stats::ave(data$value, data$year, FUN = seq_along)
  data <- data[data$rank <= top_n, ]
  data$label <- paste0(data$country, "  ", format_value(data$value))
  data$color <- ifelse(data$geo %in% country, "#d62728", "#1f77b4")
  data$year <- factor(data$year)
  p <- plotly::plot_ly(data,
    x = ~value,
    y = ~rank,
    frame = ~year,
    ids = ~geo,
    type = "bar",
    orientation = "h",
    marker = list(color = ~color),
    text = ~label,
    textposition = "auto",
    cliponaxis = FALSE,
    hovertext = ~ paste0("Rank ", rank, "<br>", country, ": ", format_value(value), " ", info$unit),
    hoverinfo = "text"
  ) %>%
    plotly::layout(
      title = heading$title,
      margin = list(l = 50, r = 50, b = 100, t = heading$top, pad = 0),
      # rank 1 at the top; the names are on the bars
      yaxis = list(title = "", autorange = "reversed", dtick = 1, zeroline = FALSE),
      xaxis = list(title = info$unit, showticklabels = FALSE, zeroline = TRUE, showgrid = FALSE),
      font = font_style,
      showlegend = FALSE
    ) %>%
    plotly::animation_opts(frame = 1000, transition = 0, easing = "linear", redraw = TRUE, mode = "afterall") %>%
    plotly::layout(updatemenus = animation_buttons(levels(data$year)[1])) %>%
    year_slider() %>%
    plotly::config(responsive = TRUE)
  # the year, big and gray in the bottom right corner, where the bars are shortest, as large
  # as in golemworldbank
  label_frames(p, stats::setNames(levels(data$year), levels(data$year)), list(
    xref = "paper", yref = "paper", x = 1, y = 0, xanchor = "right", yanchor = "bottom",
    showarrow = FALSE, font = list(size = 480, color = "rgba(128,128,128,0.35)")
  )) %>%
    fit_year() %>%
    start_at_last_year()
}
##########################################################################################
#
##########################################################################################
#' @title Keep the year of the bar race inside its plot
#' @description The year is as large as in golemworldbank, 480px, when the plot
#' has room for it, and smaller in a smaller window, at most 80% of the height
#' of the plot and a third of its width, where it would otherwise rise behind
#' the title. Fitted again when the window, and so the plot, changes size.
#' @param p The plotly object of [plot_bar()], with the year as its first
#'   annotation, in the chart and in each frame.
#' @return The plotly object.
#' @noRd
fit_year <- function(p) {
  htmlwidgets::onRender(p, "function(el) {
    function fit() {
      var size = el._fullLayout && el._fullLayout._size, year = el.layout.annotations && el.layout.annotations[0];
      if (!size || !year) return;
      var font = Math.round(Math.min(480, 0.8 * size.h, size.w / 3));
      if (Math.abs(year.font.size - font) < 2) return;
      // the frames carry the year too, and would put back its size
      (el._transitionData._frames || []).forEach(function(f) {
        if (f.layout && f.layout.annotations) f.layout.annotations[0].font.size = font;
      });
      Plotly.relayout(el, {'annotations[0].font.size': font});
    }
    el.on('plotly_afterplot', fit);
    fit();
  }")
}
##########################################################################################
#
##########################################################################################
#' @title Map of countries or regions, animated by year
#' @description Colors the outlines of the NUTS classification by the value of
#' each year, on one color scale for all the years.
#' @param data Data frame with `geo`, `year` and `value`.
#' @param info The row of the indicator in [indicators()].
#' @param level 0 for countries, 2 for regions.
#' @param label Name of each row, for the hover labels.
#' @return A plotly object.
#' @noRd
choropleth <- function(data, info, level, label) {
  heading <- chart_title(info$name, 100)
  data$label <- label
  data <- data[order(data$year), ]
  data$year <- factor(data$year)
  limits <- range(data$value, na.rm = TRUE)
  plotly::plot_ly(data,
    type = "choropleth",
    geojson = nuts_url(level),
    featureidkey = "properties.NUTS_ID",
    locations = ~geo,
    z = ~value,
    frame = ~year,
    zmin = limits[1],
    zmax = limits[2],
    colors = "Blues",
    marker = list(line = list(width = 0.3, color = "white")),
    colorbar = list(title = ""),
    text = ~ paste0(label, "<br>", year, ": ", format_value(value), " ", info$unit),
    hoverinfo = "text"
  ) %>%
    plotly::layout(
      title = heading$title,
      margin = list(l = 50, r = 50, b = 100, t = heading$top, pad = 0),
      font = font_style,
      geo = list(
        visible = FALSE,
        projection = list(type = "mercator"),
        lonaxis = list(range = c(-25, 45)),
        lataxis = list(range = c(34, 72)),
        bgcolor = "rgba(0,0,0,0)"
      ),
      # as the terms of use of the outlines ask
      annotations = list(list(
        text = "Boundaries: \u00a9 EuroGeographics", xref = "paper", yref = "paper", x = 1, y = 0,
        xanchor = "right", yanchor = "bottom", showarrow = FALSE, font = list(size = 11, color = "gray")
      ))
    ) %>%
    plotly::animation_opts(frame = 500, transition = 0, easing = "linear", redraw = TRUE, mode = "afterall") %>%
    plotly::layout(updatemenus = animation_buttons(levels(data$year)[1])) %>%
    year_slider() %>%
    plotly::config(responsive = TRUE) %>%
    start_at_last_year()
}
##########################################################################################
#
##########################################################################################
#' @title Map of the countries, animated by year
#' @description The countries of [countries()] colored by the value of the
#' indicator, from light for low to dark blue for high, on one scale for all
#' the years.
#' @inheritParams plot_country_comp
#' @return A plotly object.
#' @export
#' @examples
#' data <- data.frame(
#'   geo = rep(c("EL", "BG", "DE"), each = 2), country = rep(c("Greece", "Bulgaria", "Germany"), each = 2),
#'   group = "EU", year = rep(2023:2024, 3), value = c(11.1, 10.1, 4.3, 4.2, 3.0, 3.4)
#' )
#' plot_map(data, "unemployment")
plot_map <- function(data, indicator) {
  data <- data[data$geo != eu_average, ]
  choropleth(data, indicator_info(indicator), 0, data$country)
}
##########################################################################################
#
##########################################################################################
#' @title Map of the regions, animated by year
#' @description The regions of the NUTS 2024 classification at level 2 colored
#' by the value of the indicator, from light for low to dark blue for high, on
#' one scale for all the years.
#' @param data Data frame from [get_regional()].
#' @param indicator The `id` of a regional indicator in [indicators()].
#' @return A plotly object.
#' @export
#' @examples
#' data <- data.frame(
#'   geo = c("EL30", "EL52"), region = c("Attiki", "Kentriki Makedonia"),
#'   country = "Greece", year = 2024, value = c(105, 58)
#' )
#' plot_regions(data, "r_gdp_pps")
plot_regions <- function(data, indicator) {
  choropleth(data, indicator_info(indicator), 2, paste0(data$region, " (", data$country, ")"))
}
##########################################################################################
#
##########################################################################################
#' @title Scatter plot of two indicators, animated by year
#' @description One point per country, colored by its group (EU, EFTA,
#' candidate), on axes that stay the same for all the years, with the
#' correlation of the two indicators across the countries of each year.
#' @param x_data,y_data Data frames from [get_indicator()].
#' @param x_indicator,y_indicator The `id`s of the two indicators in
#'   [indicators()].
#' @return A plotly object, or `NULL` when the two indicators have no year in
#'   common.
#' @export
#' @examples
#' x <- data.frame(
#'   geo = c("EL", "BG", "DE", "NO"), country = c("Greece", "Bulgaria", "Germany", "Norway"),
#'   group = c("EU", "EU", "EU", "EFTA"), year = 2024, value = c(70, 66, 116, 130)
#' )
#' y <- transform(x, value = c(81.9, 75.9, 81.2, 83.4))
#' plot_scatter(x, y, "gdp_pps", "life_expectancy")
plot_scatter <- function(x_data, y_data, x_indicator, y_indicator) {
  x_info <- indicator_info(x_indicator)
  y_info <- indicator_info(y_indicator)
  both <- merge(
    x_data[x_data$geo != eu_average, c("geo", "country", "group", "year", "value")],
    y_data[y_data$geo != eu_average, c("geo", "year", "value")],
    by = c("geo", "year"), suffixes = c("_x", "_y")
  )
  if (nrow(both) == 0) {
    return(NULL)
  }
  both$real <- TRUE
  limits_x <- range(both$value_x) + c(-1, 1) * 0.06 * diff(range(both$value_x))
  limits_y <- range(both$value_y) + c(-1, 1) * 0.06 * diff(range(both$value_y))
  # plotly mixes up the groups of a year that lacks one of them, giving one group's points the
  # color of another; so each year gets a point of every group, far outside the axes where
  # no country of the group has both values that year
  groups <- c("EU", "EFTA", "Candidate")
  missing <- expand.grid(year = unique(both$year), group = groups, stringsAsFactors = FALSE)
  missing <- missing[!paste(missing$year, missing$group) %in% paste(both$year, both$group), ]
  if (nrow(missing) > 0) {
    both <- rbind(both, data.frame(
      geo = paste0("none_", missing$group), year = missing$year, country = "", group = missing$group,
      value_x = -1e12, value_y = -1e12, real = FALSE
    ))
  }
  both <- both[order(both$year), ]
  both$year <- factor(both$year)
  both$group <- factor(both$group, levels = groups)
  both$label <- ifelse(both$real, both$geo, "")
  both$hover <- paste0(
    both$country, ", ", both$year, "<br>", x_info$name, ": ", format_value(both$value_x), " ", x_info$unit,
    "<br>", y_info$name, ": ", format_value(both$value_y), " ", y_info$unit
  )
  p <- plotly::plot_ly(both,
    x = ~value_x,
    y = ~value_y,
    color = ~group,
    colors = c("#2a78d6", "#eb6834", "#1baf7a"),
    frame = ~year,
    ids = ~geo,
    text = ~label,
    type = "scatter",
    mode = "markers+text",
    textposition = "top center",
    marker = list(size = 12),
    hovertext = ~hover,
    hoverinfo = "text"
  ) %>%
    plotly::layout(
      # as in golemworldbank: no title, as the axes name the two indicators, the legend at the
      # right of the plot, and the title of the x axis right under it, clear of the year slider
      title = "",
      margin = list(l = 50, r = 50, b = 100, t = 100, pad = 0),
      # EU, EFTA, Candidate, as plotly lists the groups the other way round
      legend = list(traceorder = "reversed"),
      # the left margin grows to fit a vertical title on several lines
      xaxis = list(title = c(axis_title(x_info, 100), list(standoff = 3)), range = limits_x),
      yaxis = list(title = axis_title(y_info, 45), range = limits_y, automargin = TRUE),
      font = font_style
    ) %>%
    plotly::animation_opts(frame = 800, transition = 400, easing = "linear", redraw = FALSE, mode = "afterall") %>%
    plotly::layout(updatemenus = animation_buttons(levels(both$year)[1])) %>%
    year_slider() %>%
    plotly::config(responsive = TRUE)
  real <- both[both$real, ]
  correlation <- vapply(levels(both$year), function(year) {
    d <- real[real$year == year, ]
    if (nrow(d) < 3) "" else sprintf("Correlation r = %.2f, %d countries", stats::cor(d$value_x, d$value_y), nrow(d))
  }, "")
  label_frames(p, correlation, list(
    xref = "paper", yref = "paper", x = 0, y = 1, xanchor = "left", yanchor = "bottom",
    showarrow = FALSE, font = list(size = 14)
  )) %>%
    start_at_last_year()
}
##########################################################################################
#
##########################################################################################
#' @title Table of the indicators
#' @description Every indicator of [indicators()], with its unit, whether it is
#' for countries or regions, a link to its dataset in the database of Eurostat
#' and its definition.
#' @return A DT table.
#' @export
#' @examples
#' render_index_table()
render_index_table <- function() {
  table <- indicators()
  shown <- data.frame(
    Topic = table$topic,
    Indicator = table$name,
    Unit = table$unit,
    For = ifelse(table$level == "region", "Regions", "Countries"),
    Dataset = sprintf(
      '<a href="https://ec.europa.eu/eurostat/databrowser/view/%s/default/table?lang=en" target="_blank" rel="noopener">%s</a>',
      table$dataset, table$dataset
    ),
    Definition = table$definition
  )
  DT::datatable(shown,
    rownames = FALSE,
    escape = setdiff(names(shown), "Dataset"),
    options = list(pageLength = 50, autoWidth = TRUE)
  )
}
