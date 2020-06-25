trees_all <- readr::read_csv("data-raw/portland_park_inventory.csv")
trees_geo <- readr::read_csv("data-raw/Parks_Tree_geo.csv") %>%
 dplyr::select(X, Y, UserID, Genus, Family, DBH)

pdxTrees <- trees_all %>%
 left_join(trees_geo)

pdxTrees <- pdxTrees %>%
 clean_names() %>%
 rename(longitude = x,
       latitude = y)

