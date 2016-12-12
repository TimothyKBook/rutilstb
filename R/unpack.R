#' Unpacking a list
#'
#' Unpacks a list into the parent environment.
#'
#' @param list A list to be unpacked.
#'
#' @return No returns (null).
#' @export
unpack <- function(list) {
  objects <- names(list)
  for (obj in objects) {
    assign(obj, mylist[[obj]], envir = parent.env(environment()))
  }
  return(NULL)
}
