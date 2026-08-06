## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set( echo = TRUE, message = FALSE, warning = FALSE, collapse = TRUE, comment = "#>",  fig.align = "center",
                       fig.retina = 2)

## ----include = TRUE, messgae = FALSE------------------------------------------

# First make sure you have the package downloaded! 

devtools::install_github("mcconvil/pdxTrees")

# Loading the required libraries

library(pdxTrees)
library(dplyr)
library(forcats)
library(devtools)
library(tidyverse)
library(ggalluvial)
library(leaflet)
library(leaflet.extras)

## -----------------------------------------------------------------------------
PDX_parks <- get_pdxTrees_parks()
PDX_streets <- get_pdxTrees_streets()

## -----------------------------------------------------------------------------
#plotting

ggplot(data = PDX_parks,
 mapping = aes(x = Tree_Height)) +
 geom_histogram(color = "white",
 fill = "forestgreen",
 bins = 30) +
  labs(title = "Distribution of Tree Heights in Portland Parks")


## -----------------------------------------------------------------------------
#plotting

ggplot(data = PDX_streets,
 mapping = aes(x = DBH)) +
 geom_histogram(color = "white",
 fill = "green3",
 bins = 45) +
  labs(title = "Distribution of Tree DBH in Portland Streets")

## -----------------------------------------------------------------------------
#plotting

ggplot(
  data = PDX_streets,
  mapping = aes(
    x = factor(Condition, levels = c("Dead", "Poor", "Fair", "Good")),
    y = DBH,
    fill = factor(Condition, levels = c("Dead", "Poor", "Fair", "Good"))
  )
) +
  geom_violin() +
  scale_fill_brewer() +
    labs(x = "Condition", fill = "Condition", title = "DBH with each Tree Condition Level")

## -----------------------------------------------------------------------------
#cleaning

Carbonstorage_DBH <- PDX_parks %>%
  select(Carbon_Storage_value, DBH) %>%
  drop_na()

#plotting

ggplot(data = Carbonstorage_DBH, mapping = aes(x = Carbon_Storage_value, y = DBH)) +
  geom_jitter(alpha = 0.3) +
  geom_smooth() +
  labs(title = "DBH and Carbon Storage Value")

## -----------------------------------------------------------------------------
#cleaning
street_hophorn <- PDX_streets %>%
  select(Common_Name, DBH, Site_Width) %>%
  filter(Common_Name %in% "Hophornbeam") %>%
  drop_na()

#plotting
ggplot( data = street_hophorn, mapping = aes(x = Site_Width, y = DBH)) +
  geom_line(color = "darkseagreen") +
  labs(title = "Hophornbeam DBH and Site Width Relationship" )

## -----------------------------------------------------------------------------
#cleaning

parks_density <- PDX_parks %>%
  drop_na(Carbon_Storage_value, Mature_Size)

#plotting

ggplot(data =  parks_density, mapping = aes(x = Carbon_Storage_value, fill = Mature_Size)) +
  geom_density() +
  labs( title = "Carbon Storage of Various Tree Sizes")

## -----------------------------------------------------------------------------
#cleaning

no_na_parks <- PDX_parks %>%
  drop_na(Collected_By)

#plotting

ggplot( data = no_na_parks, mapping = aes(x = Collected_By, fill = Collected_By)) +
  geom_bar(color = "black") +
  theme_bw() +
  scale_fill_manual(values = c("darkgoldenrod4","darkcyan")) +
  labs(title = "Staff vs. Volunteer Collection in Portland Parks")

## -----------------------------------------------------------------------------
#cleaning

no_na_streets <- PDX_streets %>%
  drop_na(Collected_By)

#plotting

ggplot( data = no_na_streets, mapping = aes(x = Collected_By, fill = Collected_By)) +
  geom_bar(color = "black") +
  theme_bw() +
  scale_fill_manual(values = c("darkkhaki","azure1")) +
   labs(title = "Staff vs. Volunteer Collection on Portland Streets")

## -----------------------------------------------------------------------------
tree_species_count <- PDX_parks %>%
   select("Common_Name") %>%
  filter(Common_Name %in% c("Douglas-Fir",
                             "Giant Sequoia",
                             "Sweetgum")) 
 

counts_spe <- count(tree_species_count, Common_Name)

ggplot(data = counts_spe, mapping = aes(x = Common_Name, y=n, fill = Common_Name)) +
  geom_col() +
  scale_fill_brewer(palette = "PuBuGn") +
  labs(title = "Douglas Fir, Giant Sequioa, and Sweetgum Presence in Portland Parks")

## -----------------------------------------------------------------------------
#cleaning

condition_wires <- get_pdxTrees_streets() %>%
    select("Wires", "Condition")

#counting

counts_wire_con <- count(condition_wires, Condition, Wires)

#plotting

ggplot(data = counts_wire_con,
       mapping = aes( axis1 = Condition, axis2 = Wires, y = n)) +
  geom_alluvium(mapping = aes(fill = Condition)) +
  geom_stratum() +
  geom_text(stat = "stratum", 
            mapping = aes(label = after_stat(stratum))) +
  scale_x_discrete(limits = c("Condition", "Wires")) +
  labs(title = "Wires Effect on Tree Condition")

## -----------------------------------------------------------------------------
#cleaning

native_parktrees <- PDX_parks %>%
  drop_na(Native) 

#plotting

ggplot(data = native_parktrees,
 mapping = aes(x = Native, fill = Native)) +
 geom_bar(color = "black") +
  theme_bw() +
  labs( title = "Native vs Nonnative Tree Count in Portland Parks",
        y = "Number of Trees") +
  scale_fill_manual(values = c("red3","lightgreen"))

