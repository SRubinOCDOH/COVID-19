# Count the occurrences of each valid ethnicity defined
# in data validation
processed_data$cases$ethn <- raw_data$cases %>%
  filter(Ethnicity %in% data_validation$ethnicity) %>%
  count(Ethnicity, name = "Cases")

# Create the chart title
chart_title <- make_graph_name(
  opening_strings$cs_ethn,
  raw_data$cases$Date.Received,
  processed_data$cases$ethn$Cases,
  check_wk = TRUE,
  sum(processed_data$daily$Cases)
)

plots$cases$ethn <- plot_ly(
  processed_data$cases$ethn,
  labels = ~Ethnicity,
  values = ~Cases,
  type = 'pie',
  textposition = 'inside',
  textinfo = 'label+percent',
  insidetextfont = list(color = '#000000', size = 15),
  showlegend = FALSE,
  marker = list(
    colors = colors,
    line = list(color = '#FFFFFF', width = 2)
  ),
  text = ~Cases,
  hovertemplate = paste(
    '<b>Ethnicity</b>: %{label}<br>',
    '<b>Cases</b>: %{text}<br>',
    '<b>Percent</b>: %{percent}',
    '<extra></extra>',
    sep = ""
  ),
  hoverlabel = list(align = "left")
)

plots$cases$ethn <- layout(
  plots$cases$ethn,
  title = list(text = chart_title, font = my_fonts$title),
  margin = list(l = 10, r = 10, b = 10, t = 60, pad = 15)
)

plots$cases$ethn <- config(plots$cases$ethn, displayModeBar = FALSE)

plots$cases$ethn