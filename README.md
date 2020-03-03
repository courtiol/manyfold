
<!-- README.md is generated from README.Rmd. Please edit that file -->

# manyfold

<!-- badges: start -->

[![Lifecycle:
experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://www.tidyverse.org/lifecycle/#experimental)
[![CRAN
status](https://www.r-pkg.org/badges/version/manyfold)](https://CRAN.R-project.org/package=manyfold)
<!-- badges: end -->

The goal of **{manyfold}** is to help you turns columns from your
`data.frame` or `tibble` into a nested list which can be displayed as a
tree like structure.

This package is **highly experimental** and only contain a few functions
for now.

It is build around a single dependency:
[**{data.tree}**](https://github.com/gluc/data.tree), and it is possible
to use the full power of the functions from this excellent package on
the output created by **{manyfold}**.

## Installation

You can install this package using **{remotes}** (or **{devtools}**):

``` r
remotes::install_github("courtiol/manyfold")
```

## Example

``` r
library(manyfold)

## Create a toy dataset:
 table <- data.frame(country = c("France", "France", "France", "France",
                                 "Spain", "Spain"),
                     region = c("Herault", "Herault", "Aude", "Paris",
                                "Catalonia", "Andalusia"),
                     city = c("Montpellier", "Montpellier", "Narbonne", "Paris",
                              "Barcelona", "Sevilla"))

 table
#>   country    region        city
#> 1  France   Herault Montpellier
#> 2  France   Herault Montpellier
#> 3  France      Aude    Narbonne
#> 4  France     Paris       Paris
#> 5   Spain Catalonia   Barcelona
#> 6   Spain Andalusia     Sevilla

## Manyfold without specifying columns (takes them all in the order they come):
 manyfold(table)
#>                    levelName
#> 1  Root                     
#> 2   ¦--France:4             
#> 3   ¦   ¦--Herault:2        
#> 4   ¦   ¦   °--Montpellier:2
#> 5   ¦   ¦--Aude:1           
#> 6   ¦   ¦   °--Narbonne:1   
#> 7   ¦   °--Paris:1          
#> 8   ¦       °--Paris:1      
#> 9   °--Spain:2              
#> 10      ¦--Catalonia:1      
#> 11      ¦   °--Barcelona:1  
#> 12      °--Andalusia:1      
#> 13          °--Sevilla:1

## Manyfold with column specification:
 manyfold(table, "country", "region", "city")
#>                    levelName
#> 1  Root                     
#> 2   ¦--France:4             
#> 3   ¦   ¦--Herault:2        
#> 4   ¦   ¦   °--Montpellier:2
#> 5   ¦   ¦--Aude:1           
#> 6   ¦   ¦   °--Narbonne:1   
#> 7   ¦   °--Paris:1          
#> 8   ¦       °--Paris:1      
#> 9   °--Spain:2              
#> 10      ¦--Catalonia:1      
#> 11      ¦   °--Barcelona:1  
#> 12      °--Andalusia:1      
#> 13          °--Sevilla:1

## The order of the columns matters:
 manyfold(table, "region", "city", "country")
#>                levelName
#> 1  Root                 
#> 2   ¦--Herault:2        
#> 3   ¦   °--Montpellier:2
#> 4   ¦       °--France:2 
#> 5   ¦--Aude:1           
#> 6   ¦   °--Narbonne:1   
#> 7   ¦       °--France:1 
#> 8   ¦--Paris:1          
#> 9   ¦   °--Paris:1      
#> 10  ¦       °--France:1 
#> 11  ¦--Catalonia:1      
#> 12  ¦   °--Barcelona:1  
#> 13  ¦       °--Spain:1  
#> 14  °--Andalusia:1      
#> 15      °--Sevilla:1    
#> 16          °--Spain:1

## Another way for displaying counts:
 print(manyfold(table, "country", "region", "city", count = FALSE), "N")
#>                  levelName N
#> 1  Root                     
#> 2   ¦--France               
#> 3   ¦   ¦--Herault          
#> 4   ¦   ¦   °--Montpellier 2
#> 5   ¦   ¦--Aude             
#> 6   ¦   ¦   °--Narbonne    1
#> 7   ¦   °--Paris            
#> 8   ¦       °--Paris       1
#> 9   °--Spain                
#> 10      ¦--Catalonia        
#> 11      ¦   °--Barcelona   1
#> 12      °--Andalusia        
#> 13          °--Sevilla     1
 
## It works on columns containing things other than strings too:
 print(manyfold(mtcars), limit = 20)
#>                                          levelName
#> 1  Root                                           
#> 2   ¦--21:2                                       
#> 3   ¦   °--6:2                                    
#> 4   ¦       °--160:2                              
#> 5   ¦           °--110:2                          
#> 6   ¦               °--3.9:2                      
#> 7   ¦                   ¦--2.62:1                 
#> 8   ¦                   ¦   °--16.46:1            
#> 9   ¦                   ¦       °--0:1            
#> 10  ¦                   ¦           °--1:1        
#> 11  ¦                   ¦               °--4:1    
#> 12  ¦                   ¦                   °--4:1
#> 13  ¦                   °--2.875:1                
#> 14  ¦                       °--17.02:1            
#> 15  ¦                           °--0:1            
#> 16  ¦                               °--1:1        
#> 17  ¦                                   °--4:1    
#> 18  ¦                                       °--4:1
#> 19  ¦--22.8:2                                     
#> 20  ¦   °--... 1 nodes w/ 18 sub                  
#> 21  °--... 23 nodes w/ 296 sub
```

## Help & feedbacks wanted\!

If you find that this package is an idea worth pursuing, please let me
know. Developing is always more fun when it becomes a collaborative
work. So please also email me (or leave an issue) if you want to get
involved\!
