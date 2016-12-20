#' Check to see if a column/vector can be used as an id variable.
#'
#' @param x Vector or dataframe.
#'
#' @return logical indicating whether or not `x` has distinct elements.  If a
#' dataframe was given, a vector of logicals.
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

    out <- lapply(x, function(var) {
      n <- length(var)
      out <- length(unique(var)) == n
      return(out)
    })

    return(unlist(out))

  } else {

    stop("Please enter a vector or data frame!")

  }
}
