# Assessment: Web Scraping
# Load the following web page, which contains information about Major 
# League Baseball payrolls, into
# R: https://web.archive.org/web/20181024132313/http://www.stevetheump.com/Payrolls.htm
library(rvest)
url <- "https://web.archive.org/web/20181024132313/http://www.stevetheump.com/Payrolls.htm"
h <- read_html(url)
# We learned that tables in html are associated with the table node.  
# Use the html_nodes() function and the table node type to extract the first table. 
# Store it in an object nodes:
nodes <- html_nodes(h, "table")
# The html_nodes() function returns a list of objects of class xml_node. 
# We can see the content of each one using, for example, the html_text() function. 
# You can see the content for an arbitrarily picked component like this:
html_text(nodes[[8]])
# If the content of this object is an html table, we can use the html_table() 
# function to convert it to a data frame:
html_table(nodes[[8]])
# You will analyze the tables from this HTML page over questions 1-3.

#......................Question 1.........................

# Many tables on this page are team payroll tables, 
# with columns for rank, team, and one or more money values.
# Convert the first four tables in nodes to data frames and inspect them.
# Which of the first four nodes are tables of team payroll?

html_table(nodes[[1]])
# The first node is not a table
html_table(nodes[[2]])
# The second node is a table
html_table(nodes[[3]])
# The third node is a table
html_table(nodes[[4]])
# Using lappy to apply a function over a list or vector.To check html_table function
# for the first 4 nodes, we can use lapply() or 
lapply(nodes[1:4], html_table)
# sapply(nodes[1:4], html_table) #  also works

##### Answer: Table 2,Table 3 & Table 4

#......................Question 2.........................

# For the last 3 components of nodes, which of the following are true?
# (Check all correct answers.)
# First we check how many nodes are there using length() function
length_n <- length(nodes)
length_n # we see that there are 21 nodes
html_table(nodes[length_n])
html_table(nodes[21])-
html_table(nodes[20])
# conclusion:  2-20 entries are tables of payroll per team.
            # the last entry is diffrent 
##### Answer: All three entries are tables.
##### Answer: The last entry shows the average across all teams through time, 

#......................Question 3.........................

# Create a table called tab_1 using entry 10 of nodes. Create a table 
# called tab_2 using entry 19 of nodes.
# Note that the column names should be c("Team", "Payroll", "Average"). 
# You can see that these column names are actually in the first data row of 
# each table, and that tab_1 has an extra first column No. that should be 
# removed so that the column names for both tables match.
# Remove the extra column in tab_1, remove the first row of each dataset, and change the column names for each table to c("Team", "Payroll", "Average"). Use a full_join() by the Team to combine these two tables.
nodes <- html_nodes(h, "table")
# How many rows are in the joined data table?
library(tidyverse)
tab1<-select()
setNames(c("Team", "Payroll", "Average"))

tab_1 <- html_table(nodes[10])
tab_1 <- as.data.frame(tab_1)
tab_1
tab_1 <- tab_1[-1, -1] # remove the first row and first column 
tab_2 <- html_table(nodes[19])
tab_2 <- as.data.frame(tab_2)
tab_2
tab_2 <- tab_2[-1,]# remove the first row 
names(tab_1) <- c("Team", "Payroll", "Average")
names(tab_2) <- c("Team", "Payroll", "Average")
full_join(tab_1,tab_2, by = "Team") %>% 
  nrow()
##### Answer:58

# Introduction: Questions 4 and 5
# The Wikipedia page on opinion polling for the Brexit referendum External link,
# in which the United Kingdom voted to leave the European Union in June 2016, 
# contains several tables. 
# One table contains the results of all polls regarding the referendum over 2016:

# Use the rvest library to read the HTML from this Wikipedia page 
# (make sure to copy both lines of the URL):
library(rvest)
library(tidyverse)
url_new  <- "https://en.wikipedia.org/w/index.php?title=Opinion_polling_for_the_United_Kingdom_European_Union_membership_referendum&oldid=896735054"

#......................Question 4.........................

# Assign tab to be the html nodes of the "table" class.

# How many tables are in this Wikipedia page?
h <- read_html(url_new)
nodes <- html_nodes(h, "table")
length_n <- length(nodes)
length_n # we see that there are 41 nodes

##### Answer:41

#......................Question 5.........................

# Inspect the first several html tables using html_table() with the argument 
# fill=TRUE (you can read about this argument in the documentation). 
# Find the first table that has 9 columns with the first column named 
# "Date(s) conducted".

# What is the first table number to have 9 columns where the first column 
# is named "Date(s) conducted"?
tab_1<-nodes[[1]] %>% html_table(fill = TRUE)
names(tab_1)
tab_2<-nodes[[2]] %>% html_table(fill = TRUE) 
names(tab_2)
tab_3<-nodes[[3]] %>% html_table(fill = TRUE)
names(tab_3)
tab_4<-nodes[[4]] %>% html_table(fill = TRUE)
names(tab_4)
view(tab_4)
tab_5<-nodes[[5]] %>% html_table(fill = TRUE)
names(tab_5)
tab_6<-nodes[[6]] %>% html_table(fill = TRUE)
names(tab_6)

##### Answer: Table 6
