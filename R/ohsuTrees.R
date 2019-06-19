#' Park trees near OHSU.
#'
#' A dataset of all the trees from several parks in the Oregon Health and Science Univerity in Portland, OR.  Collected as part of the Urban Forestry Tree Inventory Project.
#'
#' @format A data frame with 15856 rows and 34 variables:
#' \describe{
#'   \item{user_id}{ID}
#'   \item{inventory_date}{Date of data collection}
#'   \item{species}{Species of the tree.  All dead trees were listed as "unknown"}
#'   \item{common_name}{Common name of the tree}
#'   \item{dbh}{Diameter at breast height (4.5' above ground)}
#'   \item{condition}{Trees were rated as good, fair, poor, or dead. These general ratings reflect whether or not a tree is likely to continue contributing to the urban forest (good and fair trees) or whether the tree is at or near the end of its life (poor and dead trees).}
#'   \item{tree_height}{Height from the ground to the live top of the tree. For dead trees, total height was measured.}
#'   \item{crown_width_ns}{North to South canopy width}
#'   \item{crown_width_ew}{East to West canopy width}
#'   \item{crown_base_height}{Height from the ground to the lowest live canopy.}
#'   \item{collected_by}{Whether data were collect by staff or volunteer}
#'   \item{park}{Park where tree is located}
#'   \item{scientific_name}{Scientific name of the tree}
#'   \item{family}{Family of the tree}
#'   \item{genus}{Genus of the tree}
#'   \item{functional_type}{Categorial variable with groups: Broadleaf Deciduous (BD), Broadleaf Evergreen (BE), Coniferous Deciduous (CD), and Coniferous Evergreen (CE)}
#'   \item{mature_size}{Categorical variable with groups: Large (L), Medium (M), and Small (S).  Categorization is based on  the height, canopy width, and general form of the tree at maturity}
#'   \item{native}{Whether or not the tree is native}
#'   \item{edible}{Categorical variable of edible trees}
#'   \item{nuisance}{Categorical variable indicating if it is a nuisance species}
#'   \item{structural_value}{Monetary value of replacing the tree and the benefits that it provides, based on methods from the Council of Tree and Landscape Appraisers}
#'   \item{carbon_storage_lb}{The amount of carbon (in lbs.) that is bound up in both the above-ground and below-ground parts of the tree}
#'   \item{carbon_storage_value}{The monetary value associated with tree effects on atmospheric carbon, $129.72/ton. This value is estimated based on the economic damages associated with increases in carbon or carbon dioxide emissions.}
#'   \item{carbon_sequestration_lb}{The amount of carbon (in lbs.) removed from the atmosphere by the tree, annually.}
#'   \item{carbon_sequestration_value}{The monetary value of carbon ($129.72/ton), estimated based on the economic damages associated with increases in carbon or carbon dioxide emissions.}
#'   \item{stormwater_ft}{The amount (cubic feet) of avoided stormwater runoff because of rainfall interception by the tree on its leaves and other surfaces.}
#'   \item{stormwater_value}{The monetary value of stormwater runoff that is avoided annually because of the rainfall interception by the tree ($0.008936/gallon), based on the economic damages associated with runoff and costs of stormwater control.}
#'   \item{pollution_removal_oz}{The amount (oz.) of air pollution that is removed from the atmosphere by trees.}
#'   \item{pollution_removal_value}{The monetary value associated with tree effects on atmospheric pollution, annually.}
#'   \item{total_annual_benefits}{Sum of the annual benefits}
#'   \item{origin}{Origin of the tree}
#'   \item{species_factoid}{Additional information about the tree}
#'   \item{longitude}{Longitude}
#'   \item{latitude}{Latitude}
#'
#'
#'
#' }
#' @source \url{https://www.portlandoregon.gov/parks/article/433143}
