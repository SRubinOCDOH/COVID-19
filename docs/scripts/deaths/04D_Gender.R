# Count the occurrences of each valid gender defined
# in data validation
processed_data$deaths$gender <- raw_data$deaths %>%
  filter(Gender %in% data_validation$gender) %>%
  count(Gender, name = "Deaths")

# Create the chart title
chart_title <- make_graph_name(
  opening_strings$dt_gender,
  raw_data$cases$Date.Received,
  processed_data$deaths$gender$Deaths,
  check_wk = TRUE,
  sum(processed_data$deaths$dod$Deaths)
)

# Create the graph and store it in a list of all graphs
plots$deaths$gender <- plot_ly(
  processed_data$deaths$gender,
  labels = ~Gender,
  values = ~Deaths,
  type = 'pie',
  textposition = 'inside',
  textinfo = 'label+percent',
  insidetextfont = list(color = '#000000', size = 15),
  showlegend = FALSE,
  marker = list(
    colors = c(my_colors$my_red, my_colors$my_blue),
    line = list(color = '#FFFFFF', width = 2)
  ),
  text = ~Deaths,
  hovertemplate = paste(
    '<b>Gender</b>: %{label}<br>',
    '<b>Deaths</b>: %{text}<br>',
    '<b>Percent</b>: %{percent}',
    '<extra></extra>',
    sep = ""
  ),
  hoverlabel = list(align = "left")
)

# Format the graph title and axes
plots$deaths$gender <- layout(
  plots$deaths$gender,
  title = list(text = chart_title, font = my_fonts$title),
  margin = list(l = 10, r = 10, b = 10, t = 60, pad = 15)
)
plots$deaths$gender <- config(plots$deaths$gender, displayModeBar = FALSE)

# Graph the plot
plots$deaths$gender