#!/usr/bin/env Rscript

#import packages
#---------------
library(ncdf4)


GetDataFromFile <- function(fileName) {
  # Count the number of unique words in the given file.
  #
  # Args:
  #   filename: The name of the file to read, including its file extension.
  #   return.an.int: 
  coef <- 365.5
  set_lat = -86.0

  nf <- nc_open(fileName)

  lats <- ncvar_get(nf, "lat")
  LatStartIdx <- which( nf$dim$lat$vals == set_lat)
  # Read the daily average age of air at latitute set_lat
  #------------------------------------------------------
  var <- ncvar_get(nf, vName)[, LatStartIdx,] / coef  #

  # Determine the zonal mean
  #-------------------------
  tempVar <- apply(var, c(2), mean)
  tempVar <- rev(tempVar)              # reverse the vertical levels

  nc_close(nf)

  return(tempVar)

}
