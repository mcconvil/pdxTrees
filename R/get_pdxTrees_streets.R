#grab the pdxTrees_streets data from the github


get_pdxTrees_streets <- function() {
  

  # specify column types
  systems_cols <- readr::cols(
    "UserID" = readr::col_double(),
    `Inventory_Date` = readr::col_datetime(),
    `Species` = readr::col_character(),
    `DBH` = readr::col_double(),
    `Condition` = readr::col_character(),
    `Site_Type` = readr::col_character(), 
    `Site_Width` = readr::col_double(),
    `Wires` = readr::col_character(),
    `Site_Development` = readr::col_character(),
    `Site_Size` = readr::col_character(),
    `Notes` = readr::col_character(),
    `Address` = readr::col_character(),
    `Neighborhood` = readr::col_character(),
    `Collected_By` = readr::col_character(),
    `Scientific` = readr::col_character(),
    `Family` = readr::col_character(),
    `Genus` = readr::col_character(),
    `Common_Name` = readr::col_character(),
    `Functional_Type` = readr::col_character(),
    `Size` = readr::col_character(),
    `Edible` = readr::col_character(),
    `Longitude` = readr::col_double(), 
    `Latitude` = readr::col_double()
  )
  
  
  # grab the data
  readr::read_csv("https://raw.githubusercontent.com/mcconvil/pdxTrees/master/pdxTrees_streets.csv",
                  col_types = systems_cols)
}


