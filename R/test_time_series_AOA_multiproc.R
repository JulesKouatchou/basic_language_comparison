#!/usr/bin/env Rscript

# Import packages
library(foreach)
library(doParallel)
library(ncdf4)
library(RColorBrewer)
library(rbenchmark)


CalculatePressureLevels <- function(num.levels) {
  # Read a total of num.levels vertical levels from the file and calculate the  pressure.
  #
  # Inputs:
  #   num.levels: Number of vertical levels.
  #
  # Returns:
  #   pressure.levels: Pressure levels from bottom to top.
  ak <- array(0.0, dim=c(num.levels+1))
  bk <- array(0.0, dim=c(num.levels+1))
  pressure.levels <- array(0.0, dim=c(num.levels))
  filename <- paste(toString(num.levels), '-layer.p', sep='')
  file.id <- read.table(filename, skip=2)
  for (k in 0:num.levels+1) {
    ak[k] <- file.id[k, 2]
    bk[k] <- file.id[k, 3]
  }

  for (k in 1:num.levels) {
    pressure.levels[k] <- 0.50*((ak[k] + ak[k+1]) + 0.01*1.00e+05*(bk[k] + bk[k+1]))
  }
  return(rev(pressure.levels))
}


GetLevels <- function(filename) {
  # Determine the number of values in the file. Use it in the CalculatePressureLevels function to get the pressures.
  #
  # Inputs:
  #   filename: The netCDF file to read.
  #
  # Returns:
  #   levels: The array of calculated pressures.
  library(ncdf4)
  open.file <- nc_open(filename)
  levels <- ncvar_get(open.file, "lev")
  num.levels <- dim(levels)
  nc_close(open.file)

  levels <- CalculatePressureLevels(num.levels)

  return(levels)
}


GetDataFromFile <- function(filename) {
  # Calculate the zonal means using data from the file. 
  #
  # Inputs:
  #   filename: The netCDF file to read.
  #
  # Returns:
  #   temp.variable: The zonal means.
  library(ncdf4)
  coefficient <- 365.5
  set.latitude = -86.0
  open.file <- nc_open(filename)
  latitudes <- ncvar_get(open.file, "lat")
  latitude.start.index <- which(open.file$dim$lat$vals == set.latitude)

  # Read the daily average age of air at latitute set.latitude
  age.of.air <- ncvar_get(open.file, variable.name)[, latitude.start.index, ]/coefficient

  # Determine the zonal mean
  temp.variable <- apply(age.of.air, c(2), mean)
  temp.variable <- rev(temp.variable)  # reverse the vertical levels

  nc_close(open.file)
  #cat("temp.variable: ", length(temp.variable), "\n")
  return(temp.variable)
}


cat("-------------------------------\n")
cat("Parallel Time Series Processing\n")
cat("-------------------------------\n")

# Get the command line argument.
args <- commandArgs(trailingOnly=TRUE)

# Start time
benchmark("TimeSeries" = {
  variable.name <- 'aoa'
  start.year <- 1990
  end.year <- 2009
  #end.year <- 1990
  num.days <- 0
  num.threads <- as.integer(args[1])
  data.value <- {}
  reference.directory <- '../Data/'

  # Loop over the years
  for (year in start.year:end.year) {
    cat("Processing files for Year", year, "\n")
    directory.Y <- paste(reference.directory, 'Y', toString(year), '/', sep='')

    files.list <- Sys.glob(paste(directory.Y, "runAOA.TR.", toString(year), "*_1200z.nc4", sep=''))

    num.files <- length(files.list)
    num.days <- num.days + num.files

    #cat("Number of files: ", num.files, "\n")
    #temp.variable <- vector("list", num.files) 
              
    registerDoParallel(num.threads)
              
    # Loop over the daily files
    temp.variable <- foreach(index = 1:num.files,
                             .combine = list, 
                             .multicombine = TRUE) %dopar% 
      list(GetDataFromFile(files.list[index]))
    stopImplicitCluster()          
    #print(temp.variable)
    #cat("\n")
    #cat("\n")
    #print(temp.variable[2])
    #cat("\n")

    # Stack the daily values into an existing array
    if (length(data.value) == 0) {
      data.value <- unlist(temp.variable[1])
      for (i in 2:num.files) {
        data.value <- rbind(data.value, unlist(temp.variable[i]))
      }
    } else {
      for (i in 1:num.files) {
        data.value <- rbind(data.value, unlist(temp.variable[i]))
      }
    }
    
  }
},
  replications = 1,
  columns = c("test", "replications", "elapsed", "relative", "user.self", "sys.self"))

quit()





levels <- GetLevels(files.list[1])

cat(" \n")
cat(" \n")

cat(" \n")
cat("Number of days: ", num.days, "\n")
cat(" \n")
cat("Dim of data.value: ", dim(data.value), nrow(data.value), ncol(data.value), "\n")
cat(" \n")

# Plot the mean at a specified level

# x-axis
days <- 1:num.days
x.tick <- pretty(days)
#x.ticks = [day for day in days if day%365 == 0] # Only pull out full years
#x.labels = [str(i+start.year) for i in range(len(x.ticks))]

# y-axis
pressure.levels <- 1:length(levels)
y.tick <- log10(levels)
#y.tick <- pretty(y.tick)

# Set the colormap
k <- 7
columns <- rev(brewer.pal(k, "RdYlBu"))

# Save the figure in a png file
figure.name  <- 'figure_time_series_AOA__multiproc_R.png'
png(filename=figure.name, width=800, height=600, bg="white")

#par(ylog=TRUE, yaxp= c(levels[1], levels[nlevs], 5))
#contour(days, log10(levels), data.value, 
contour(days, pressure.levels, data.value, 
        xlim=c(1, length(days)),
        col=columns,
        #log='y',
        xlab='Year', ylab='Pressure (hPa)',
        main="Age-of-Air (years) at 86^o S")
#axis(side=2, at = y.tick, labels = y.tick)

