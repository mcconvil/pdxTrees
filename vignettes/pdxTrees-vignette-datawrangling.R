## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set( echo = TRUE, message = FALSE, warning = FALSE, collapse = TRUE, comment = "#>",  fig.align = "center",
                       fig.retina = 2)

## ----include = TRUE, messgae = FALSE------------------------------------------

# First make sure you have the package downloaded! 

devtools::install_github("mcconvil/pdxTrees")

# Loading the required libraries

library(pdxTrees) 
library(ggplot2)
library(dplyr)
library(forcats)
library(devtools)


## -----------------------------------------------------------------------------

# Pulling the data for Parks from the 2019 data set

pdxTrees_Parks <- get_pdxTrees_parks()

#create a subset data frame
Carbon_Parks <- pdxTrees_Parks %>%
	#get rid of extra variables
	select(-c("Collected_By", "Nuisance", "Functional_Type")) %>%
	#add a new variable that groups carbon storage value
	mutate(Carbon_Group = case_when(
		is.na(Carbon_Storage_value) ~ NA,
		Carbon_Storage_value <= 250 ~ "Low",
		between(Carbon_Storage_value, 250, 750) ~ "Moderate",
		Carbon_Storage_value > 750 ~ "High")) 


#view small piece of new data frame
glimpse(Carbon_Parks)


#show how many observations in each carbon group
#note there are 49 NAs to begin with
count(Carbon_Parks, Carbon_Group)


## -----------------------------------------------------------------------------

#create a subset data frame
Park_Stats <- Carbon_Parks %>%
  # group data by each category of condition
	group_by(Condition) %>%
  # find the mean DBH and tree height in each category and count how many trees per category
	summarize(mean_DBH = mean(DBH, na.rm = TRUE),
		mean_tree_height = mean(Tree_Height, na.rm = TRUE),
		trees = n()) %>%
  #arrange the data in ascending order by trees
	arrange(trees)


# show table output
Park_Stats


## -----------------------------------------------------------------------------

#show variable class 
class(Carbon_Parks$Condition)
#show variable order
levels(Carbon_Parks$Condition)


#change to ordered and set the order
Carbon_Parks <- Carbon_Parks %>%
  mutate(Condition = factor(Condition,
      levels = c("Dead", "Poor", "Fair", "Good")))


#show new variable class 
class(Carbon_Parks$Condition)
#show new variable order
levels(Carbon_Parks$Condition)


## -----------------------------------------------------------------------------

#create a subset data frame
Carbon_Parks <- Carbon_Parks %>%
	#show rows where condition is set to good and tree height is greater than or equal to its average or DBH is greater than or equal to its average
filter(Condition == "Good", (Tree_Height >= 50 | DBH >= 17.5))


# show table output
Carbon_Parks


## -----------------------------------------------------------------------------

#create a subset data frame
Park_Sample <- Carbon_Parks %>%
	#simple random sample
	slice_sample(n = 100)


#display first few rows
head(Park_Sample)


## -----------------------------------------------------------------------------

#create a name to store data under
Summary_Sample <- Park_Sample %>% 
  #choose variables to summarize
  select(DBH, Tree_Height) %>% 
  #get summary statistics on chosen variables
  summary()


#show output and observe changes to medians
Summary_Sample


## -----------------------------------------------------------------------------

pdxTrees_Parks_m <- pdxTrees_Parks %>% 
  # multiply each variable by the conversion and change `DBH` to cm and `Tree_Height` to m
  mutate(DBH_cm = 2.54 * DBH,
         Tree_Height_m = 0.3048 * Tree_Height)


#show table
glimpse(pdxTrees_Parks_m)


# Pulling the data for Streets from the 2019 data set
pdxTrees_Streets <- get_pdxTrees_streets()


pdxTrees_Streets_m <- pdxTrees_Streets %>% 
  # multiply each variable by the conversion and change `DBH` to cm and `Tree_Height` to m
  mutate(DBH_cm = 2.54 * DBH)


#show table
glimpse(pdxTrees_Streets_m)


## -----------------------------------------------------------------------------

# filter out NAs
pdxParks_na <- pdxTrees_Parks %>% 
  filter(Edible == c("No", "Yes", "Yes - fruit", "Yes - nuts"))

# filter nuisance to yes
nuisance_parks <- pdxParks_na %>% 
  filter(Nuisance == "Yes") 
 

# use count to compare the two
count(nuisance_parks, Edible)
count(pdxParks_na, Edible)


## -----------------------------------------------------------------------------

# grouping to the variables we want to look at and making sure were only looking at high voltage
pdxTrees_Streets %>% 
  group_by(Neighborhood, Wires) %>% 
  filter(Wires == "High voltage") %>% 
  #count high volt wires in each neighborhood
  count(., Wires) %>% 
  #arrange in descending order
  arrange(desc(n))

#maybe add in 2026 comparison


## -----------------------------------------------------------------------------

# grouping to the variables we want to look at and making sure were only looking at high voltage
dbh_size <- pdxTrees_Streets %>% 
  group_by(Site_Size) %>% 
  summarise(avg_dbh = mean(DBH, na.rm = TRUE),
         trees = n())


dbh_size


#add comparison here to 2026 data


