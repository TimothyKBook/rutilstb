#' colMatcher
#'
#' Determines if any two columns of a data.frame or matrix are identical.
#'
#' @param x The matrix or data.frame
#' @param return_index logical.  If TRUE, returns which two columns are
#' identical.
#'
#' @return If return_index = FALSE, returns TRUE if any columns matched.  If
#' return_index = TRUE, returns matrix indicating which columns matched.  Always
#' returns FALSE if no columns matched.
#'
#' @export
colMatcher <- function(x, return_index = FALSE) {
  if (is.data.frame(x) && is.matrix(x)) {
    stop("Please enter a data.frame or matrix!")
  }

  p <- ncol(x)

  # TODO: Rewrite loop as an apply statement.
  diff_mat <- matrix(FALSE, p, p)
  for (i in 1:(p - 1)) for (j in (i + 1):p) {
    diff_mat[i, j] <- all(round(x[,i] - x[,j], 6) == 0)
  }

  if (any(diff_mat)) {
    if(return_index) {
      out <- which(diff_mat, arr.ind = TRUE)
      colnames(out) <- c('col1', 'col2')
      return(out)
    } else {
      return(TRUE)
    }
  } else {
    return(FALSE)
  }
}
