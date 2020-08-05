#' @title Load the pdxTrees_streets data
#' 
#' @description This function pulls the pdxTrees_streets dataset from the GitHub repository:
#' \url{https://github.com/mcconvil/pdxTrees}. pdxTrees_streets is a data frame of
#'  all the street trees in the 96 neighborhoods of Portland, OR 
#'  and was collected as part of the Urban Forestry Tree Inventory Project.
#' 
#' @param neighborhood A vector of neighborhood names for filtering the data. 
#' If NULL, all street trees will be returned.
#' 
#' @return Returns a data frame with 218602 rows and 23 variables:
#' \describe{
#'   \item{UserID}{ID}
#'   \item{Inventory_Date}{Date of data collection}
#'   \item{Species}{Species of the tree.  All dead trees were listed as "unknown"}
#'   \item{Common_Name}{Common name of the tree}
#'   \item{DBH}{Diameter at breast height (4.5' above ground)}
#'   \item{Condition}{Trees were rated as good, fair, poor, or dead. 
#'   These general ratings reflect whether or not a tree is likely to
#'    continue contributing to the urban forest (good and fair trees)
#'     or whether the tree is at or near the end of its life (poor and dead trees).}
#'   \item{Site_Type}{Where along the street the tree was located.
#'   There are 8 different site types and more info can be found here:
#'    \url{http://gis-pdx.opendata.arcgis.com/datasets/street-trees}}
#'   \item{Site_Size}{Categorical size of the site: Small, Medium, Large}
#'   \item{Site_Width}{How wide the site was in ft.}
#'   \item{Wires}{Whether or not the site had wires: High voltage,
#'    No High voltage (No HV), other}
#'   \item{Site_Development}{ The condition of the site either being improved
#'    (ex. along a side walk or paved roadway ) or unimproved (a gravel road))}
#'   \item{Address}{The address where the tree is located}
#'   \item{Neighborhood}{The Portland neighborhood in which the tree is located}
#'   \item{Collected_By}{Who collected the data on this tree: staff or volunteer}
#'   \item{Scientific}{Scientific name of the tree}
#'   \item{Family}{Family of the tree}
#'   \item{Genus}{Genus of the tree}
#'   \item{Functional_Type}{Categorical variable with groups: 
#'   Broadleaf Deciduous (BD), Broadleaf Evergreen (BE),
#'    Coniferous Deciduous (CD), and Coniferous Evergreen (CE)}
#'   \item{Mature_Size}{Categorical variable with groups: Large (L),
#'    Medium (M), and Small (S).  Categorization is based on  the height,
#'    canopy width, and general form of the tree at maturity}
#'   \item{Edible}{Categorical variable of edible trees}
#'   \item{Notes}{Note on the data collection}
#'   \item{Longitude}{Longitude}
#'   \item{Latitude}{Latitude}
#' }
#' 
#' @source \url{https://www.portlandoregon.gov/parks/article/433143}
#' 
#' @importFrom rlang .data
#' @importFrom magrittr %>%
#' 
#' @examples
#'  # To grab all trees
#' \donttest{get_pdxTrees_streets()} 
#' 
#' # To grab trees from one neighborhood
#' \donttest{get_pdxTrees_streets(neighborhood = "Concordia")}
#' 
#' # To grab trees from multiple neighborhoods 
#' \donttest{get_pdxTrees_streets(neighborhood = c("Concordia","Eastmoreland","Sunnyside"))} 
#' 
#' @export


get_pdxTrees_streets <- function(neighborhood = NULL){
  

  # specify column types
  systems_cols_2 <- readr::cols(
    "UserID" = readr::col_character(),
    `Inventory_Date` = readr::col_datetime(),
    `Species` = readr::col_character(),
    `DBH` = readr::col_double(),
    `Condition` = readr::col_character(),
    `Site_Type` = readr::col_character(), 
    `Site_Width` = readr::col_double(),
    `Wires` = readr::col_character(),
    `Site_Development` = readr::col_character(),
    `Site_Size` = readr::col_character(),
    `Notes` = readr::col_character(),
    `Address` = readr::col_character(),
    `Neighborhood` = readr::col_character(),
    `Collected_By` = readr::col_character(),
    `Scientific` = readr::col_character(),
    `Family` = readr::col_character(),
    `Genus` = readr::col_character(),
    `Common_Name` = readr::col_character(),
    `Functional_Type` = readr::col_character(),
    `Mature_Size` = readr::col_factor(),
    `Edible` = readr::col_character(),
    `Longitude` = readr::col_double(), 
    `Latitude` = readr::col_double()
  )
  
  # grabbing the data 
  dat_2 <- readr::read_csv("https://raw.githubusercontent.com/mcconvil/pdxTrees/master/pdxTrees_streets.csv",
                            col_types = systems_cols_2)
  
  # returning the data 
  if(is.null(neighborhood)) { return(dat_2) }
 
  if(!is.null(neighborhood)) {
  # error message if all neighborhoods provided are 
    # not in dat_2$Neighborhood
      if(sum(neighborhood %in% unique(dat_2$Neighborhood)) == 0) { 
        
        stop('Unfortunately the park you listed is not one of the following Neighborhoods:', 
             print(paste(unique(dat_2$Neighborhood), collapse = ", ")))
        }
    
      dat_2 %>%
        dplyr::filter(.data$Neighborhood %in% neighborhood) %>%
        return()} 
  
}



