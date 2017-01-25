#' loadNamer
#'
#' Load objects in an .RData and automatically give it a given name.
#'
#' @param file_path The .RData file to load in.
#' @param name The name you'd like the .RData object to be loaded in as.
#' @param expected_name If you already have an object in the environment with the same name
#' as the object about to be loaded in, put that character string here.  It will be preserved
#' while loading in the new object.
#'
#' @return
#'
#' @export
loadNamer <- function(file_path, name, expected_name = NULL) {
  oldenv <- c(ls(), 'oldenv')

  if (!is.null(expected_name)) {
    if (expected_name %in% oldenv) {
      temp <- substitute(expected_name)
      oldenv <- c(oldenv, 'temp')
    }
  }

  load(file_path)

  newenv <- ls()

  newobj <- setdiff(newenv, oldenv)
  if (length(newobj) > 1) stop('Please only use an .RData with one object stored!')
  if (length(newobj) == 0) stop('.RData was empty!')

  assign(name, eval(parse(text = newobj)), envir = globalenv())

  if (!is.null(expected_name)) {
    if (expected_name %in% oldenv) {
      assign(expected_name, eval(parse(text = temp)))
    }
  }
}
