#' Check to see if a column/vector can be used as an id variable.
#'
#' @param x Vector or column of dataframe.
#'
#' @return logical indicating whether or not `x` has distinct elements.
#' @export
isid <- function(x) {
  if (is.vector(x)) {

    n <- length(x)
    if (length(unique(x)) == n) {
      return(TRUE)
    } else {
      return(FALSE)
    }

  } else if (is.data.frame(x)) {

    n <- nrow(x)
    if (nrow(unique(x)) == n) {
      return(TRUE)
    } else {
      return(FALSE)
    }

  } else {

    stop("Please enter a vector or data frame!")

  }
}
