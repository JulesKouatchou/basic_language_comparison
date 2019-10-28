#!/usr/bin/env Rscript

calcPressureLevels <- function(nlevs) {
#    """
#      This function takes the number of vertical levels
#      to read a file that contains the values of ak and bk.
#      It then computes the pressure levels using the formula:
#
#          0.5*(ak[l]+ak[l+1]) + 0.1*1.0e5*(bk[l]+bk[l+1])
#
#      Input Varialble:
#        nlevs: number of vertical levels
#
#      Returned Value:
#        phPa: pressure levels from bottom to top
#    """
    ak   <- array(0.0, dim=c(nlevs+1))
    bk   <- array(0.0, dim=c(nlevs+1))
    phPa <- array(0.0, dim=c(nlevs))
    
    fileName <-  paste(toString(nlevs),'-layer.p', sep='')

    fid <- read.table(fileName, skip=2)
    for (k in 0:nlevs+1) {
        ak[k] <- fid[k,2]
        bk[k] <- fid[k,3]
    }

    for (k in 1:nlevs) {
        phPa[k] <- 0.50*((ak[k]+ak[k+1])+0.01*1.00e+05*(bk[k]+bk[k+1]))
    }

    return(rev(phPa))

}
