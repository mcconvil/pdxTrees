#' @title Load the pdxTrees_parks data
#' 
#' @description This function pulls the pdxTrees_parks dataset from the GitHub repository:
#'  \url{https://github.com/mcconvil/pdxTrees}. 
#'  pdxTrees_parks is a data frame of all the trees in 174 parks in Portland, OR
#'  and was collected as part of the Urban Forestry Tree Inventory Project.
#'
#' @param park A vector of park names for filtering the data.
#' If NULL, all park trees will be returned.
#'
#' @return Returns a data frame of 34 variables where each row is a tree:
#' \describe{
#'   \item{UserID}{ID}
#'   \item{Inventory_Date}{Date of data collection}
#'   \item{Species}{Species of the tree. All dead trees were listed as "unknown"}
#'   \item{Common_Name}{Common name of the tree}
#'   \item{DBH}{Diameter at breast height (4.5' above ground)}
#'   \item{Condition}{Trees were rated as good, fair, poor, or dead. 
#'   These general ratings reflect whether or not a tree is likely to
#'    continue contributing to the urban forest (good and fair trees)
#'     or whether the tree is at or near the end of its life (poor and dead trees).}
#'   \item{Tree_Height}{Height from the ground to the live top of the tree.
#'    For dead trees, total height was measured.}
#'   \item{Crown_Width_NS}{North to South canopy width}
#'   \item{Crown_Width_EW}{East to West canopy width}
#'   \item{Crown_Base_Height}{Height from the ground to the lowest live canopy.}
#'   \item{Collected_By}{Whether data were collect by staff or volunteer}
#'   \item{Park}{Park where tree is located}
#'   \item{Scientific_Name}{Scientific name of the tree}
#'   \item{Family}{Family of the tree}
#'   \item{Genus}{Genus of the tree}
#'   \item{Functional_Type}{Categorical variable with groups:
#'    Broadleaf Deciduous (BD), Broadleaf Evergreen (BE),
#'     Coniferous Deciduous (CD), and Coniferous Evergreen (CE)}
#'   \item{Mature_Size}{Categorical variable with groups:
#'    Large (L), Medium (M), and Small (S).  Categorization is based on 
#'    the height, canopy width, and general form of the tree at maturity}
#'   \item{Native}{Whether or not the tree is native}
#'   \item{Edible}{Categorical variable of edible trees}
#'   \item{Nuisance}{Categorical variable indicating if it is a nuisance species}
#'   \item{Structural_Value}{Monetary value of replacing the tree 
#'   and the benefits that it provides, based on methods from
#'    the Council of Tree and Landscape Appraisers}
#'   \item{Carbon_Storage_lb}{The amount of carbon (in lbs.) that is bound up
#'    in both the above-ground and below-ground parts of the tree}
#'   \item{Carbon_Storage_value}{The monetary value associated with tree
#'    effects on atmospheric carbon, $129.72/ton. This value is estimated based
#'    on the economic damages associated with increases
#'    in carbon or carbon dioxide emissions.}
#'   \item{Carbon_Sequestration_lb}{The amount of carbon (in lbs.) 
#'   removed from the atmosphere by the tree, annually.}
#'   \item{Carbon_Sequestration_value}{The monetary value of carbon ($129.72/ton),
#'    estimated based on the economic damages associated with
#'     increases in carbon or carbon dioxide emissions.}
#'   \item{Stormwater_ft}{The amount (cubic feet) of avoided stormwater runoff
#'    because of rainfall interception by the tree on its leaves and other surfaces.}
#'   \item{Stormwater_value}{The monetary value of stormwater runoff that is
#'    avoided annually because of the rainfall interception by the tree ($0.008936/gallon),
#'    based on the economic damages associated with runoff and costs of stormwater control.}
#'   \item{Pollution_Removal_oz}{The amount (oz.) of air pollution
#'    that is removed from the atmosphere by trees.}
#'   \item{Pollution_Removal_value}{The monetary value associated with
#'    tree effects on atmospheric pollution, annually.}
#'   \item{Total_Annual_Services}{Sum of the annual benefits}
#'   \item{Origin}{Origin of the tree}
#'   \item{Species_Factoid}{Additional information about the tree}
#'   \item{Longitude}{Longitude}
#'   \item{Latitude}{Latitude}
#' }
#' 
#' @source \url{https://www.portlandoregon.gov/parks/article/433143}
#' @importFrom rlang .data 
#' @importFrom magrittr %>%
#' 
#'@examples  
#' # To grab all trees
#' \donttest{ get_pdxTrees_parks()} 
#' 
#' # To grab trees from one park
#' \donttest{get_pdxTrees_parks(park = "Berkeley Park")}
#' 
#' # To grab trees from multiple parks
#' \donttest{get_pdxTrees_parks(park = c("Berkeley Park", "East Delta Park"))}
#'  
#' @export

get_pdxTrees_parks <- function(park = NULL){
  
  # specify column types
  systems_cols <- readr::cols(
    `Longitude` = readr::col_double(),
    `Latitude` = readr::col_double(),
    `UserID` = readr::col_character(),
    `Genus` = readr::col_character(),
    `Family` = readr::col_character(),
    `DBH` = readr::col_double(), 
    `Inventory_Date` = readr::col_datetime(),
    `Species` = readr::col_character(),
    `Common_Name` = readr::col_character(),
    `Condition` = readr::col_character(),
    `Tree_Height` = readr::col_double(),
    `Crown_Width_NS` = readr::col_double(),
    `Crown_Width_EW` = readr::col_double(),
    `Crown_Base_Height` = readr::col_double(),
    `Collected_By` = readr::col_character(),
    `Park` = readr::col_character(),
    `Scientific_Name` = readr::col_character(),
    `Functional_Type` = readr::col_character(),
    `Mature_Size` = readr::col_factor(),
    `Native` = readr::col_character(),
    `Edible` = readr::col_character(),
    `Nuisance` = readr::col_character(), 
    `Structural_Value` = readr::col_double(), 
    `Carbon_Storage_lb` = readr::col_double(),
    `Carbon_Storage_value` = readr::col_double(),
    `Carbon_Sequestration_lb` = readr::col_double(),
    `Carbon_Sequestration_value` = readr::col_double(),
    `Stormwater_ft` = readr::col_double(),
    `Stormwater_value` = readr::col_double(),
    `Pollution_Removal_value` = readr::col_double(), 
    `Pollution_Removal_oz` = readr::col_double(), 
    `Total_Annual_Services` = readr::col_double(),
    `Origin` = readr::col_character(),
    `Species_Factoid` = readr::col_character()
    ) 
  
  # grabbing the data from github
  dat <- readr::read_csv("https://raw.githubusercontent.com/mcconvil/pdxTrees/master/pdxTrees_parks.csv",
                        col_types = systems_cols)
  # returning the data
  if(is.null(park)){
    return(dat)}
  
  if(!is.null(park)){
    
    # error message if all parks provided are not
    # in dat$Park
      if(sum(park %in% unique(dat$Park)) == 0) { 
        
        stop('Unfortunately the park(s) you listed is(are) not one of the following parks:',
             print(paste(unique(dat$Park), collapse = ", ")))  
      }
  
      
      dat %>%
        dplyr::filter(.data$Park %in% park) %>%
      return()
      } 
}



