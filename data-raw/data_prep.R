# Libaries
library(tidyverse)
library(janitor)
library(sf)
#library("stringi")   

# Data Import for pdxTrees_parks 

park_data <- readxl::read_excel("data-raw/Final_export_2019.xlsx")

spatial_data <- st_read("data-raw/spatial_data_parks/Parks_Tree_Inventory.shp")




  # cleaning the spatial data 
    spatial_data <- st_transform(spatial_data, 4326)
     
    spatial_data <- spatial_data %>%
    dplyr::mutate(Longitude = sf::st_coordinates(.)[,1],
                  Latitude = sf::st_coordinates(.)[,2])
    


  # cleaning the names 
  
    spatial_data <- spatial_data %>%
      dplyr::select(Longitude, Latitude, UserID, Genus, Family, DBH)
      


# joining the spatial data and creating pdxTrees_parks
pdxTrees_parks <- spatial_data %>%
  left_join(park_data) 

# more data cleaning

    ## fixing the columns' class 
    pdxTrees_parks <- pdxTrees_parks %>%
      mutate(inventory_date = lubridate::ymd(Inventory_Date), 
             Latitude = as.numeric(Latitude), 
             Longitude = as.numeric(Longitude))
    
    ## fsome more wrangling 
    pdxTrees_parks <- pdxTrees_parks %>%
      mutate(Edible = case_when(Edible == "Yes - fruit" ~ "Yes", 
                               Edible == "Yes - nuts" ~ "Yes", 
                               Edible == "Yes" ~ "Yes", 
                               Edible == "No" ~ "No"))
    
    pdxTrees_parks <- pdxTrees_parks %>%
        dplyr:: select(-c("inventory_date")) %>%
        sf::st_drop_geometry() %>%
        rename("Common_Name" = "Common name") %>%
        mutate(Common_Name = stringr::str_to_title(Common_Name))
      
   

# Create a data frame of trees from a few parks near OHSU
ohsuTrees_parks<- pdxTrees_parks %>%
  dplyr::filter(Park %in% c("Duniway Park", "South Waterfront Park",
                            "Elizabeth Caruthers Park", "Lair Hill Park",
                            "Gov Tom McCall Waterfront Park",
                            "SW Terwilliger Blvd Parkway"))

# data import for pdxTrees_streets

Street_Trees <- read_csv("data-raw/Street_Trees.csv")

spatial_data_street <- st_read("data-raw/Street_Trees-shp/Street_Trees.shp")




    
 
  # cleaning the spatial data 
  spatial_data_street <- st_transform(spatial_data_street, 4326)
  
  spatial_data_street <- spatial_data_street %>%
    dplyr::mutate(Longitude = sf::st_coordinates(.)[,1],
                  Latitude = sf::st_coordinates(.)[,2])
  
  
      ## renmaing to lat and long and creating pdxTrees_streets
  
  
    pdxTrees_streets <- left_join(Street_Trees, spatial_data_street)
    
      ## removing extra columsn 
    pdxTrees_streets <- pdxTrees_streets %>%
      dplyr::select(-c("X", "Y", "Date_Inven", "geometry")) 
    
  
      ## fixing other column names and date column 
    
    
      pdxTrees_streets <- pdxTrees_streets %>%
        mutate(Date_Inventoried = lubridate::ymd_hms(`Date_Inventoried`), 
               Latitude = as.numeric(Latitude), 
               Longitude = as.numeric(Longitude)) %>%
        rename("UserID" = "OBJECTID", "Functional_Type" = "FunctionalType", 
               "Inventory_Date" = "Date_Inventoried")
      
      ##fixing wires column 
      
      pdxTrees_streets <- pdxTrees_streets %>%
        mutate(Wires = case_when(Wires == "None" ~ "No HV", 
                                 Wires == "none" ~ "No HV", 
                                 Wires == "High voltage" ~ "High voltage", 
                                 Wires == "Other" ~ "Other", 
                                 Wires == "No HV" ~ "No HV"))
      ## fixing edible column
      pdxTrees_streets <- pdxTrees_streets %>%
        mutate(Edible = case_when(Edible == "fruit" ~ "Yes", 
                                  Edible == "nut" ~ "Yes", 
                                  Edible == "no" ~ "No"))
      
      ## removing planted_by,plant_date, species_description because they are empty columns
      ## and removing duplicate columns 
      
      pdxTrees_streets <- pdxTrees_streets %>%
        dplyr::select(-c("Planted_By", "Plant_Date", "Species_Description",
                  "Collected_", "Functional", "Species_De", "Neighborho",
                 "Site_devel")) %>%
        rename("Common_Name" = "Common")

  
  
# Add datafiles to the project
usethis::use_data(pdxTrees_parks, overwrite = TRUE)
usethis::use_data(ohsuTrees_parks, overwrite = TRUE)
usethis::use_data(pdxTrees_streets, overwrite = TRUE)

