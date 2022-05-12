# Count the occurrences of each valid age group defined
# in data validation
processed_data$cases$age_gr <- raw_data$cases %>%
  filter(!is.na(Age.Group)) %>%
  count(Age.Group, name = "Cases")

# Create the chart title
chart_title <- make_graph_name(
  opening_strings$cs_age_gr,
  raw_data$cases$Date.Received,
  processed_data$cases$age_gr$Cases,
  check_wk = TRUE,
  sum(processed_data$cases$daily$Cases)
)

y_max <- max(processed_data$cases$age_gr$Cases) * 1.05

# Create the graph and store it in a list of all graphs
plots$cases$age_gr <-
  create_plotly_bar(
    processed_data$cases$age_gr,
    processed_data$cases$age_gr$Age.Group,
    processed_data$cases$age_gr$Cases,
    "Age Group"
  )

# Format the graph title and axes
plots$cases$age_gr <-
  format_plotly(
    plots$cases$age_gr,
    chart_title,
    "Age Group",
    "Cases",
    "category ascending",
    y_max
  )

# Graph the plot
plots$cases$age_gr