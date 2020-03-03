#' Turn columns of a table into a tree like structure
#'
#' This function helps to illustrate the relationship between columns contained
#' into a dataset. For example, imagine you have 3 columns containing `country`,
#' `region` and `city` in your dataset. Checking that the right cities are in
#' the right regions, and that the right regions are in the right countries, can
#' be quite tedious (especially for a large dataset) when the data are shown as
#' a table. It is much easier if the data are shown as a tree. This function
#' helps you do that.
#'
#'
#' @inheritParams df2hierchlist
#' @param .data the .data.frame or tibble to use
#' @param ... the columns to use to build the tree, quoted and separated by
#'   commas, starting with the broadest classifier on the left
#'
#' @return an object of class `Node` on which many further actions are possible
#'   (see [`data.tree()`][`data.tree::data.tree`])
#'
#' @seealso [`data.tree()`][`data.tree::data.tree`]
#'
#' @export
#'
#' @author Alexandre Courtiol
#'
#' @examples
#' ## Create a toy dataset:
#' table <- data.frame(country = c("France", "France", "France", "France",
#' "Spain", "Spain"), region = c("Herault", "Herault", "Aude", "Paris",
#' "Catalonia", "Andalusia"), city = c("Montpellier", "Montpellier", "Narbonne",
#' "Paris", "Barcelona", "Sevilla"))
#'
#' table
#'
#' ## Without specifying columns (takes them all in the order they come):
#' manyfold(table)
#'
#' ## With column specification:
#' manyfold(table, "country", "region", "city")
#'
#' ## Another way for displaying counts:
#' tree <- manyfold(table, "country", "region", "city", count = FALSE)
#' print(tree, "N")
#'
#'
manyfold <- function(.data, ..., count = TRUE, count_sep = ":", missing = "UNKNOWN") {

  call <- match.call(expand.dots = FALSE)
  vars_to_do <- unlist(call[["..."]])
  if (is.null(vars_to_do)) {
    vars_to_do <- names(.data)
  }

  if (!all(vars_to_do %in% names(.data))) {
    stop("variable(s) not in the dataset!")
  }

  list_rec <- df2hierchlist(data = .data,
                            vars = vars_to_do,
                            listrec = list(),
                            count = count,
                            count_sep = count_sep,
                            missing = missing)

  data.tree::FromListSimple(list_rec)
}


