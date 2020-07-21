# Libraries
library(tidyverse)
library(sf)

#############################################
# pdxTrees_parks
#############################################

# Importing data for pdxTrees_parks 

park_data <- readxl::read_excel("data-raw/Final_export_2019.xlsx")

spatial_data <- st_read("data-raw/spatial_data_parks/Parks_Tree_Inventory.shp")


# Cleaning the spatial data 

spatial_data <- st_transform(spatial_data, 4326)

# Adding Longitude and Latitude columns from spatial information  
spatial_data <- spatial_data %>%
  dplyr::mutate(Longitude = sf::st_coordinates(.)[ ,1],
                  Latitude = sf::st_coordinates(.)[ ,2])  %>%
  dplyr::select(Longitude, Latitude, UserID, Genus, Family, 
                    DBH)
      

# Joining the spatial data and creating pdxTrees_parks
pdxTrees_parks <- spatial_data %>%
  inner_join(park_data) 

# More data cleaning

## Fixing the columns' class 
pdxTrees_parks <- pdxTrees_parks %>%
  mutate(inventory_date = lubridate::ymd(Inventory_Date), 
         Latitude = as.numeric(Latitude), 
         Longitude = as.numeric(Longitude),
         UserID = as.character(UserID)) 
    

# Fixing column names/entries and removing spatial component    
pdxTrees_parks <- pdxTrees_parks %>%
  dplyr:: select(-c("inventory_date")) %>%
  sf::st_drop_geometry() %>%
  rename("Common_Name" = "Common name") %>%
  mutate(Common_Name = stringr::str_to_title(Common_Name),
         Collected_By = stringr::str_to_title(Collected_By),
         Mature_Size = factor(Mature_Size, levels = c("S", "M", "L")), 
         UserID = as.character(UserID))
      

#############################################
# ohsuTrees_parks
#############################################

# # Create a data frame of trees from a few parks near OHSU
# ohsuTrees_parks <- pdxTrees_parks %>%
#   dplyr::filter(Park %in% c("Duniway Park", 
#                             "South Waterfront Park",
#                             "Elizabeth Caruthers Park", 
#                             "Lair Hill Park",
#                             "Gov Tom McCall Waterfront Park",
#                             "SW Terwilliger Blvd Parkway"))

#############################################
# pdxTrees_streets
#############################################

# Import data for pdxTrees_streets

Street_Trees <- read_csv("data-raw/Street_Trees.csv") %>%
  select(-Planted_By, -Plant_Date)

spatial_data_street <- st_read("data-raw/Street_Trees-shp/Street_Trees.shp")


# cleaning the spatial data 
spatial_data_street <- st_transform(spatial_data_street, 4326)

# Adding Longitude and Latitude columns from spatial information  
spatial_data_street <- spatial_data_street %>%
  dplyr::mutate(Longitude = sf::st_coordinates(.)[,1],
                Latitude = sf::st_coordinates(.)[,2])
  
  
# Creating pdxTrees_streets by joining spatial and non-spatial datasets
  
pdxTrees_streets <- inner_join(Street_Trees, 
                              spatial_data_street)
    
# Removing extra columns 

pdxTrees_streets <- pdxTrees_streets %>%
  dplyr::select(-c("X", "Y", "Date_Inven", "geometry")) 
    
  
# Fixing other column names and date column 
    
pdxTrees_streets <- pdxTrees_streets %>%
  mutate(Date_Inventoried = lubridate::ymd_hms(`Date_Inventoried`),
         Latitude = as.numeric(Latitude), 
         Longitude = as.numeric(Longitude)) %>%
  rename("UserID" = "OBJECTID", 
         "Functional_Type" = "FunctionalType",
         "Inventory_Date" = "Date_Inventoried")
      
      
# Fixing Wires column 

pdxTrees_streets <- pdxTrees_streets %>%
  mutate(Wires = if_else(Wires %in% c("None", "none"), "None",
                         Wires))


      
# Removing planted_by, plant_date, species_description because they are empty columns and removing duplicate columns 
      
pdxTrees_streets <- pdxTrees_streets %>%
  dplyr::select(-c("Planted_By", "Plant_Date", 
                   "Species_Description", "Collected_", 
                   "Functional", "Species_De", 
                   "Neighborho", "Site_devel")) %>%
  rename("Common_Name" = "Common",
         "Site_Development" = "Site_development") %>%
  dplyr:: mutate(Neighborhood = str_to_title(Neighborhood), 
                 Collected_By = str_to_title(Collected_By), 
                 Common_Name = str_to_title(Common_Name), 
                 Mature_Size = factor(Size, levels = c("S", "M","L")), 
                 UserID = as.character(UserID)) %>%
  dplyr::select(-c("Size"))

# Converting to only a data.frame object
pdxTrees_streets <- pdxTrees_streets %>%
  as.data.frame()
    
      
# Add datafiles to the project
usethis::use_data(pdxTrees_parks, overwrite = TRUE,
                  compress = "xz", version = 2)
#usethis::use_data(ohsuTrees_parks, overwrite = TRUE,
#                  compress = "xz", version = 2)
usethis::use_data(pdxTrees_streets, overwrite = TRUE,
                  compress = "xz", version = 2)

