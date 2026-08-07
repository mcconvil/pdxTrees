# pdxTrees

`pdxTrees` is a data package composed of information on inventoried
trees in Portland, OR. There are two datasets that can be accessed with
this package:

- `get_pdxTrees_parks()` pulls in data on up to 25,534 trees from 174
  Portland parks.

- `get_pdxTrees_streets()` pulls in data on up to 218,602 trees located
  on Portland’s streets. A street tree is loosely defined as a tree
  generally in the public right-of-way, usually between the sidewalk and
  the street.

The street trees are categorized by one of the 96 Portland neighborhoods
and the park trees are categorized by the public parks in which they
grow.

These data were collected by the [Portland Parks and Recreation’s Urban
Forestry Tree Inventory
Project](https://www.portland.gov/trees/get-involved/tree-inventory#toc-street-tree-inventory).
The Tree Inventory Project has gathered data on Portland trees since
2010, collecting this data in the summer months with a team of over
1,300 volunteers and city employees. The streets trees were inventoried
from 2010 to 2016, and the park trees were inventoried from 2017 to
2019. More information on the data can be found
[here](https://www.portland.gov/trees/get-involved/tree-inventory#toc-street-tree-inventory).

## To install the package

``` r
# Do the following once
# install.packages("devtools")

# Then install the package
devtools::install_github("mcconvil/pdxTrees")
```

    ## rlang     (1.1.6  -> 1.1.7 ) [CRAN]
    ## lifecycle (1.0.4  -> 1.0.5 ) [CRAN]
    ## pillar    (1.11.0 -> 1.11.1) [CRAN]
    ## tibble    (3.3.0  -> 3.3.1 ) [CRAN]

    ## 
    ## The downloaded binary packages are in
    ##  /var/folders/zy/5n0x52fd13bc59n5553m3jn00000gn/T//RtmpRoErmG/downloaded_packages
    ## ── R CMD build ─────────────────────────────────────────────────────────────────
    ## * checking for file ‘/private/var/folders/zy/5n0x52fd13bc59n5553m3jn00000gn/T/RtmpRoErmG/remotes1fad2e3be360/mcconvil-pdxTrees-599bb6a/DESCRIPTION’ ... OK
    ## * preparing ‘pdxTrees’:
    ## * checking DESCRIPTION meta-information ... OK
    ## * checking for LF line-endings in source and make files and shell scripts
    ## * checking for empty or unneeded directories
    ## Omitted ‘LazyData’ from DESCRIPTION
    ## * building ‘pdxTrees_0.4.0.tar.gz’

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

`pdxTrees` is used in multiple courses as a tool to help students
develop their data analysis skills using `R`. In courses, students have
used the data to wrangle with `dplyr`, create graphs with `ggplot2`, and
create interactive maps with `leaflet`. It is also featured in [Modern
Data Science with R](https://mdsr-book.github.io/mdsr3e/) by Ben Baumer,
Daniel Kaplan, and Nicholas Horton.
