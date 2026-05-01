################################################
##
##  02_processing_hursat_adt.R
##
##  After all HURSAT-ADT files have been 
##     downloaded. Each NetCDF file needs
##     to be process to extract the 
##     variables. This script extracts all
##     the variables inside eash NetCDF file
##     and binds them together into a big
##     data.frame. We also add Storm ID (SID) 
##     Tropical Cyclone Year based on the
##     file name.
##
##  Author: Tom Fisher (fishert4@miamioh.edu)
##
##  Code tested on 2026-05-01
##

library(tidyverse)
library(ncdf4)

file_names <- list.files("./data_hursat_adt_raw/")

########################################
## For a given NetCDF file (nc)
##    We open the file, "get" all
##    the variables; as outlined in the
##    documentation: 
##  https://www.ncei.noaa.gov/sites/default/files/2026-02/ADTHURSAT%20Technical%20Documentation%20-%202.3.26.pdf
##
## Each processed file results in a data.frame
##   and then all are binded together.

process_file <- function(file_name) {
  tmp <- nc_open(paste0("./data_hursat_adt_raw/", file_name) )
  
  df <- data.frame(
    SID = str_remove(file_name, ".nc"),
    Date = ncvar_get(tmp, "Date"),
    Time = ncvar_get(tmp, "Time"),
    FullDay = ncvar_get(tmp, "FullDay"),
    RawT = ncvar_get(tmp, "RawT"),
    AdjT = ncvar_get(tmp, "AdjT"),
    Final = ncvar_get(tmp, "FinalT"),
    CI = ncvar_get(tmp, "CI"),
    WindSpeed = ncvar_get(tmp, "WindSpeed"),
    MSLP = ncvar_get(tmp, "MSLP"),
    EyeT = ncvar_get(tmp, "EyeT"),
    CloudT = ncvar_get(tmp, "CloudT"),
    CWT = ncvar_get(tmp, "CWT"),
    Lat = ncvar_get(tmp, "Lat"),
    Lon = ncvar_get(tmp, "Lon"),
    EyeSize = ncvar_get(tmp, "EyeSize"),
    CDOSize = ncvar_get(tmp, "CDOSize"),
    ShearDist = ncvar_get(tmp, "ShearDist"),
    EyeStdv = ncvar_get(tmp, "EyeStdv"),
    CloudSym = ncvar_get(tmp, "CloudSym"),
    SatID = ncvar_get(tmp, "SatID"),
    SatIDChar = ncvar_get(tmp, "SatIDChar"),
    EyeScene = ncvar_get(tmp, "EyeScene"),
    Scene = ncvar_get(tmp, "Scene"),
    CloudScene = ncvar_get(tmp, "CloudScene"),
    Rule9 = ncvar_get(tmp, "Rule9"),
    Rule8 = ncvar_get(tmp, "Rule8"),
    LatBias = ncvar_get(tmp, "LatBias"),
    RapWeak = ncvar_get(tmp, "RapWeak"),
    Land = ncvar_get(tmp, "Land"),
    EyeFFT = ncvar_get(tmp, "EyeFFT"),
    CloudFFT = ncvar_get(tmp, "CloudFFT"),
    RingCBnum = ncvar_get(tmp, "RingCBnum"),
    RingCBval = ncvar_get(tmp, "RingCBval"),
    CloudCWdist = ncvar_get(tmp, "CloudCWdist"),
    Position = ncvar_get(tmp, "Position"),
    MSLPAdj = ncvar_get(tmp, "MSLPAdj"),
    RMW = ncvar_get(tmp, "RMW"),
    VZA = ncvar_get(tmp, "VZA")
  )
  
  nc_close(tmp)
  
  df
}

## Input all NetCDF files and process
##  into one data.frame
all_df <- lapply(file_names, process_file)

hursat_adt_raw <- bind_rows(all_df)

save(hursat_adt_raw, file="hursat_adt_raw.RData")
#write_csv(hursat_adt_raw, file="hursat_adt_raw.csv")
