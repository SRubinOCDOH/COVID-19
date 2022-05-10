# Complete the data set by adding zeros for any non-occurring
# data, places zero for count if a row with the date received
# and zip code does not exist for graphing purposes.
processed_data$cases$zip_daily <- raw_data$cases %>%
  filter(Zip.Code %in% data_validation$zip_codes$Zip.Code) %>%
  select(c(Date.Received, Zip.Code)) %>%
  cbind(z = 1) %>%
  tidyr::complete(Date.Received, Zip.Code, fill = list(z = 0)) %>%
  group_by(Date.Received, Zip.Code) %>%
  summarise(Cases = sum(z))

# Add in town/city names to each row
# Filters out any data that does not match a valid zip code
processed_data$cases$zip_daily <- merge(processed_data$cases$zip_daily, data_validation$zip_codes, by = 'Zip.Code')

processed_data$cases$zip_daily <- processed_data$cases$zip_daily[order(processed_data$cases$zip_daily$Date.Received, decreasing = FALSE), ]

# Create the chart title
open_string <- "Confirmed Cases of COVID-19"
max_date <- format(as.Date(max(processed_data$cases$zip_daily$Date.Received)), "%B %d, %Y")
cases <- format(as.numeric(sum(processed_data$cases$zip_daily$Cases)), big.mark = ",")

chart_title <- str_glue('Confirmed Cases of COVID-19 by Municipality\nOrange County, NY as of {max_date}')

plots$cases$zip_daily <- plot_ly(
  processed_data$cases$zip_daily,
  x = ~Date.Received,
  y = ~Cases,
  type = 'scatter',
  mode = 'lines',
  line = list(color = my_colors$my_green),
  showlegend = FALSE,
  transforms = list(
    list(
      type = 'filter',
      target = ~Town.City,
      operation = '=',
      value = unique(processed_data$cases$zip_daily$Town.City)[1]
    )
  )
)

# Create the layout for the plot: title, axes, and dropdown list
plots$cases$zip_daily <- layout(
  plots$cases$zip_daily,
  title = list(text = chart_title, font = my_fonts$title),
  xaxis = list(text = "Date Received", my_fonts$axes),
  yaxis = list(text = "Cases", my_fonts$axes),
  margin = list(l = 10, r = 10, b = 10, t = 50, pad = 15),
  updatemenus = list(
    list(
      y = 1.1,
      x = -0.1,
      type = 'dropdown',
      buttons = with(
        data_validation$zip_codes,
        list(
          list(method = "restyle", args = list("transforms[0].value", Town.City[1]),  label = Town.City[1]),
          list(method = "restyle", args = list("transforms[0].value", Town.City[2]),  label = Town.City[2]),
          list(method = "restyle", args = list("transforms[0].value", Town.City[3]),  label = Town.City[3]),
          list(method = "restyle", args = list("transforms[0].value", Town.City[4]),  label = Town.City[4]),
          list(method = "restyle", args = list("transforms[0].value", Town.City[5]),  label = Town.City[5]),
          list(method = "restyle", args = list("transforms[0].value", Town.City[6]),  label = Town.City[6]),
          list(method = "restyle", args = list("transforms[0].value", Town.City[7]),  label = Town.City[7]),
          list(method = "restyle", args = list("transforms[0].value", Town.City[8]),  label = Town.City[8]),
          list(method = "restyle", args = list("transforms[0].value", Town.City[9]),  label = Town.City[9]),
          list(method = "restyle", args = list("transforms[0].value", Town.City[10]), label = Town.City[10]),
          list(method = "restyle", args = list("transforms[0].value", Town.City[11]), label = Town.City[11]),
          list(method = "restyle", args = list("transforms[0].value", Town.City[12]), label = Town.City[12]),
          list(method = "restyle", args = list("transforms[0].value", Town.City[13]), label = Town.City[13]),
          list(method = "restyle", args = list("transforms[0].value", Town.City[14]), label = Town.City[14]),
          list(method = "restyle", args = list("transforms[0].value", Town.City[15]), label = Town.City[15]),
          list(method = "restyle", args = list("transforms[0].value", Town.City[16]), label = Town.City[16]),
          list(method = "restyle", args = list("transforms[0].value", Town.City[17]), label = Town.City[17]),
          list(method = "restyle", args = list("transforms[0].value", Town.City[18]), label = Town.City[18]),
          list(method = "restyle", args = list("transforms[0].value", Town.City[19]), label = Town.City[19]),
          list(method = "restyle", args = list("transforms[0].value", Town.City[20]), label = Town.City[20]),
          list(method = "restyle", args = list("transforms[0].value", Town.City[21]), label = Town.City[21]),
          list(method = "restyle", args = list("transforms[0].value", Town.City[22]), label = Town.City[22]),
          list(method = "restyle", args = list("transforms[0].value", Town.City[23]), label = Town.City[23]),
          list(method = "restyle", args = list("transforms[0].value", Town.City[24]), label = Town.City[24]),
          list(method = "restyle", args = list("transforms[0].value", Town.City[25]), label = Town.City[25]),
          list(method = "restyle", args = list("transforms[0].value", Town.City[26]), label = Town.City[26]),
          list(method = "restyle", args = list("transforms[0].value", Town.City[27]), label = Town.City[27]),
          list(method = "restyle", args = list("transforms[0].value", Town.City[28]), label = Town.City[28]),
          list(method = "restyle", args = list("transforms[0].value", Town.City[29]), label = Town.City[29]),
          list(method = "restyle", args = list("transforms[0].value", Town.City[30]), label = Town.City[30]),
          list(method = "restyle", args = list("transforms[0].value", Town.City[31]), label = Town.City[31]),
          list(method = "restyle", args = list("transforms[0].value", Town.City[32]), label = Town.City[32]),
          list(method = "restyle", args = list("transforms[0].value", Town.City[33]), label = Town.City[33]),
          list(method = "restyle", args = list("transforms[0].value", Town.City[34]), label = Town.City[34]),
          list(method = "restyle", args = list("transforms[0].value", Town.City[35]), label = Town.City[35]),
          list(method = "restyle", args = list("transforms[0].value", Town.City[36]), label = Town.City[36]),
          list(method = "restyle", args = list("transforms[0].value", Town.City[37]), label = Town.City[37]),
          list(method = "restyle", args = list("transforms[0].value", Town.City[38]), label = Town.City[38]),
          list(method = "restyle", args = list("transforms[0].value", Town.City[39]), label = Town.City[39]),
          list(method = "restyle", args = list("transforms[0].value", Town.City[40]), label = Town.City[40]),
          list(method = "restyle", args = list("transforms[0].value", Town.City[41]), label = Town.City[41]),
          list(method = "restyle", args = list("transforms[0].value", Town.City[42]), label = Town.City[42]),
          list(method = "restyle", args = list("transforms[0].value", Town.City[43]), label = Town.City[43]),
          list(method = "restyle", args = list("transforms[0].value", Town.City[44]), label = Town.City[44]),
          list(method = "restyle", args = list("transforms[0].value", Town.City[45]), label = Town.City[45]),
          list(method = "restyle", args = list("transforms[0].value", Town.City[46]), label = Town.City[46]),
          list(method = "restyle", args = list("transforms[0].value", Town.City[47]), label = Town.City[47]),
          list(method = "restyle", args = list("transforms[0].value", Town.City[48]), label = Town.City[48]),
          list(method = "restyle", args = list("transforms[0].value", Town.City[49]), label = Town.City[49]),
          list(method = "restyle", args = list("transforms[0].value", Town.City[50]), label = Town.City[50]),
          list(method = "restyle", args = list("transforms[0].value", Town.City[51]), label = Town.City[51])
        )
      )
    )
  )
)

#Disable mode bar on graph
plots$cases$zip_daily <- config(plots$cases$zip_daily, displayModeBar = FALSE)

plots$cases$zip_daily
