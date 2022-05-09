make_graph_name <- function(opening_string, date_column,
                            cases_column, check_wk, total) {
  max_date <- format(as.Date(max(date_column)), "%B %d, %Y")
  cases <- format(as.numeric(sum(cases_column)), big.mark = ",")
  
  if (check_wk && sum(cases_column) < total) {
    opening_string <- paste(opening_string, "Where Known")
    
    temp_title <- str_glue('{opening_string}\nOrange County, NY as of {max_date} (n={cases})')
  }
  else {
    temp_title <- str_glue('{opening_string}\nOrange County, NY as of {max_date} (n={cases})')
  }
  
  return(temp_title)
}

# Function for creating plot_ly line graphs using the plotly package
# Arguments passed to function to set up graph values dynamically
create_plotly_line <- function(temp_data, x_value, y_value,
                               line_color, x_label) {
  temp_plot <- temp_data %>% plot_ly(
    x = x_value,
    y = y_value,
    type = 'scatter',
    mode = 'lines',
    line = list(color = line_color),
    showlegend = FALSE,
    text = x_label,
    hovertemplate = paste(
      '<b>%{text}</b>: %{x}',
      '<br><b>Cases</b>: %{y:,}',
      '<extra></extra>'
    )
  )
}

# Function for creating plot_ly bar graphs using the plotly package
# Arguments passed to function to set up graph values dynamically
create_plotly_bar <- function(temp_data, x_value, y_value, x_label) {
  temp_plot <- plot_ly(
    temp_data,
    x = x_value,
    y = y_value,
    type = 'bar',
    color = x_value,
    showlegend = FALSE,
    hovertemplate = paste(
      '<b>', x_label, '</b>: %{x}',
      '<br><b>Cases</b>: %{y:,}',
      '<extra></extra>',
      sep = ""
    )
  )
  
  # Add data labels
  temp_plot <- add_text(
    temp_plot,
    text = y_value,
    textposition = "top"
  )
}

format_plotly <- function(temp_plot, temp_title, x_label,
                          y_label, order_type, y_max) {
  # Set the plot formatting
  temp_plot <- temp_plot %>% layout(
    title = list(text = temp_title, font = my_fonts$title),
    xaxis = list(title = x_label, font = my_fonts$axes,
                 categoryorder = order_type),
    yaxis = list(title = y_label, font = my_fonts$axes,
                 range = c(0, y_max)),
    margin = list(l = 10, r = 10, b = 10, t = 50, pad = 15)
  )
  
  #Disable mode bar on graph
  temp_plot <- config(temp_plot, displayModeBar = FALSE)
}

# Function to download and activate all necessary packages
# for this project to run properly
get_dependencies <- function(...) {
  libs <- unlist(list(...))
  req <- unlist(lapply(libs, require, character.only = TRUE))
  need <- libs[req == FALSE]
  
  if (length(need) > 0) {
    install.packages(need)
    lapply(need, require, character.only = TRUE)
  }
}

# Function to be called to obtain raw data from the excel files
# in the data folder
get_raw_data <- function() {
  temp_data <- list(
    # A table of all confirmed cases of COVID-19 within Orange County, NY
    cases = read_xlsx(
      "data/raw/Line List of Confirmed Cases and Deaths.xlsx",
      sheet = "Confirmed Cases",
      .name_repair = "universal",
      col_types = c(
        "date", "numeric", "text", "text",
        "text", "text",    "text", "text",
        "text", "text",    "text", "date",
        "text", "text",    "text", "text",
        "date", "date",    "text", "text"
      )
    ),
    # A table of all confirmed and probably deaths related to
    # COVID-19 within Orange County, NY
    deaths = read_xlsx(
      "data/raw/Line List of Confirmed Cases and Deaths.xlsx",
      sheet = "Deaths",
      .name_repair = "universal",
      col_types = c(
        "text", "text", "numeric", "date",
        "text", "date", "text",    "numeric",
        "text", "text", "text",    "text",
        "text", "text", "text",    "text",
        "text", "text", "text"
      )
    )
  )
}

create_data_validation <- function() {
  # A list of validated data separated by category
  temp_list <- list(
    gender = list(
      "M" = "Male",
      "F" = "Female"
    ),
    race = list(
      "White"  = "White",
      "Black"  = "Black",
      "Native" = "Native American/Alaska Native",
      "Asian"  = "Asian/Native Hawaiian/Other Pacific Islander",
      "Other"  = "Other"
    ),
    ethnicity = list(
      "Hispanic" = "Hispanic",
      "Non.Hispanic" = "Non-Hispanic"
    ),
    vaccination = list(
      "None" = "None",
      "Partially" = "Partially",
      "Fully" = "Fully",
      "Boosted" = "Boosted"
    ),
    zip_codes = read_xlsx(
      "data/raw/Zip Codes and Towns.xlsx",
      col_types = c("numeric", "text"),
      .name_repair = "universal"
    )
  )
}