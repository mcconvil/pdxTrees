library(tidyverse)
library(sf)
library(utils)
library(lubridate)

Street_Trees_2026 <- readRDS("data_raw_2026/STI_v2_FINAL_dataset_public.rds")
Park_Trees_2026 <- utils::read.csv("data_raw_2026/Parks_Tree_Inventory.csv")

#############################################
# pdxTrees_parks
#############################################

# clean inventory date
Park_Trees_2026 <- Park_Trees_2026 %>%
  dplyr::mutate(Inventory_Date = as.Date(Inventory_Date))

# add lat and long 
Park_Trees_2026 <- Park_Trees_2026 %>%
  sf::st_as_sf(crs = 3857, coords = c("X", "Y"))
Park_Trees_2026 <- sf::st_transform(Park_Trees_2026, 4326)

Park_Trees_2026 <- Park_Trees_2026 %>%
  dplyr::mutate(Longitude = sf::st_coordinates(.)[ ,1],
                Latitude = sf::st_coordinates(.)[ ,2]) 
# removing extra columns
Park_Trees_2026 <- sf::st_drop_geometry(Park_Trees_2026)

#fix variable classifications
Park_Trees_2026 <- Park_Trees_2026 %>%
  dplyr::mutate(inventory_date = lubridate::ymd(Inventory_Date), 
                Latitude = as.numeric(Latitude), 
                Longitude = as.numeric(Longitude),
                UserID = as.character(UserID)) 

#Matching Property IDs to parks 
Park_PropID <- utils::read.csv("data_raw_2026/Matching_PropID.csv")
Park_PropID <- dplyr::select(Park_PropID, -c("OBJECTID", "ACRES", "Shape_Length", "Shape_Area"))
Park_Trees_2026 <- dplyr::left_join(Park_Trees_2026, Park_PropID, by = c("PropertyID" = "PROPERTYID"))


# Renaming columns to match    
Park_Trees_2026 <- Park_Trees_2026 %>%
  dplyr:: select(-c("inventory_date")) %>%
  sf::st_drop_geometry() %>%
  dplyr::rename("Common_Name" = "Common_name",
                "Collected_By" = "CollectedBy",
                "Mature_Size" = "Size",
                "Crown_Width_NS" = "CrownWidthNS",
                "Crown_Width_EW" = "CrownWidthEW",
                "Tree_Height" = "TreeHeight",
                "Park" = "NAME",
                "Scientific_Name" = "Genus_species",
                "Total_Annual_Services" = "Total_Annual_Benefits",
                "Crown_Base_Height" = "CrownBaseHeight",
                "Functional_Type" = "Functional_type") 

Park_Trees_2026 <- dplyr::select(Park_Trees_2026, c("Longitude", "Latitude", "UserID", 
                                                    "Genus", "Family", "DBH", "Inventory_Date",
                                                    "Species", "Common_Name", "Condition",
                                                    "Tree_Height", "Crown_Width_NS","Crown_Width_EW",
                                                    "Crown_Base_Height", "Collected_By",
                                                    "Park", "Scientific_Name", "Functional_Type",
                                                    "Mature_Size", "Native", "Edible", "Nuisance",
                                                    "Structural_Value", "Carbon_Storage_lb", "Carbon_Storage_value",
                                                    "Carbon_Sequestration_lb", "Carbon_Sequestration_value",
                                                    "Stormwater_ft", "Stormwater_value", "Pollution_Removal_value",
                                                    "Pollution_Removal_oz", "Total_Annual_Services", "Origin", 
                                                    "Species_factoid"))

#############################################
# pdxTrees_streets
#############################################

#add edible
add_edible <- Park_Trees_2026 %>%
  dplyr::select(Edible, Common_Name, Functional_Type, Species) %>% 
  unique(.)
Street_Trees_2026 <- dplyr::left_join(Street_Trees_2026, add_edible, by = c("SPECIES_CO" = "Common_Name"))

# add lat and long 
Street_Trees_2026 <- Street_Trees_2026 %>%
  sf::st_as_sf(crs = 3857, coords = c("X", "Y"))
Street_Trees_2026 <- sf::st_transform(Street_Trees_2026, 4326)

Street_Trees_2026 <- Street_Trees_2026 %>%
  dplyr::mutate(Longitude = sf::st_coordinates(.)[ ,1],
                Latitude = sf::st_coordinates(.)[ ,2]) 

# removing extra columns
Street_Trees_2026 <- sf::st_drop_geometry(Street_Trees_2026)

#string fixes
Street_Trees_2026 <- Street_Trees_2026 %>%
  dplyr::mutate(Neighborhood = str_to_title(NEIGHBORHO)) %>% 
  dplyr::select(-NEIGHBORHO)

# Renaming to match  
Street_Trees_2026 <- Street_Trees_2026 %>%
  dplyr::mutate( MATURE_SIZ = recode(MATURE_SIZ,
                                     "Small" = "S",
                                     "Medium" = "M",
                                     "Large" = "L"),
                 MATURE_SIZ = factor(MATURE_SIZ, levels = c("S", "M", "L"))) %>% 
  dplyr::select(c("OG_OBJECTI", "DATE_INVEN", "Species", "DBH_IE_DIA", 
                  "CONDITION", "OVERHEAD_W", "ADDRESS", "Neighborhood", 
                  "SPECIES_SC", "FAMILY", "GENUS_SCIE", "GENUS_COMM", "Functional_Type",
                  "Edible", "Longitude", "Latitude", "MATURE_SIZ")) %>% 
  dplyr::rename("UserID" = "OG_OBJECTI", "Inventory_Date" = "DATE_INVEN",
                "DBH" = "DBH_IE_DIA", "Condition" = "CONDITION", "Wires" = "OVERHEAD_W", 
                , "Address" = "ADDRESS", "Scientific" = "SPECIES_SC",
                "Family" = "FAMILY", "Genus" = "GENUS_SCIE",
                "Common_Name" = "GENUS_COMM", "Mature_Size" = "MATURE_SIZ")

# Fixing Wires column 
Street_Trees_2026 <- Street_Trees_2026 %>%
  dplyr::mutate(Wires = if_else(Wires %in% c("None", "none"), "None",
                                Wires))

#making csv files
Park_Trees_2026 <- Park_Trees_2026 %>%
  as.data.frame()

Street_Trees_2026 <- Street_Trees_2026 %>%
  as.data.frame()

#Write csvs
write.csv(Park_Trees_2026, file = "Park_Trees_2026.csv", row.names = FALSE)
write.csv(Street_Trees_2026, file = "Street_Trees_2026.csv", row.names = FALSE)
# Add datafiles to the project in a project
#usethis::use_data(Park_Trees_2026, overwrite = TRUE,
# compress = "xz", version = 2)

#usethis::use_data(Street_Trees_2026, overwrite = TRUE,
# compress = "xz", version = 2)

