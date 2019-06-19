# Libaries
library(tidyverse)
library(janitor)

# Data Import
trees_all <- readr::read_csv("data-raw/portland_park_inventory.csv")
trees_geo <- readr::read_csv("data-raw/Parks_Tree_geo.csv") %>%
  dplyr::select(X, Y, UserID, Genus, Family, DBH)

# Join the spatial info
pdxTrees <- trees_all %>%
  left_join(trees_geo)

# Data Wrangling

# Clean up names
pdxTrees <- pdxTrees %>%
  clean_names() %>%
  rename(longitude = x,
         latitude = y)

# Create a data frame of trees from a few parks near OHSU
ohsuTrees <- pdxTrees %>%
  dplyr::filter(park %in% c("Duniway Park", "South Waterfront Park",
                            "Elizabeth Caruthers Park", "Lair Hill Park",
                            "Gov Tom McCall Waterfront Park",
                            "SW Terwilliger Blvd Parkway"))

# Add datafiles to the project
usethis::use_data(pdxTrees, overwrite = TRUE)
usethis::use_data(ohsuTrees, overwrite = TRUE)
