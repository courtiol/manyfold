% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/cols2tree.R
\name{manyfold}
\alias{manyfold}
\title{Turn columns of a table into a tree like structure}
\usage{
manyfold(.data, ..., count = TRUE, count_sep = ":", missing = "UNKNOWN")
}
\arguments{
\item{.data}{the .data.frame or tibble to use}

\item{...}{the columns to use to build the tree, quoted and separated by
commas, starting with the broadest classifier on the left}

\item{count}{whether or not add the number of rows in the level names (default = TRUE)}

\item{count_sep}{which separator to use when combining counts to level names (default = ":")}

\item{missing}{how to call NA in the tree (default = "UNKNOWN")}
}
\value{
an object of class \code{Node} on which many further actions are possible
(see \code{\link[data.tree:data.tree]{data.tree()}})
}
\description{
This function helps to illustrate the relationship between columns contained
into a dataset. For example, imagine you have 3 columns containing \code{country},
\code{region} and \code{city} in your dataset. Checking that the right cities are in
the right regions, and that the right regions are in the right countries, can
be quite tedious (especially for a large dataset) when the data are shown as
a table. It is much easier if the data are shown as a tree. This function
helps you do that.
}
\examples{
## Create a toy dataset:
table <- data.frame(country = c("France", "France", "France", "France",
"Spain", "Spain"), region = c("Herault", "Herault", "Aude", "Paris",
"Catalonia", "Andalusia"), city = c("Montpellier", "Montpellier", "Narbonne",
"Paris", "Barcelona", "Sevilla"))

table

## Without specifying columns (takes them all in the order they come):
manyfold(table)

## With column specification:
manyfold(table, "country", "region", "city")

## Another way for displaying counts:
tree <- manyfold(table, "country", "region", "city", count = FALSE)
print(tree, "N")


}
\seealso{
\code{\link[data.tree:data.tree]{data.tree()}}
}
\author{
Alexandre Courtiol
}
