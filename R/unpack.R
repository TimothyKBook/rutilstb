#' Unpacking a list
#'
#' Unpacks a list into the global (or selected) environment.
#'
#' @param list A list to be unpacked.
#'
#' @return No returns (null).
#' @export
unpack <- function(mylist, env = globalenv()) {
  objects <- names(mylist)
  for (obj in objects) {
    assign(obj, mylist[[obj]], envir = env)
  }
}
