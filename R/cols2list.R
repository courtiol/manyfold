#' Turn columns of a table into a hierarchical list
#'
#' This function should not be called by the user. It is an internal function
#' used by `manyfold()`. While `manyfold()` turns the hierarchical structure
#' that exists between columns into a tree, the function `df2hierchlist()` turns
#' the hierarchical structure that exists between columns into a list.
#'
#' Because the function implement a recursive algorithm, we pass a list as an
#' argument which is completed through the multiple recursive call of the
#' function. For the same reason, we restrict the variable names to be quoted
#' and confined to a vector, which helps with efficiency.
#'
#' @param data the data.frame or tibble that contains the variables
#' @param vars a vector of variable names
#' @param listrec the list object in which to return the results
#' @param count whether or not add the number of rows in the level names (default = TRUE)
#' @param count_sep which separator to use when combining counts to level names (default = ":")
#' @param missing how to call NA in the tree (default = "UNKNOWN")
#'
#' @export
#'
#' @examples
#' ## Create a toy dataset:
#' table <- data.frame(country = c("France", "France", "France", "France",
#' "Spain", "Spain"), region = c("Herault", "Herault", "Aude", "Paris",
#' "Catalonia", "Andalusia"), city = c("Montpellier", "Montpellier", "Narbonne",
#' "Paris", "Barcelona", "Sevilla"))
#'
#' df2hierchlist(table, c("country", "region", "city"))
#'
#'
df2hierchlist <- function(data, vars, listrec = list(), count = TRUE, count_sep = ":", missing = "UNKNOWN") {
  if (length(vars) == 0) return(list(N = paste(nrow(data))))
  var_to_do <- vars[1]
  for (level in unique(data[[var_to_do]])) {
    data_temp <- data[data[[var_to_do]] == level, ]
    if (is.na(level))  data_temp <- data[is.na(data[[var_to_do]]), ]
    if (nrow(data_temp) > 0) {
      level_name <- level
      if (is.na(level_name)) level_name <- missing
      if (count) level_name <- paste0(level_name, count_sep, nrow(data_temp))
      listrec[[level_name]] <- df2hierchlist(data = data_temp,
                                             vars = vars[-1],
                                             listrec = listrec[[level_name]],
                                             count = count,
                                             count_sep = count_sep,
                                             missing = missing)
    }
  }
  listrec
}
