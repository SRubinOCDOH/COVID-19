# Install missing packages and load all required packages
get_dependencies(
  "readxl", "writexl", "httr", "tidyxl", "openxlsx", "dplyr", "plotly",
  "ggplot2", "stringr", "shiny", "htmltools"
)

# Retrieve all the raw data required for calculations
raw_data <- list(
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

# Ensure data validation options are created
data_validation <- list(
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
  ) %>% arrange(Town.City)
)

# Create empty lists to store data and plots
# Deletes any previous data which was stored in the lists
processed_data <- list()
plots <- list()

# Store all opening strings in a list
# cs = cases, dt = deaths
opening_strings <- list(
  "cs_daily"   = "Confirmed Cases of COVID-19 by Date Received",
  "cs_symp"    = "Confirmed Cases of COVID-19 by Symptom Onset Date",
  "cs_asymp"   = "Asymptomatic Cases of COVID-19 by Date Received",
  "cs_age_gr"  = "Confirmed Cases of COVID-19 by Age Group",
  "cs_avg_age" = "Average Age of Confirmed Cases of COVID-19",
  "cs_gender"  = "Confirmed Cases of COVID-19 by Gender",
  "cs_race"    = "Confirmed Cases of COVID-19 by Race",
  "cs_ethn"    = "Confirmed Cases of COVID-19 by Ethnicity",
  "cs_top_zip" = "Confirmed Cases of COVID-19 by Municipality (Top 20)",
  
  "dt_dod"     = "Confirmed and Probable COVID-19 Deaths by Date of Death",
  "dt_gender"  = "Confirmed and Probable COVID-19 Deaths by Gender",
  "dt_race"    = "Confirmed and Probable COVID-19 Deaths by Race",
  "dt_ethn"    = "Confirmed and Probable COVID-19 Deaths by Ethnicity",
  "dt_age_gr"  = "Confirmed and Probable COVID-19 Deaths by Age Group",
  "dt_avg_age" = "Average Age of Confirmed and Probable COVID-19 Deaths",
  "dt_vacc"    = "Confirmed and Probable COVID-19 Deaths by Vaccination Status",
  "dt_top_zip" = "Confirmed and Probable COVID-19 Deaths by Top Municipalities"
)
