# grab the pdxTrees_parks data from the github 


get_pdxTrees_parks <- function() {
  
  
  # specify column types
  systems_cols <- readr::cols(
    `Longitude` = readr::col_double(),
    `Latitude` = readr::col_double(),
    `UserID` = readr::col_double(),
    `Genus` = readr::col_character(),
    `Family` = readr::col_character(),
    `DBH` = readr::col_double(), 
    `Inventory_Date` = readr::col_datetime(),
    `Species` = readr::col_character(),
    `Common_Name` = readr::col_character(),
    `Condition` = readr::col_character(),
    `Tree_Height` = readr::col_double(),
    `Crown_Width_NS` = readr::col_double(),
    `Crown_Width_EW` = readr::col_double(),
    `Crown_Base_Height` = readr::col_double(),
    `Collected_By` = readr::col_character(),
    `Park` = readr::col_character(),
    `Scientific_Name` = readr::col_character(),
    `Functional_Type` = readr::col_character(),
    `Mature_Size` = readr::col_character(),
    `Native` = readr::col_character(),
    `Edible` = readr::col_character(),
    `Nuisance` = readr::col_character(), 
    `Structural_Value` = readr::col_double(), 
    `Carbon_Storage_lb` = readr::col_double(),
    `Carbon_Storage_value` = readr::col_double(),
    `Carbon_Sequestration_lb` = readr::col_double(),
    `Carbon_Sequestration_value` = readr::col_double(),
    `Stormwater_ft` = readr::col_double(),
    `Stormwater_value` = readr::col_double(),
    `Pollution_Removal_value` = readr::col_double(), 
    `Pollution_Removal_oz` = readr::col_double(), 
    `Total_Annual_Services` = readr::col_double(),
    `Origin` = readr::col_character(),
    `Species_Factoid` = readr::col_character()
    
  )
  
  
  # grab the data
  readr::read_csv("https://raw.githubusercontent.com/mcconvil/pdxTrees/master/pdxTrees_parks.csv",
                  col_types = systems_cols)
}


