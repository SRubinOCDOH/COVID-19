# Count the occurrences of each valid age group defined
# in data validation
processed_data$cases$avg_age <- raw_data$cases %>%
  filter(!is.na(Age)) %>%
  select(c(Age))

# Create the chart title
chart_title <- make_graph_name(
  opening_strings$cs_avg_age,
  raw_data$cases$Date.Received,
  processed_data$cases$age_gr$Cases,
  check_wk = TRUE,
  sum(processed_data$daily$Cases)
)

# Create the graph and store it in a list of all graphs
plots$cases$avg_age <- plot_ly(
  processed_data$cases$avg_age,
  domain = list(x = c(0, 1), y= c(0, 1)),
  value = mean(processed_data$cases$avg_age$Age),
  title = list(text = chart_title, font = my_fonts$title),
  type = "indicator",
  mode = "gauge+number",
  gauge = list(
    axis = list(
      range = list(0, 100), 
      dtick = 5,
      tickwidth = 3
    ),
    bar = list(
      color = my_colors$my_green,
      thickness = 1
    ),
    borderwidth = 3
  )
)

plots$cases$avg_age <- layout(
  plots$cases$avg_age,
  margin = list(l = 30, r = 30, b = 10, t = 60, pad = 15)
)

#Disable mode bar on graph
plots$cases$avg_age <- config(plots$cases$avg_age, displayModeBar = FALSE)

# Graph the plot
plots$cases$avg_age
