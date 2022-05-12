# Count the occurrences of each valid race defined
# in data validation
processed_data$cases$race <- raw_data$cases %>%
  filter(Race %in% data_validation$race) %>%
  count(Race, name = "Cases")

# Format the text with new lines for the x-axis labels on the plot
processed_data$cases$race$Title <- gsub("/", "/\n", processed_data$cases$race$Race)

# Create the chart title
chart_title <- make_graph_name(
  opening_strings$cs_race,
  raw_data$cases$Date.Received,
  processed_data$cases$race$Cases,
  check_wk = TRUE,
  sum(processed_data$cases$daily$Cases)
)

y_max <- max(processed_data$cases$race$Cases) * 1.05

# Create the graph and store it in a list of all graphs
plots$cases$race <-
  create_plotly_bar(
    processed_data$cases$race,
    processed_data$cases$race$Title,
    processed_data$cases$race$Cases,
    "Race"
  )

# Format the graph title and axes
plots$cases$race <-
  format_plotly(
    plots$cases$race,
    chart_title,
    "Race",
    "Cases",
    "total descending",
    y_max
  )

# Graph the plot
plots$cases$race