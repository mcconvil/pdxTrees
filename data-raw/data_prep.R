# Libaries
library(tidyverse)
library(janitor)
#library("stringi")   

# Data Import for pdxTrees_parks 

Parks_Tree_Inventory <- read_csv("data-raw/Parks_Tree_Inventory.csv") 

Final_export_2019 <- readxl::read_excel("data-raw/Final_export_2019.xlsx")

  # cleaning the spatial data 
    Parks_Tree_Inventory$Y <- paste0(
      substr(Parks_Tree_Inventory$Y,1,2),
      ".",
      substr(Parks_Tree_Inventory$Y,3,7)
    )
  
    Parks_Tree_Inventory$X <- paste0(
      substr(Parks_Tree_Inventory$X,1,4),
      ".",
      substr(Parks_Tree_Inventory$X,5,9)
    )
     
  # cleaning the names 
    Parks_Tree_Inventory <- Parks_Tree_Inventory %>%
     clean_names() %>%
     rename(longitude = x,
             latitude = y) 
    
  
    trees_geo<- Parks_Tree_Inventory %>%
      dplyr::select(longitude, latitude, user_id, genus, family, dbh)
    
    trees_all <- incadata::lownames(Final_export_2019) %>%
      clean_names() %>%
    rename(user_id = userid)


# joining the spatial data and creating pdxTrees_parks
pdxTrees_parks <- trees_all%>%
  left_join(trees_geo) 


# more data cleaning

    ## fixing the columns' class 
    pdxTrees_parks <- pdxTrees_parks %>%
      mutate(inventory_date = lubridate::ymd(inventory_date), 
             latitude = as.numeric(latitude), 
             longitude = as.numeric(longitude))
    
    ## fixing the edible column 
    pdxTrees_parks <- pdxTrees_parks %>%
      mutate(edible = case_when(edible == "Yes - fruit" ~ "Yes", 
                               edible == "Yes - nuts" ~ "Yes", 
                               edible == "Yes" ~ "Yes", 
                               edible == "No" ~ "No"))
    
    
    ## fixing the common_name column 
    
   # pdxTrees_parks <- pdxTrees_parks %>%
   #   mutate(common_name = stri_trans_totitle(common_name))



# Create a data frame of trees from a few parks near OHSU
ohsuTrees_parks <- pdxTrees_parks %>%
  dplyr::filter(park %in% c("Duniway Park", "South Waterfront Park",
                            "Elizabeth Caruthers Park", "Lair Hill Park",
                            "Gov Tom McCall Waterfront Park",
                            "SW Terwilliger Blvd Parkway"))


# data import for pdxTrees_streets

Street_Trees <- read_csv("data-raw/Street_Trees.csv")

# data cleaning 

    
  ##cleaning the spatial data 
    Street_Trees$Y <- paste0(
      substr(Street_Trees$Y,1,2),
      ".",
      substr(Street_Trees$Y,3,7)
    )
    
    Street_Trees$X <- paste0(
      substr(Street_Trees$X,1,4),
      ".",
      substr(Street_Trees$X,5,9)
    )
    
    ## renmaing to lat and long and creating pdxTrees_streets
    pdxTrees_streets <- Street_Trees %>%
      clean_names() %>%
      rename(longitude = x,
             latitude = y)
    
    ## fixing other column names and date column 
    pdxTrees_streets <- pdxTrees_streets %>%
      mutate(date_inventoried = lubridate::ymd_hms(`date_inventoried`), 
             latitude = as.numeric(latitude), 
             longitude = as.numeric(longitude)) %>%
      rename(inventory_date = date_inventoried)
    
    ##fixing wires column 
    
    pdxTrees_streets <- pdxTrees_streets %>%
      mutate(wires = case_when(wires == "None" ~ "No HV", 
                               wires == "none" ~ "No HV", 
                               wires == "High voltage" ~ "High voltage", 
                               wires == "Other" ~ "Other", 
                               wires == "No HV" ~ "No HV"))
    
    ## removing planted_by,plant_date, species_description because they are empty columns 
    
    pdxTrees_streets <- pdxTrees_streets %>%
      select(-c("planted_by", "plant_date", "species_description"))
    
  
# Add datafiles to the project
usethis::use_data(pdxTrees_parks, overwrite = TRUE)
usethis::use_data(ohsuTrees_parks, overwrite = TRUE)
usethis::use_data(pdxTrees_streets, overwrite = TRUE)
