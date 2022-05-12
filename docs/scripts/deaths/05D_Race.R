# Count the occurrences of each valid race defined
# in data validation
processed_data$deaths$race <- raw_data$deaths %>%
  filter(Race %in% data_validation$race) %>%
  count(Race, name = "Deaths")

# Format the text with new lines for the x-axis labels on the plot
processed_data$deaths$race$Title <- gsub("/", "/\n", processed_data$deaths$race$Race)

# Create the chart title
chart_title <- make_graph_name(
  opening_strings$dt_race,
  raw_data$cases$Date.Received,
  processed_data$deaths$race$Deaths,
  check_wk = TRUE,
  sum(processed_data$deaths$dod$Deaths)
)

y_max <- max(processed_data$deaths$race$Deaths) * 1.05

# Create the graph and store it in a list of all graphs
plots$deaths$race <-
  create_plotly_bar(
    processed_data$deaths$race,
    processed_data$deaths$race$Title,
    processed_data$deaths$race$Deaths,
    "Race"
  )

# Format the graph title and axes
plots$deaths$race <-
  format_plotly(
    plots$deaths$race,
    chart_title,
    "Race",
    "Deaths",
    "total descending",
    y_max
  )

# Graph the plot
plots$deaths$race
