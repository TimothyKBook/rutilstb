#' Missing Value Description Table
#'
#' Creates a table that describes where missing values occur
#' in a given dataframe.
#'
#' @param df A dataframe or vector to analyze.
#'
#' @return An object of type dataframe describing where missing values occur and
#' at what rate.
#' @export
mdesc <- function(df) {

  if (is.vector(df)) {
    missing_col <- sum(is.na(df))
    total_col <- length(df)
    perc_missing_col <- missing_col / total_col

    out <- data.frame(
      'missing' = missing_col,
      'total' = total_col,
      'percent_missing' = perc_missing_col
    )

    return(out)
  } else if (is.data.frame(df)) {
    var_col <- colnames(df)
    missing_col <- unlist(lapply(df, function(x) sum(is.na(x))))
    total_col <- nrow(df)
    perc_missing_col <- missing_col / total_col

    out <- data.frame(
      'variable' = var_col,
      'missing' = missing_col,
      'total' = total_col,
      'percent_missing' = perc_missing_col
    )
    rownames(out) <- NULL
    return(out)
  } else {
    stop('Please enter a vector or data.frame!')
  }
}
