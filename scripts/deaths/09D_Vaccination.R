# Count the occurrences of each valid vaccination status
# defined in data validation
processed_data$deaths$vacc <- raw_data$deaths %>%
  filter(Vaccinated %in% data_validation$vaccination &
           as.Date(Date.of.Death) >= as.Date("2021-01-01")) %>%
  count(Vaccinated, name = "Deaths")

# Create the chart title
chart_title <- make_graph_name(
  opening_strings$dt_vacc,
  raw_data$cases$Date.Received,
  processed_data$deaths$vacc$Deaths,
  check_wk = TRUE,
  sum(processed_data$dt_dod$Deaths)
)

y_max <- max(processed_data$deaths$vacc$Deaths) * 1.05

# Create the graph and store it in a list of all graphs
plots$deaths$vacc <- plot_ly(
  processed_data$deaths$vacc,
  labels = ~Vaccinated,
  values = ~Deaths,
  type = 'pie',
  textposition = 'inside',
  textinfo = 'label+percent',
  insidetextfont = list(color = '#000000', size = 15),
  showlegend = FALSE,
  marker = list(
    colors = colors,
    line = list(color = '#FFFFFF', width = 2)
  )
)

# Format the graph title and axes
plots$deaths$vacc <- layout(
  plots$deaths$vacc,
  title = list(text = chart_title, font = my_fonts$title),
  margin = list(l = 10, r = 10, b = 10, t = 60, pad = 15)
)
plots$deaths$vacc <- config(plots$deaths$vacc, displayModeBar = FALSE)

# Graph the plot
plots$deaths$vacc