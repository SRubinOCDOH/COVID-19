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
max_date <- format(as.Date(max(processed_data$cases$zip_daily$Date.Received)), "%B %d, %Y")
cases <- format(as.numeric(sum(processed_data$cases$zip_daily$Cases)), big.mark = ",")

y_max <- max(processed_data$cases$zip_daily$Cases) * 1.05

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

plots$cases$zip_daily <- layout(
  plots$cases$zip_daily,
  updatemenus = list(
    list(
      type = 'dropdown',
      active = 0,
      buttons = list(
        list(method = "restyle",
             args = list("transforms[0].value", unique(data_validation$zip_codes$Town.City)[1]),
             label = unique(data_validation$zip_codes$Town.City)[1]),
        list(method = "restyle",
             args = list("transforms[0].value", unique(data_validation$zip_codes$Town.City)[2]),
             label = unique(data_validation$zip_codes$Town.City)[2]),
        list(method = "restyle",
             args = list("transforms[0].value", unique(data_validation$zip_codes$Town.City)[3]),
             label = unique(data_validation$zip_codes$Town.City)[3]),
        list(method = "restyle",
             args = list("transforms[0].value", unique(data_validation$zip_codes$Town.City)[4]),
             label = unique(data_validation$zip_codes$Town.City)[4]),
        list(method = "restyle",
             args = list("transforms[0].value", unique(data_validation$zip_codes$Town.City)[5]),
             label = unique(data_validation$zip_codes$Town.City)[5]),
        list(method = "restyle",
             args = list("transforms[0].value", unique(data_validation$zip_codes$Town.City)[6]),
             label = unique(data_validation$zip_codes$Town.City)[6]),
        list(method = "restyle",
             args = list("transforms[0].value", unique(data_validation$zip_codes$Town.City)[7]),
             label = unique(data_validation$zip_codes$Town.City)[7]),
        list(method = "restyle",
             args = list("transforms[0].value", unique(data_validation$zip_codes$Town.City)[8]),
             label = unique(data_validation$zip_codes$Town.City)[8]),
        list(method = "restyle",
             args = list("transforms[0].value", unique(data_validation$zip_codes$Town.City)[9]),
             label = unique(data_validation$zip_codes$Town.City)[9]),
        list(method = "restyle",
             args = list("transforms[0].value", unique(data_validation$zip_codes$Town.City)[10]),
             label = unique(data_validation$zip_codes$Town.City)[10]),
        list(method = "restyle",
             args = list("transforms[0].value", unique(data_validation$zip_codes$Town.City)[11]),
             label = unique(data_validation$zip_codes$Town.City)[11]),
        list(method = "restyle",
             args = list("transforms[0].value", unique(data_validation$zip_codes$Town.City)[12]),
             label = unique(data_validation$zip_codes$Town.City)[12]),
        list(method = "restyle",
             args = list("transforms[0].value", unique(data_validation$zip_codes$Town.City)[13]),
             label = unique(data_validation$zip_codes$Town.City)[13]),
        list(method = "restyle",
             args = list("transforms[0].value", unique(data_validation$zip_codes$Town.City)[14]),
             label = unique(data_validation$zip_codes$Town.City)[14]),
        list(method = "restyle",
             args = list("transforms[0].value", unique(data_validation$zip_codes$Town.City)[15]),
             label = unique(data_validation$zip_codes$Town.City)[15]),
        list(method = "restyle",
             args = list("transforms[0].value", unique(data_validation$zip_codes$Town.City)[16]),
             label = unique(data_validation$zip_codes$Town.City)[16]),
        list(method = "restyle",
             args = list("transforms[0].value", unique(data_validation$zip_codes$Town.City)[17]),
             label = unique(data_validation$zip_codes$Town.City)[17]),
        list(method = "restyle",
             args = list("transforms[0].value", unique(data_validation$zip_codes$Town.City)[18]),
             label = unique(data_validation$zip_codes$Town.City)[18]),
        list(method = "restyle",
             args = list("transforms[0].value", unique(data_validation$zip_codes$Town.City)[19]),
             label = unique(data_validation$zip_codes$Town.City)[19]),
        list(method = "restyle",
             args = list("transforms[0].value", unique(data_validation$zip_codes$Town.City)[20]),
             label = unique(data_validation$zip_codes$Town.City)[20]),
        list(method = "restyle",
             args = list("transforms[0].value", unique(data_validation$zip_codes$Town.City)[21]),
             label = unique(data_validation$zip_codes$Town.City)[21]),
        list(method = "restyle",
             args = list("transforms[0].value", unique(data_validation$zip_codes$Town.City)[22]),
             label = unique(data_validation$zip_codes$Town.City)[22]),
        list(method = "restyle",
             args = list("transforms[0].value", unique(data_validation$zip_codes$Town.City)[23]),
             label = unique(data_validation$zip_codes$Town.City)[23]),
        list(method = "restyle",
             args = list("transforms[0].value", unique(data_validation$zip_codes$Town.City)[24]),
             label = unique(data_validation$zip_codes$Town.City)[24]),
        list(method = "restyle",
             args = list("transforms[0].value", unique(data_validation$zip_codes$Town.City)[25]),
             label = unique(data_validation$zip_codes$Town.City)[25]),
        list(method = "restyle",
             args = list("transforms[0].value", unique(data_validation$zip_codes$Town.City)[26]),
             label = unique(data_validation$zip_codes$Town.City)[26]),
        list(method = "restyle",
             args = list("transforms[0].value", unique(data_validation$zip_codes$Town.City)[27]),
             label = unique(data_validation$zip_codes$Town.City)[27]),
        list(method = "restyle",
             args = list("transforms[0].value", unique(data_validation$zip_codes$Town.City)[28]),
             label = unique(data_validation$zip_codes$Town.City)[28]),
        list(method = "restyle",
             args = list("transforms[0].value", unique(data_validation$zip_codes$Town.City)[29]),
             label = unique(data_validation$zip_codes$Town.City)[29]),
        list(method = "restyle",
             args = list("transforms[0].value", unique(data_validation$zip_codes$Town.City)[30]),
             label = unique(data_validation$zip_codes$Town.City)[30]),
        list(method = "restyle",
             args = list("transforms[0].value", unique(data_validation$zip_codes$Town.City)[31]),
             label = unique(data_validation$zip_codes$Town.City)[31]),
        list(method = "restyle",
             args = list("transforms[0].value", unique(data_validation$zip_codes$Town.City)[32]),
             label = unique(data_validation$zip_codes$Town.City)[32]),
        list(method = "restyle",
             args = list("transforms[0].value", unique(data_validation$zip_codes$Town.City)[33]),
             label = unique(data_validation$zip_codes$Town.City)[33]),
        list(method = "restyle",
             args = list("transforms[0].value", unique(data_validation$zip_codes$Town.City)[34]),
             label = unique(data_validation$zip_codes$Town.City)[34]),
        list(method = "restyle",
             args = list("transforms[0].value", unique(data_validation$zip_codes$Town.City)[35]),
             label = unique(data_validation$zip_codes$Town.City)[35]),
        list(method = "restyle",
             args = list("transforms[0].value", unique(data_validation$zip_codes$Town.City)[36]),
             label = unique(data_validation$zip_codes$Town.City)[36]),
        list(method = "restyle",
             args = list("transforms[0].value", unique(data_validation$zip_codes$Town.City)[37]),
             label = unique(data_validation$zip_codes$Town.City)[37]),
        list(method = "restyle",
             args = list("transforms[0].value", unique(data_validation$zip_codes$Town.City)[38]),
             label = unique(data_validation$zip_codes$Town.City)[38]),
        list(method = "restyle",
             args = list("transforms[0].value", unique(data_validation$zip_codes$Town.City)[39]),
             label = unique(data_validation$zip_codes$Town.City)[39]),
        list(method = "restyle",
             args = list("transforms[0].value", unique(data_validation$zip_codes$Town.City)[40]),
             label = unique(data_validation$zip_codes$Town.City)[40]),
        list(method = "restyle",
             args = list("transforms[0].value", unique(data_validation$zip_codes$Town.City)[41]),
             label = unique(data_validation$zip_codes$Town.City)[41]),
        list(method = "restyle",
             args = list("transforms[0].value", unique(data_validation$zip_codes$Town.City)[42]),
             label = unique(data_validation$zip_codes$Town.City)[42]),
        list(method = "restyle",
             args = list("transforms[0].value", unique(data_validation$zip_codes$Town.City)[43]),
             label = unique(data_validation$zip_codes$Town.City)[43]),
        list(method = "restyle",
             args = list("transforms[0].value", unique(data_validation$zip_codes$Town.City)[44]),
             label = unique(data_validation$zip_codes$Town.City)[44]),
        list(method = "restyle",
             args = list("transforms[0].value", unique(data_validation$zip_codes$Town.City)[45]),
             label = unique(data_validation$zip_codes$Town.City)[45]),
        list(method = "restyle",
             args = list("transforms[0].value", unique(data_validation$zip_codes$Town.City)[46]),
             label = unique(data_validation$zip_codes$Town.City)[46]),
        list(method = "restyle",
             args = list("transforms[0].value", unique(data_validation$zip_codes$Town.City)[47]),
             label = unique(data_validation$zip_codes$Town.City)[47]),
        list(method = "restyle",
             args = list("transforms[0].value", unique(data_validation$zip_codes$Town.City)[48]),
             label = unique(data_validation$zip_codes$Town.City)[48]),
        list(method = "restyle",
             args = list("transforms[0].value", unique(data_validation$zip_codes$Town.City)[49]),
             label = unique(data_validation$zip_codes$Town.City)[49]),
        list(method = "restyle",
             args = list("transforms[0].value", unique(data_validation$zip_codes$Town.City)[50]),
             label = unique(data_validation$zip_codes$Town.City)[50]),
        list(method = "restyle",
             args = list("transforms[0].value", unique(data_validation$zip_codes$Town.City)[51]),
             label = unique(data_validation$zip_codes$Town.City)[51])
      )
    )
  )
)

plots$cases$zip_daily
