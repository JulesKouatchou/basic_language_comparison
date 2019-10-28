#!/usr/bin/env Rscript

#import packages
library(ncdf4)

source("vertLevels_GEOS5.R")

getLevels <- function(fileName) {

    nf <- nc_open(fileName)
    levs <- ncvar_get(nf, "lev")
    nlevs <- dim(levs)
    nc_close(nf)

    levs <- calcPressureLevels(nlevs)

    return(levs)

}
