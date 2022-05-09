# Count cases for each unique value in column `Investigation Start Date`
processed_data$cases$daily <- raw_data$cases %>%
  count(Date.Received, name = "Cases") %>%
  mutate(Date.Received = as.Date(Date.Received)) %>%
  tidyr::complete(
    Date.Received = seq.Date(
      min(Date.Received),
      max(Date.Received),
      by =  "day"),
    fill = list(Cases = 0)
  )

# Create the chart title
chart_title <- make_graph_name(
  opening_strings$cs_daily,
  processed_data$cases$daily$Date.Received,
  processed_data$cases$daily$Cases,
  check_wk = FALSE,
  sum(processed_data$cases$daily$Cases)
)

y_max <- max(processed_data$cases$daily$Cases) * 1.05

# Create the graph and store it in a list of all graphs
plots$cases$daily <- create_plotly_line(
  processed_data$cases$daily,
  processed_data$cases$daily$Date.Received,
  processed_data$cases$daily$Cases,
  my_colors$my_green,
  "Date Received"
)

# Format the graph title and axes
plots$cases$daily <- format_plotly(
  plots$cases$daily,
  chart_title,
  "Date Received",
  "Cases",
  "trace",
  y_max
)

# Graph the plot
plots$cases$daily