library(tidyverse)
library(sf)
street_spatial <- sf::st_read("data_raw/STI_v2_FINAL_dataset_public_-8515810556081492981/STI_v2_FINAL_dataset_public.shp")
saveRDS(street_spatial, file = "data_raw/STI_v2_FINAL_dataset_public.rds")
