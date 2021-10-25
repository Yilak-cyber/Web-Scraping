################
# Web Scraping #
################

# Web scraping is extracting data from a website.
# The rvest web harvesting package includes functions to extract nodes of 
# an HTML document: html_nodes() extracts all nodes of different types, and 
# html_node() extracts the first node.
# html_table() converts an HTML table to a data frame.
# import a webpage into R
library(tidyverse)
library(rvest)
url <- "https://en.wikipedia.org/wiki/Murder_in_the_United_States_by_state"
h <- read_html(url)
class(h)
h

tab <- h %>% html_nodes("table")
tab
tab <- tab[[2]]

tab <- tab %>% html_table
class(tab)
tab

tab <- tab %>% setNames(c("state", "population", "total", "murders", "gun_murders", "gun_ownership", "total_rate", "murder_rate", "gun_murder_rate"))
head(tab)
view(tab)
as_tibble(tab)
#################
# CSS Selectors #
#################
# we will try to extract the recipe name, total preparation time, 
# and list of ingredients from this guacamole recipe

h <- read_html("http://www.foodnetwork.com/recipes/alton-brown/guacamole-recipe-1940609")
recipe <- h %>% html_node(".o-AssetTitle__a-HeadlineText") %>% html_text()
prep_time <- h %>% html_node(".m-RecipeInfo__a-Description--Total") %>% html_text()
ingredients <- h %>% html_nodes(".o-Ingredients__a-Ingredient") %>% html_text()
# we are now ready to extract what we want and create a list:
guacamole <- list(recipe, prep_time, ingredients)
guacamole
# Since recipe pages from this website follow this general layout,
# we can use this code to create a function that extracts this information:
get_recipe <- function(url){
  h <- read_html(url)
  recipe <- h %>% html_node(".o-AssetTitle__a-HeadlineText") %>% html_text()
  prep_time <- h %>% html_node(".m-RecipeInfo__a-Description--Total") %>% html_text()
  ingredients <- h %>% html_nodes(".o-Ingredients__a-Ingredient") %>% html_text()
  return(list(recipe = recipe, prep_time = prep_time, ingredients = ingredients))
} 
# and then use it on any of their webpages:
get_recipe("http://www.foodnetwork.com/recipes/food-network-kitchen/pancakes-recipe-1913844")
head(get_recipe)
as_tibble(head(get_recipe))



url2<-"https://data.chhs.ca.gov/dataset/31f19bf7-2ca3-4834-8e2f-5551c0c72c8c/resource/f349bee2-550e-4043-a0ea-5c307da85a51/download/covid19_patient_09.30.2021.csv"
COVID_19_Data<-read_csv(url2)
view(COVID_19_Data)