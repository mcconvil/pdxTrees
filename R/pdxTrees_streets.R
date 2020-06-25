#' Portland street trees.
#'
#' A dataset of all the street trees in the 96 neighborhoods of Portland, OR.  Collected as part of the Urban Forestry Tree Inventory Project.
#'
#' @format A data frame with 218602 rows and 24 variables:
#' \describe{
#'   \item{objectid}{ID}
#'   \item{inventory_date}{Date of data collection}
#'   \item{species}{Species of the tree.  All dead trees were listed as "unknown"}
#'   \item{common_name}{Common name of the tree}
#'   \item{dbh}{Diameter at breast height (4.5' above ground)}
#'   \item{condition}{Trees were rated as good, fair, poor, or dead. These general ratings reflect whether or not a tree is likely to continue contributing to the urban forest (good and fair trees) or whether the tree is at or near the end of its life (poor and dead trees).}
#'   \item{site_type}{Where along the street the tree was located: }
#'   \item{site_size}{Categorical size of the site: Small, Medium, Large}
#'   \item{site_width}{How wide the site was in ft.}
#'   \item{wires}{Whether or not the site had wires: High voltage, No High voltage (No HV), other}
#'   \item{site_development }{ The condition of the site either being improved (ex. along a side walk or paved roadway ) or unimproved (a gravel road))}
#'   \item{address}{The address where the tree is located}
#'   \item{neighborhood}{The Portland neighborhood in which the tree is located}
#'   \item{collected_by}{Who collected the data on this tree: staff or volunteer}
#'   \item{scientific_name}{Scientific name of the tree}
#'   \item{family}{Family of the tree}
#'   \item{genus}{Genus of the tree}
#'   \item{functional_type}{Categorial variable with groups: Broadleaf Deciduous (BD), Broadleaf Evergreen (BE), Coniferous Deciduous (CD), and Coniferous Evergreen (CE)}
#'   \item{mature_size}{Categorical variable with groups: Large (L), Medium (M), and Small (S).  Categorization is based on  the height, canopy width, and general form of the tree at maturity}
#'   \item{edible}{Categorical variable of edible trees}
#'   \item{origin}{Origin of the tree}
#'   \item{species_factoid}{Additional information about the tree}
#'   \item{longitude}{Longitude}
#'   \item{latitude}{Latitude}
#' }
#' @source \url{https://www.portlandoregon.gov/parks/article/433143}
"pdxTrees"
