# Count Deaths for each unique value in column `Date of Death`
processed_data$deaths$dod <- raw_data$deaths %>%
  count(Date.of.Death, name = "Deaths") %>%
  mutate(Date.of.Death = as.Date(Date.of.Death)) %>%
  tidyr::complete(
    Date.of.Death = seq.Date(
      min(Date.of.Death),
      max(Date.of.Death),
      by =  "day"),
    fill = list(Deaths = 0)
  )

# Create the chart title
chart_title <- make_graph_name(
  opening_strings$dt_dod,
  raw_data$cases$Date.Received,
  processed_data$deaths$dod$Deaths,
  check_wk = FALSE,
  sum(processed_data$deaths$dod$Deaths)
)

y_max <- max(processed_data$deaths$dod$Deaths) * 1.05

# Create the graph and store it in a list of all graphs
plots$deaths$dod <- create_plotly_line(
  processed_data$deaths$dod,
  processed_data$deaths$dod$Date.of.Death,
  processed_data$deaths$dod$Deaths,
  my_colors$my_green,
  "Date Received"
)

# Format the graph title and axes
plots$deaths$dod <- format_plotly(
  plots$deaths$dod,
  chart_title,
  "Date of Deaths",
  "Deaths",
  "trace",
  y_max
)

# Graph the plot
plots$deaths$dod