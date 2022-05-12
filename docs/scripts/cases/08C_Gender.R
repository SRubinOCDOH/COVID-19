# Count the occurrences of each valid gender defined
# in data validation
processed_data$cases$gender <- raw_data$cases %>%
  filter(Gender %in% data_validation$gender) %>%
  count(Gender, name = "Cases")

# Create the chart title
chart_title <- make_graph_name(
  opening_strings$cs_gender,
  raw_data$cases$Date.Received,
  processed_data$cases$gender$Cases,
  check_wk = TRUE,
  sum(processed_data$cases$daily$Cases)
)

plots$cases$gender <- plot_ly(
  processed_data$cases$gender,
  labels = ~Gender,
  values = ~Cases,
  type = 'pie',
  textposition = 'inside',
  textinfo = 'label+percent',
  insidetextfont = list(color = '#000000', size = 15),
  showlegend = FALSE,
  marker = list(
    colors = c(my_colors$my_red, my_colors$my_blue),
    line = list(color = '#FFFFFF', width = 2)
  ),
  text = ~Cases,
  hovertemplate = paste(
    '<b>Gender</b>: %{label}<br>',
    '<b>Cases</b>: %{text}<br>',
    '<b>Percent</b>: %{percent}',
    '<extra></extra>',
    sep = ""
  ),
  hoverlabel = list(align = "left")
)

plots$cases$gender <- layout(
  plots$cases$gender,
  title = list(text = chart_title, font = my_fonts$title),
  margin = list(l = 10, r = 10, b = 10, t = 60, pad = 15)
)

plots$cases$gender <- config(plots$cases$gender, displayModeBar = FALSE)

plots$cases$gender