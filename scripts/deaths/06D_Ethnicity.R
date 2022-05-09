# Count the occurrences of each valid ethnicity defined
# in data validation
processed_data$deaths$ethn <- raw_data$deaths %>%
  filter(Ethnicity %in% data_validation$ethnicity) %>%
  count(Ethnicity, name = "Deaths")

# Create the chart title
chart_title <- make_graph_name(
  opening_strings$dt_ethn,
  raw_data$cases$Date.Received,
  processed_data$deaths$ethn$Deaths,
  check_wk = TRUE,
  sum(processed_data$dt_dod$Deaths)
)

# Create the graph and store it in a list of all graphs
plots$deaths$ethn <- plot_ly(
  processed_data$deaths$ethn,
  labels = ~Ethnicity,
  values = ~Deaths,
  type = 'pie',
  textposition = 'inside',
  textinfo = 'label+percent',
  insidetextfont = list(color = '#000000', size = 15),
  showlegend = FALSE,
  marker = list(
    colors = colors,
    line = list(color = '#FFFFFF', width = 2)
  ),
  text = ~Deaths,
  hovertemplate = paste(
    '<b>Ethnicity</b>: %{label}<br>',
    '<b>Deaths</b>: %{text}<br>',
    '<b>Percent</b>: %{percent}',
    '<extra></extra>',
    sep = ""
  ),
  hoverlabel = list(align = "left")
)

# Format the graph title and axes
plots$deaths$ethn <- layout(
  plots$deaths$ethn,
  title = list(text = chart_title, font = my_fonts$title),
  margin = list(l = 10, r = 10, b = 10, t = 60, pad = 15)
)
plots$deaths$ethn <- config(plots$deaths$ethn, displayModeBar = FALSE)

# Graph the plot
plots$deaths$ethn
