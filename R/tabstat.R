#' Tabstat
#'
#' Creates a 'tabstat' summary statistic table, similar to the ones produced
#' in Stata.
#'
#' @param var The variable to be summarised.  Must be entered as character.
#' @param data The data frame to be summarised.
#' @param by A string of character variables to group summaries into.
#' @param fns A list of summary functions.  Use `length` for rowcounts by
#' category. Default already contains many useful statistics.
#' @param na.rm Logical, whether or not to remove NAs.  Defaults to true.
#'
#' @return A dataframe of summary statistics.
#' @export
tabstat <- function(var, data, by = NULL,
                    fns = list(mean, sd, min, median, max, length),
                    na.rm = TRUE) {

  fn_names <- substitute(fns)
  fn_names <- unlist(strsplit(deparse(fn_names), ","))
  fn_names <- gsub("list\\(", "", fn_names)
  fn_names <- gsub("\\)", "", fn_names)
  fn_names <- trimws(fn_names)
  
  out_df <- aggregate(data, by = data[by], FUN = identity)[by]

  if (na.rm) {
    data <- data[complete.cases(data[var]),]
  }
  
  for (fn in fns) {
    agg <- aggregate(data[var], by = data[by], FUN = fn)
    # out_df <- data.frame(out_df, agg[var])
    out_df <- suppressWarnings({merge(out_df, agg, by = by, all.x = TRUE)})
  }

  colnames(out_df) <- c(by, fn_names)

  if ("length" %in% colnames(out_df)) {
    colnames(out_df)[which(colnames(out_df) == "length")] <- "count"
  }

  return(out_df)
}
