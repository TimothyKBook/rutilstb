#' Convert a matrix to full rank.
#'
#' Convert a rank-deficient matrix into a full rank one.
#'
#' @param x A matrix or data frame to be converted into a full rank matrix.
#'
#' @return A matrix of full rank that is the original matrix with select columns
#' removed.
#'
#' @export
fullRanker <- function(x) {

  # Convert to matrix if given a data.frame
  if (is.data.frame(x)) {
    x <- model.matrix(~ . - 1, data = x)
  }

  # Record rank and number of columns
  r <- qr(crossprod(x))$rank
  p <- ncol(x)

  # Until matrix is of full column rank, iteratively remove
  # the first column that prevents it from being full rank.
  while(r < p)
  {
    rank_vec <- sapply(1:p, function(i) qr(crossprod(x[, -i]))$rank)
    x <- x[, -which.max(rank_vec)]
    p <- ncol(x)
  }

  return(x)
}
