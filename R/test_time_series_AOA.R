#!/usr/bin/env Rscript

library(ncdf4)
library(RColorBrewer)
library(rbenchmark)


CalculatePressureLevels <- function(num.levels) {
  # Read a total of num.levels vertical levels from the file and calculate the pressure.
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


cat("-----------------------------\n")
cat("Serial Time Series Processing\n")
cat("-----------------------------\n")

benchmark("seqTimeSeries" = {
  variable.name <- 'aoa'
  start.year <- 1990
  end.year <- 2009
  first.file <- 0
  num.days <- 0
  coefficient <- 365.5
  set.latitude = -86.0
  reference.directory <- '../Data/'
  
  # Loop over the years
  for (year in start.year:end.year) {
    cat("Processing files for Year", year, "\n")
    directory.Y <- paste(reference.directory, 'Y', toString(year), '/', sep='')              
    files.list <- Sys.glob(paste(directory.Y, "runAOA.TR.", toString(year), "*_1200z.nc4", sep=''))

    num.files <- length(files.list)
    num.days <- num.days + num.files
              
    # Loop over the daily files.
    for (file in files.list) {
      # Open file.
      open.file <- nc_open(file)

      # Extract information if it is the first file.
      if (first.file == 0) {
        #longitudes <- ncvar_get(open.file, "lon") 
        latitudes <- ncvar_get(open.file, "lat") 
        #levels <- ncvar_get(open.file, "lev")
        #num.longitudes <- dim(longitudes)
        num.latitudes <- dim(latitudes)
        #num.levels <- dim(levels)
        latitude.start.index <- which( open.file$dim$lat$vals == set.latitude)
        #levels <- CalculatePressureLevels(num.levels)
      }

      # Read the daily average age of air at latitute set.latitude
      age.of.air <- ncvar_get(open.file, variable.name)[, latitude.start.index, ] / coefficient  

      # Determine the zonal mean
      temp.variable <- apply(age.of.air, c(2), mean)
      temp.variable <- rev(temp.variable)  # reverse the vertical levels
              
      # Stack the daily values into an existing array
      if (first.file == 0) {
        data.value <- temp.variable
        first.file <- 1
      } else {
        data.value <- rbind(data.value, temp.variable)
      }    

      # Close file
      nc_close(open.file)
    }
  }
},
  replications = 1,
  columns = c("test", "replications", "elapsed", "relative", "user.self", "sys.self"))

quit()

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
figure.name <- 'figure_time_series_AOA_R.png'
png(filename=figure.name, width=800, height=600, bg="white")

#par(ylog=TRUE, yaxp= c(levels[1], levels[num.levels], 5))
cat("\n")
cat("Days: ", length(days), "\n")
cat("levels: ", length(levels), "\n")
cat("data.value: ", dim(data.value), "\n")
cat("\n")

#contour(days, log10(levels), data.value, 
        #xlim=c(1, length(days)),
        #col=columns,
        #log='y',
contour(days, pressure.levels, data.value, 
        col=columns,
        xlab='Year', ylab='Pressure (hPa)',
        main="Age-of-Air (years) at 86^o S")
#axis(side=2, at = y.tick, labels = y.tick)
