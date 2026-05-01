################################################
##
##  01_fetching_hursat_adt.R
##
##  This file downloads all the HURSAT ADT
##     data files from the NOAA NCEI 
##     Website.  There are 4852 total files
##
##  Author: Tom Fisher (fishert4@miamioh.edu)
##
##  Code tested on 2026-04-29
##


library(rvest)
library(tidyverse)


base_url <- "https://www.ncei.noaa.gov/data/oceans/archive/arc0239/0307249/1.1/data/0-data/"

#############################
## Get a list of all .nc
##   files in that online
##   directory.
page <- read_html(base_url)

file_names <- page %>% 
  html_nodes("a") %>% 
  html_attr("href") %>% 
  .[grepl("\\.nc$", .)] # Filter for CSV files

################################
## Download each file
get_hursat_adt_nc_files <- function(file_name) {
  full_url <- paste0(base_url, file_name)
  download.file(full_url, paste0("./data_hursat_adt_raw/", file_name), mode="wb")
  "Done"
}

## Note -- this takes quite a long time
lapply(file_names, get_hursat_adt_nc_files)

##
## Here is another version where you specify the 
##    files to get. I needed to edit this a few 
##    times because the computer went into stanby mode.
# lapply(file_names[3415:4852], get_hursat_adt_nc_files)

