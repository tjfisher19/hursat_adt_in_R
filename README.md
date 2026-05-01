# HURSAT-ADT data in R

This repo includes R code to download the [HURSAT-ADT data](https://www.ncei.noaa.gov/products/advanced-dvorak-technique-hurricane-satellite) and then process the NetCDF files into an R data frame.

## 01_fetching_hursat_adt.R

This code downloads all HURSAT ADT NetCDF files in the NCEI data directory:
  https://www.ncei.noaa.gov/data/oceans/archive/arc0239/0307249/1.1/data/0-data/

## 02_processing_hursat_adt.R

This code inputs each NetCDF file extracting all variables as defined by:
  https://www.ncei.noaa.gov/sites/default/files/2026-02/ADTHURSAT%20Technical%20Documentation%20-%202.3.26.pdf

The result of this code is an R data frame with the entire HURSAT record.  The code saves the results as both a csv file (about 90MB, excluded from the repo) and an `.RData` file containing the data frame.

