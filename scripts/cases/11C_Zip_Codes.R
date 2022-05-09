# Get and sort the top 20 towns by count of Cases
processed_data$cases$top_zip <-
  raw_data$cases %>% count(Zip.Code, name = "Cases")

# Merging removes any row that does not have a valid zip code
# as per guide_zip_codes
processed_data$cases$top_zip <-
  merge(processed_data$cases$top_zip, data_validation$zip_codes, by = 'Zip.Code')
processed_data$cases$top_zip <- top_n(processed_data$cases$top_zip, 20, Cases)
processed_data$cases$top_zip <-
  processed_data$cases$top_zip[order(processed_data$cases$top_zip$Cases,
                               decreasing = TRUE),]

# Create the chart title
chart_title <- make_graph_name(
  opening_strings$cs_top_zip,
  raw_data$cases$Date.Received,
  processed_data$cases$top_zip$Cases,
  check_wk = FALSE,
  sum(processed_data$daily$Cases)
)

y_max <- max(processed_data$cases$top_zip$Cases) * 1.05

# Create the graph and store it in a list of all graphs
plots$cases$top_zip <-
  create_plotly_bar(
    processed_data$cases$top_zip,
    processed_data$cases$top_zip$Town.City,
    processed_data$cases$top_zip$Cases,
    "City/Town"
  )

# Format the graph title and axes
plots$cases$top_zip <-
  format_plotly(
    plots$cases$top_zip,
    chart_title,
    "City/Town",
    "Cases",
    "total descending",
    y_max
  )

# Graph the plot
plots$cases$top_zip