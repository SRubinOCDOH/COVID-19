# Count cases for each unique value in column `Date.Received`
# where symptom status is not empty: this indicates an
# asymptomatic case
processed_data$cases$asymp <- raw_data$cases %>% 
  filter(!is.na(Symptom.Status)) %>% 
  count(Date.Received, Symptom.Status, name = "Cases") %>%
  mutate(Date.Received = as.Date(Date.Received)) %>%
  tidyr::complete(
    Date.Received = seq.Date(min(Date.Received), max(Date.Received), by =  "day"),
    fill = list(Cases = 0)
  )

# Create the chart title
chart_title <- make_graph_name(
  opening_strings$cs_asymp,
  processed_data$cases$asymp$Date.Received,
  processed_data$cases$asymp$Cases,
  check_wk = FALSE,
  sum(processed_data$daily$Cases)
)

y_max <- max(processed_data$cases$asymp$Cases) * 1.05

# Create the graph and store it in a list of all graphs
plots$cases$asymp <-
  create_plotly_line(
    processed_data$cases$asymp,
    processed_data$cases$asymp$Date.Received,
    processed_data$cases$asymp$Cases,
    my_colors$my_orange,
    "Date Received"
  )

# Format the graph title and axes
plots$cases$asymp <- format_plotly(
  plots$cases$asymp,
  chart_title,
  "Date Received",
  "Cases",
  "trace",
  y_max
)

# Graph the plot
plots$cases$asymp