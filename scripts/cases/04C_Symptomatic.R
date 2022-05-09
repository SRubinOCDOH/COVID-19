# Count cases for each unique value in column `Symptom.Onset`
processed_data$cases$symp <- raw_data$cases %>%
  filter(!is.na(Symptom.Onset)) %>%
  count(Symptom.Onset, name = "Cases") %>%
  mutate(Symptom.Onset = as.Date(Symptom.Onset)) %>%
  tidyr::complete(
    Symptom.Onset = seq.Date(
      min(Symptom.Onset),
      max(Symptom.Onset),
      by =  "day"),
    fill = list(Cases = 0)
  )

# Create the chart title
chart_title <- make_graph_name(
  opening_strings$cs_symp,
  processed_data$cases$symp$Symptom.Onset,
  processed_data$cases$symp$Cases,
  check_wk = FALSE,
  sum(processed_data$daily$Cases)
)

y_max <- max(processed_data$cases$symp$Cases) * 1.05

# Create the graph and store it in a list of all graphs
plots$cases$symp <- create_plotly_line(
  processed_data$cases$symp,
  processed_data$cases$symp$Symptom.Onset,
  processed_data$cases$symp$Cases,
  my_colors$my_purple,
  "Symptom Onset"
)

# Format the graph title and axes
plots$cases$symp <- format_plotly(
  plots$cases$symp,
  chart_title,
  "Symptom Onset",
  "Cases",
  "trace",
  y_max
  )

# Graph the plot
plots$cases$symp