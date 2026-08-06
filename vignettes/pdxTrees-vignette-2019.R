## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set( echo = TRUE, message = FALSE, warning = FALSE, collapse = TRUE, comment = "#>",  fig.align = "center",
                       fig.retina = 2)

## ----include = TRUE, messgae = FALSE------------------------------------------
# First make sure you have the package downloaded! 

# devtools::install_github("mcconvil/pdxTrees")

# Loading the required libraries

install.packages("pdxTrees") 
library(pdxTrees)
library(ggplot2)
library(dplyr)
library(forcats)


## -----------------------------------------------------------------------------

# Leaving the argument field blank pulls data for all of the parks! 

pdxTrees_parks <- get_pdxTrees_parks()


## ----fig.width= 6, fig.height=4-----------------------------------------------

# A histogram of the inventory date 
pdxTrees_parks %>%   
  count(Inventory_Date) %>%  
  # Setting the aesthetics
  ggplot(aes(x = Inventory_Date)) +   
  # Specifying a histogram and picking color! 
  geom_histogram(bins = 50,               
                 fill = "darkgreen", 
                 color = "black") + 
  labs( x = "Inventory Date", 
        y = "Count", 
        title= "When was pdxTrees_parks Inventoried?") + 
  # Adding a theme 
  theme_minimal() + 
  theme(plot.title = element_text(hjust = 0.5))


## ----leaflet packages---------------------------------------------------------
# Loading the leaflet packages 
library(leaflet)
library(leaflet.extras)

## ----leaflet graph, fig.width= 8, fig.height=6--------------------------------

# Making the leaf popup icon 
greenLeaflittle <- makeIcon(
  iconUrl = "https://leafletjs.com/examples/custom-icons/leaf-green.png",
  iconWidth = 10, iconHeight = 20,
  iconAnchorX = 10, iconAnchorY = 10,
  shadowUrl = "https://leafletjs.com/examples/custom-icons/leaf-shadow.png",
 shadowWidth = 10, shadowHeight = 15,
 shadowAnchorX = 5, shadowAnchorY = 5
)


# Pulling the data for Berkely Park 

berkeley_prk <- get_pdxTrees_parks(park = "Berkeley Park")


# Creating the popup label 

labels <- paste("</b>", "Common Name:",
                 berkeley_prk$Common_Name,
                 "</b></br>", "Factoid: ", 
              berkeley_prk$Species_Factoid) 


# Creating the map 

leaflet() %>%
  # Setting the lng and lat to be in the general area of Berekely Park 
 setView(lng = -122.6239, lat = 45.4726, zoom = 17) %>%  
  # Setting the background tiles
  addProviderTiles(providers$Esri.WorldTopoMap) %>%
  # Adding the leaf markers with the popup data on top of the circles markers 
  addMarkers( ~Longitude, ~Latitude, 
              data = berkeley_prk,
             icon = greenLeaflittle,
              popup = ~labels) %>%
  # Adding the mini map at the bottom right corner 
  addMiniMap()


## -----------------------------------------------------------------------------
library(gganimate)

## ----animated graph-----------------------------------------------------------

# Refactoring the categorical mature_size variable 
berkeley_prk <- berkeley_prk %>%
 mutate(mature_size = fct_relevel(Mature_Size, "S", "M", "L"))


# First creating the graph using ggplot and saving it! 
berkeley_graph <- berkeley_prk %>%
  # Piping in the data 
                  ggplot(aes(x = Tree_Height,
                              y = Pollution_Removal_value,
                              color = Mature_Size)) + 
  # Creating the scatterplot 
                  geom_point(size = 2, alpha = 0.5) +
                  theme_minimal() + 
  # Adding the labels 
                  labs(title = "Pollution Removal Value of
                       Berkeley Park Trees",
                       x = "Tree Height", 
                       y = "Pollution Removal Value ($'s annually)", 
                       color = "Mature Size") + 
  # Adding a color palette 
                  scale_color_brewer(type = "seq", palette = "Set1") + 
  # Customizing the title font
                  theme(plot.title = element_text(hjust = 0.5, 
                                                  size = 8,
                                                  face = "bold"), 
                         axis.title.x = element_text(size = 6), 
                         axis.text = element_text(size = 4),  
                         axis.title.y = element_text(size = 6), 
                        legend.title = element_text(size = 6), 
                        legend.text = element_text(size= 4))

## ----out.width = "90%"--------------------------------------------------------
# Then adding the animation with gganimate functions 

 berkeley_graph + 
  # Choosing which variable we want to annimate 
  transition_states(states = Mature_Size,
                    # How long each point stays before fading away 
                    transition_length = 10,
                    # Time the transition takes
                    state_length = 8)  +    
  # Animation for the points entering
  enter_grow() +      
  # Animation for the points exiting
  exit_shrink()


## ----linear regression graph, warning = FALSE, fig.width = 6, fig.height = 4----

# Visualizing the relationship between the two variables. 
ggplot(pdxTrees_parks, aes(x = Tree_Height, 
                           y = Pollution_Removal_value)) + 
 # Creating a scatter plot 
  geom_point(alpha = 0.05) + 
 # Adding the line of best fit
  stat_smooth(method = lm, se = FALSE) + 
  theme_minimal() + 
  labs(x = "Tree Height", 
       y = "Pollution Removal Value ($)")


## ----linear regression, warning = FALSE---------------------------------------

# moderndive is where the get_regression_table() function lives 
library(moderndive)

# Running a linear regression of Pollution_Removal_value on Tree_Height
mod <- lm(Pollution_Removal_value ~ Tree_Height, data = pdxTrees_parks)

# Printing the coefficients table
get_regression_table(mod)

