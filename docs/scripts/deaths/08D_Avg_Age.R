# Count the occurrences of each valid age group defined
# in data validation
processed_data$deaths$avg_age <- raw_data$deaths %>%
  filter(!is.na(Age.At.Death)) %>%
  select(c(Age.At.Death))

# Create the chart title
chart_title <- make_graph_name(
  opening_strings$dt_avg_age,
  raw_data$deaths$Date.of.Death,
  processed_data$deaths$age_gr$Deaths,
  check_wk = TRUE,
  sum(processed_data$dt_dod$Deaths)
)

# Create the graph and store it in a list of all graphs
plots$deaths$avg_age <- plot_ly(
  processed_data$deaths$avg_age,
  domain = list(x = c(0, 1), y= c(0, 1)),
  value = mean(processed_data$deaths$avg_age$Age.At.Death),
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
      color = my_colors$my_orange,
      thickness = 1
    ),
    borderwidth = 3
  )
)

plots$deaths$avg_age <- layout(
  plots$deaths$avg_age,
  margin = list(l = 30, r = 30, b = 10, t = 60, pad = 15)
)

#Disable mode bar on graph
plots$deaths$avg_age <- config(plots$deaths$avg_age, displayModeBar = FALSE)

# Graph the plot
plots$deaths$avg_age