# Count the occurrences of each valid age group defined
# in data validation
processed_data$deaths$age_gr <- raw_data$deaths %>%
  filter(!is.na(Age.Group)) %>%
  count(Age.Group, name = "Deaths")

# Create the chart title
chart_title <- make_graph_name(
  opening_strings$dt_age_gr,
  raw_data$cases$Date.Received,
  processed_data$deaths$age_gr$Deaths,
  check_wk = TRUE,
  sum(processed_data$dt_dod$Deaths)
)

y_max <- max(processed_data$deaths$age_gr$Deaths) * 1.05

# Create the graph and store it in a list of all graphs
plots$deaths$age_gr <-
  create_plotly_bar(
    processed_data$deaths$age_gr,
    processed_data$deaths$age_gr$Age.Group,
    processed_data$deaths$age_gr$Deaths,
    "Age Group"
  )

# Format the graph title and axes
plots$deaths$age_gr <-
  format_plotly(
    plots$deaths$age_gr,
    chart_title,
    "Age Group",
    "Deaths",
    "category ascending",
    y_max
  )

# Graph the plot
plots$deaths$age_gr