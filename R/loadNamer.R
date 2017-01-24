loadNamer <- function(file_path, name, expected_name = NULL) {
  # DISCLAIMER: NOT YET UNIT TESTED!  USE AT OWN PERIL!
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

  assign(name, eval(parse(text = newobj)), envir = globalenv())

  if (!is.null(expected_name)) {
    if (expected_name %in% oldenv) {
      assign(expected_name, eval(parse(text = temp)))
    }
  }
}
