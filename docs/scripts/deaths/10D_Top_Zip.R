# Get and sort the top 20 towns by count of Deaths
processed_data$deaths$top_zip <- raw_data$deaths %>%
  count(Zip.Code, name = "Deaths")

# Merging removes any row that does not have a valid zip code
# as per guide_zip_codes
processed_data$deaths$top_zip <- merge(processed_data$deaths$top_zip, data_validation$zip_codes, by = 'Zip.Code')
processed_data$deaths$top_zip <- top_n(processed_data$deaths$top_zip, 20, Deaths)
processed_data$deaths$top_zip <- processed_data$deaths$top_zip[order(processed_data$deaths$top_zip$Deaths, decreasing = TRUE),]

# Create the chart title
chart_title <- make_graph_name(
  opening_strings$dt_top_zip,
  raw_data$cases$Date.Received,
  processed_data$deaths$top_zip$Deaths,
  check_wk = FALSE,
  0
)

y_max <- max(processed_data$deaths$top_zip$Deaths) * 1.05

# Create the graph and store it in a list of all graphs
plots$deaths$top_zip <-
  create_plotly_bar(
    processed_data$deaths$top_zip,
    processed_data$deaths$top_zip$Town.City,
    processed_data$deaths$top_zip$Deaths,
    "City/Town"
  )

# Format the graph title and axes
plots$deaths$top_zip <-
  format_plotly(
    plots$deaths$top_zip,
    chart_title,
    "City/Town",
    "Cases",
    "total descending",
    y_max
  )

# Graph the plot
plots$deaths$top_zip