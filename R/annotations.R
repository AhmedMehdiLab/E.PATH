#' Gene set annotations
#' 
#' Annotations are structured as a column of gene set names followed by a number
#' of annotation columns containing annotations for that respective gene set.
#' Column names are optional, there is no limit on the number of annotation
#' columns, and additional columns are allowed.
#'
#' @format A data frame with 243 rows and 17 variables:
#' \describe{
#'   \item{GeneSetModule}{gene set names}
#'   \item{Annotation_}{annotations}
#'   \item{Description}{gene set descriptions}
#'   \item{Link}{link to raw data}
#' }
#' @source see \code{Link} columns
"annotations"