
![R-CMD-check](https://github.com/mcconvil/pdxTrees/workflows/R-CMD-check/badge.svg)
![Render
README](https://github.com/mcconvil/pdxTrees/workflows/Render%20README/badge.svg)

# pdxTrees

`pdxTrees` is a data package composed of information on inventoried
trees in Portland, OR. There are two datasets that can be accessed with
this package:

  - `get_pdxTrees_parks()` pulls in data on up to 25,534 trees from 174
    Portland parks.

  - `get_pdxTrees_streets()` pulls in data on up to 218,602 trees
    located on Portland’s streets. A street tree is loosely defined as a
    tree generally in the public right-of-way, usually between the
    sidewalk and the street.

The street trees are categorized by one of the 96 Portland neighborhoods
and the park trees are categorized by the public parks in which they
grow.

These data were collected by the [Portland Parks and Recreation’s Urban
Forestry Tree Inventory
Project](https://www.portlandoregon.gov/parks/53181). The Tree Inventory
Project has gathered data on Portland trees since 2010, collecting this
data in the summer months with a team of over 1,300 volunteers and city
employees. The streets trees were inventoried from 2010 to 2016, and the
park trees were inventoried from 2017 to 2019. More information on the
data can be found
[here](https://www.portlandoregon.gov/parks/article/501565).

## To install the package

``` r
# Do the following once
# install.packages("devtools")

# Then install the package
devtools::install_github("mcconvil/pdxTrees")
```

## Update/Getting the data

`pdxTrees` was updated in July of 2020 to contain two data loading
functions, `get_pdxTrees_parks()` and `get_pdxTrees_streets()`, to pull
the park and street tree data, respectively, from the Github repository.

``` r
# Load the library
library(pdxTrees)

# To get data on all parks 

pdxTrees_parks <- get_pdxTrees_parks()

# To get data on one park 

berkeley_park <- get_pdxTrees_parks(park = "Berkeley Park")

# To get data on multiple parks 

parks <- get_pdxTrees_parks(park = c("Berkeley Park", 
                                     "East Delta Park"))


# The streets function works the same way but with neighborhoods! 

pdxTrees_streets <- get_pdxTrees_streets()

# One neighborhood 
  
concordia <- get_pdxTrees_streets(neighborhood = "Concordia")
  
# Mutliple neighborhoods! 
  
neighborhoods <- get_pdxTrees_streets(neighborhood = c("Concordia",
                                                       "Eastmoreland",
                                                       "Sunnyside"))
```

## Teaching with `pdxTrees`

`pdxTrees` is used in multiple [Reed College statistics
courses](https://www.reed.edu/math/courses.html) as a tool to help
students develop their data analysis skills in
[RStudio](https://rstudio.com/). In Introduction to Probability and
Statistics, students wrangle `pdxTrees` data with `dplyr`, and create
graphs of `pdxTrees` with `ggplot2`. In the [Data Science
course](https://github.com/Reed-Statistics/math241s20), the package is
used to teach best practices of function writing, to construct
interactive maps with `leaflet`, and to showcase the usefulness of
`lubridate`, along with many other R packages.
