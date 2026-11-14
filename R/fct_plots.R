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
#' the name of the column of the frames. A chart of one year has no slider.
#' @param p A plotly object with frames.
#' @return The plotly object, built.
#' @noRd
year_slider <- function(p) {
  p <- plotly::plotly_build(p)
  if (length(p$x$layout$sliders) == 0) {
    return(p)
  }
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
#' line, for comparison. Titled "Indicator: " and its name, as in golemworldbank.
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
  heading <- chart_title(paste("Indicator:", info$name), 100)
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
#' @title Line chart of several indicators for one country
#' @description As in golemworldbank: one line per indicator, in the colors of
#' the Country Comparison, named with its unit in the legend, at the top of the
#' plot. The axis takes the unit when all the indicators share it. An indicator
#' without values for the country is left out.
#' @param data Data frames from [get_indicator()], one per indicator, named by
#'   its `id`.
#' @param country Eurostat code of the country, such as "EL", or "EU27_2020".
#' @param indicators The `id`s of the indicators in [indicators()].
#' @return A plotly object, or `NULL` when none of the indicators has values for
#'   the country.
#' @export
#' @examples
#' unemployment <- data.frame(
#'   geo = "EL", country = "Greece", group = "EU", year = 2022:2024, value = c(12.4, 11.1, 10.1)
#' )
#' youth <- transform(unemployment, value = c(31.4, 26.7, 22.4))
#' plot_indicator_comp(
#'   list(unemployment = unemployment, youth_unemployment = youth), "EL",
#'   c("unemployment", "youth_unemployment")
#' )
plot_indicator_comp <- function(data, country, indicators) {
  lines <- list()
  units <- character(0)
  for (id in indicators) {
    info <- indicator_info(id)
    d <- data[[id]]
    d <- d[d$geo == country, ]
    if (nrow(d) == 0) next
    units <- c(units, info$unit)
    lines[[id]] <- data.frame(
      year = d$year,
      value = d$value,
      name = paste(strwrap(with_unit(info), 80), collapse = "<br>"),
      hover = paste0(info$name, "<br>", d$year, ": ", format_value(d$value), " ", info$unit)
    )
  }
  if (length(lines) == 0) {
    return(NULL)
  }
  long <- do.call(rbind, lines)
  long <- long[order(long$year), ]
  # the lines in the order of the indicators, colored by plotly as the countries are, and as the
  # indicators of golemworldbank
  long$name <- factor(long$name, levels = unique(vapply(lines, function(l) l$name[1], "")))
  plotly::plot_ly(long,
    x = ~year, y = ~value, color = ~name,
    type = "scatter", mode = "lines+markers", text = ~hover, hoverinfo = "text"
  ) %>%
    plotly::layout(
      title = paste("Country:", countries()$name[match(country, countries()$code)]),
      margin = list(l = 50, r = 50, b = 0, t = 100, pad = 0),
      # the names of Eurostat's indicators are long, so the legend is smaller than the chart's font
      legend = list(orientation = "h", xanchor = "center", x = 0.5, y = 1, font = list(size = 14)),
      xaxis = list(title = "", tickangle = -90),
      yaxis = list(title = if (length(unique(units)) == 1) units[1] else ""),
      showlegend = TRUE,
      font = font_style
    ) %>%
    plotly::config(responsive = TRUE)
}
##########################################################################################
#
##########################################################################################
#' @title Population pyramid, animated by year
#' @description As in golemworldbank: the share of each five-year age group in
#' the male population, to the left, and in the female population, to the
#' right, animated over the years. The male values are drawn negative, so that
#' the two sexes stand back to back, but the labels on the bars and the axis
#' show them positive. The axis stays the same for all the years. The years
#' whose figures jump back and forth from one year to the next, as Eurostat's
#' for Greece from 1961 to 1969 do, are left out, and named at the top of the
#' chart.
#' @param data Data frame from [get_pyramid()].
#' @param country Eurostat code of the country, for the title ("Country: " and
#'   its name, as in golemworldbank).
#' @return A plotly object.
#' @export
#' @examples
#' data <- data.frame(
#'   sex = rep(c("Male", "Female"), each = 4),
#'   age = factor(rep(c("0-4", "5-9"), 4), levels = c("0-4", "5-9")),
#'   year = rep(c(2024, 2024, 2025, 2025), 2),
#'   value = c(48, 52, 47, 53, 49, 51, 48, 52)
#' )
#' plot_pyramid(data, "EL")
plot_pyramid <- function(data, country) {
  # the years whose figures jump back and forth, as Greece's of the 1960s, are left out, and named
  left_out <- jumping_years(data)
  data <- data[!data$year %in% left_out, ]
  note <- if (length(left_out) > 0) {
    list(list(
      text = paste("Left out, as Eurostat's figures for them jump back and forth:", paste(left_out, collapse = ", ")),
      xref = "paper", yref = "paper", x = 0, y = 1, xanchor = "left", yanchor = "bottom",
      showarrow = FALSE, font = list(size = 14)
    ))
  }
  data <- data[order(data$year, data$sex, data$age), ]
  data$shown <- round(data$value, 2)
  data$x <- ifelse(data$sex == "Male", -data$shown, data$shown)
  # room for the labels at the end of the longest bars
  widest <- 1.25 * max(data$shown)
  # at most six ticks a side, which leaves them level, where one for each percent stood on end
  step <- c(1, 2, 5, 10, 20, 50)[which(widest / c(1, 2, 5, 10, 20, 50) <= 6)[1]]
  ticks <- seq(-floor(widest / step), floor(widest / step)) * step
  data$year <- factor(data$year)
  p <- plotly::plot_ly(data,
    x = ~x,
    y = ~age,
    color = ~sex,
    ids = ~age,
    frame = ~year,
    type = "bar",
    orientation = "h",
    text = ~shown,
    textposition = "outside",
    hovertext = ~ paste0(sex, ", ", age, ": ", shown, "% of the ", tolower(sex), " population"),
    hoverinfo = "text"
  ) %>%
    plotly::layout(
      bargap = 0.1,
      barmode = "overlay",
      title = paste("Country:", countries()$name[match(country, countries()$code)]),
      margin = list(l = 50, r = 50, b = 100, t = 100, pad = 0),
      yaxis = list(title = list(text = "Age group", standoff = 10), automargin = TRUE),
      xaxis = list(
        title = list(text = "% of the male and of the female population", standoff = 3),
        range = c(-widest, widest),
        tickmode = "array",
        tickvals = ticks,
        ticktext = paste0(abs(ticks), "%")
      ),
      annotations = note,
      font = font_style
    ) %>%
    plotly::animation_opts(frame = 100, transition = 100, easing = "linear", redraw = TRUE, mode = "afterall") %>%
    plotly::layout(updatemenus = animation_buttons(levels(data$year)[1])) %>%
    year_slider() %>%
    plotly::config(responsive = TRUE) %>%
    keep_legend_clicks() %>%
    start_at_last_year()
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
#' @title The colors of the maps
#' @description golemworldbank's: red for the lowest value, white half way, and
#' dark blue for the highest, in 1000 steps.
#' @importFrom grDevices colorRampPalette
#' @noRd
map_colors <- colorRampPalette(c("#B2182B", "#FFFFFF", "#08306b"))(1000)
##########################################################################################
#
##########################################################################################
#' @title Map of countries or regions, animated by year
#' @description Colors the outlines of the NUTS classification by the value of
#' each year, on one color scale for all the years: as in golemworldbank, from
#' red for the lowest value through white, half way, to dark blue for the
#' highest, with dark borders, and titled "Indicator: " and its name.
#' @param data Data frame with `geo`, `year` and `value`.
#' @param info The row of the indicator in [indicators()].
#' @param level 0 for countries, 2 for regions.
#' @param label Name of each row, for the hover labels.
#' @return A plotly object.
#' @noRd
choropleth <- function(data, info, level, label) {
  heading <- chart_title(paste("Indicator:", info$name), 100)
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
    colors = map_colors,
    # plotly's dark gray borders, as in golemworldbank, thinner between the small regions
    marker = list(line = list(width = if (level == 0) 1 else 0.5, color = "#444")),
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
#' indicator, as in golemworldbank: from red for the lowest through white to
#' dark blue for the highest, on one scale for all the years.
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
#' by the value of the indicator, as in golemworldbank: from red for the lowest
#' through white to dark blue for the highest, on one scale for all the years.
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
#' @title The population of each country in each year of a chart
#' @description For the size of the bubbles of [plot_scatter()]: between two
#' years of `population`, in a straight line, and before its first or after its
#' last year, that of the nearest; `NA` for a country that it lacks.
#' @param rows Data frame with `geo` and `year`.
#' @param population Data frame from [get_indicator()], or `NULL`.
#' @return The population of each row.
#' @noRd
population_of <- function(rows, population) {
  out <- rep(NA_real_, nrow(rows))
  if (is.null(population)) {
    return(out)
  }
  population <- population[!is.na(population$value), ]
  for (g in intersect(unique(rows$geo), population$geo)) {
    known <- population[population$geo == g, ]
    at <- rows$geo == g
    out[at] <- if (nrow(known) == 1) {
      known$value
    } else {
      stats::approx(known$year, known$value, xout = rows$year[at], rule = 2, ties = mean)$y
    }
  }
  out
}
##########################################################################################
#
##########################################################################################
#' @title Scatter plot of two indicators, animated by year
#' @description As in golemworldbank, a bubble per country, as large as its
#' population, colored by its group (EU, EFTA, candidate), on axes that stay
#' the same for all the years; here with the code of the country over its
#' bubble, and the correlation of the two indicators across the countries of
#' each year.
#' @param x_data,y_data Data frames from [get_indicator()].
#' @param x_indicator,y_indicator The `id`s of the two indicators in
#'   [indicators()].
#' @param population Data frame of the population of the countries, from
#'   `get_indicator("population")`, for the size of the bubbles; `NULL`, or a
#'   country without it, for bubbles of the smallest size.
#' @return A plotly object, or `NULL` when the two indicators have no year in
#'   common.
#' @export
#' @examples
#' x <- data.frame(
#'   geo = c("EL", "BG", "DE", "NO"), country = c("Greece", "Bulgaria", "Germany", "Norway"),
#'   group = c("EU", "EU", "EU", "EFTA"), year = 2024, value = c(70, 66, 116, 130)
#' )
#' y <- transform(x, value = c(81.9, 75.9, 81.2, 83.4))
#' population <- transform(x, value = c(10.4e6, 6.4e6, 83.6e6, 5.6e6))
#' plot_scatter(x, y, "gdp_pps", "life_expectancy", population)
plot_scatter <- function(x_data, y_data, x_indicator, y_indicator, population = NULL) {
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
  both$population <- population_of(both, population)
  sized <- any(!is.na(both$population))
  smallest <- if (sized) min(both$population, na.rm = TRUE) else NA_real_
  both$population[is.na(both$population)] <- smallest
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
      value_x = -1e12, value_y = -1e12, real = FALSE, population = smallest
    ))
  }
  both <- both[order(both$year), ]
  both$year <- factor(both$year)
  both$group <- factor(both$group, levels = groups)
  both$label <- ifelse(both$real, both$geo, "")
  both$hover <- paste0(
    both$country, ", ", both$year, "<br>", x_info$name, ": ", format_value(both$value_x), " ", x_info$unit,
    "<br>", y_info$name, ": ", format_value(both$value_y), " ", y_info$unit,
    if (sized) paste0("<br>Population: ", format_value(both$population))
  )
  # the colors that plotly gives the groups, as it gives golemworldbank's regions, and bubbles a
  # little transparent, so that those under them show. As in golemworldbank, the diameter of a
  # bubble grows in a straight line with the population, from 10px; to 60px for the largest,
  # where golemworldbank's largest, China and India, take 100px and leave the others small,
  # which 100px for Germany and Turkey would not
  p <- withCallingHandlers(
    plotly::plot_ly(both,
      x = ~value_x,
      y = ~value_y,
      color = ~group,
      size = if (sized) ~population,
      sizes = c(10, 60),
      frame = ~year,
      ids = ~geo,
      text = ~label,
      type = "scatter",
      mode = "markers+text",
      textposition = "top center",
      marker = if (sized) list(sizemode = "diameter") else list(size = 10),
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
      # golemworldbank's pace, half a second a year
      plotly::animation_opts(frame = 500, easing = "linear", redraw = FALSE, mode = "afterall") %>%
      plotly::layout(updatemenus = animation_buttons(levels(both$year)[1])) %>%
      year_slider() %>%
      plotly::config(responsive = TRUE),
    # plotly gives the population to the width of the lines too, which a chart of bubbles has not
    warning = function(w) if (grepl("line.width", conditionMessage(w), fixed = TRUE)) invokeRestart("muffleWarning")
  )
  # and to the size of the codes: in the font of the chart instead, as before (smaller on phones)
  unsized <- function(traces) lapply(traces, function(t) {
    t$textfont$size <- NULL
    t
  })
  p$x$data <- unsized(p$x$data)
  for (k in seq_along(p$x$frames)) {
    p$x$frames[[k]]$data <- unsized(p$x$frames[[k]]$data)
  }
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
#' and its definition. As in golemworldbank, the table is one long page, which
#' can be searched and sorted.
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
    options = list(paging = FALSE, autoWidth = TRUE)
  )
}
