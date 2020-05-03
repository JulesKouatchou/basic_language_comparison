#!/usr/bin/env julia

using BenchmarkTools
using NetCDF
using Printf

"""
    calculate_pressure_levels(numlevels)

Calculate pressure levels using data from a file for a total number of levels numlevels.
"""
function calculate_pressure_levels(numlevels)
    ak   = zeros(Float32, numlevels+1)
    bk   = zeros(Float32, numlevels+1)
    pressures = zeros(Float32, numlevels)

    filename = string(string(numlevels), "-layer.p")
    fileid = open(filename);
    lines = readlines(fileid);
    linenumber = 1;
    k = 1;
    for line in lines
        linenumber += 1;
        if linenumber > 3
            line = strip(line);
            columns = split(line);
            ak[k] = float(columns[2]);
            bk[k] = float(columns[3]);
            k += 1;
        end
    end
    close(fileid);
    
    for k in 1:numlevels
        pressures[k] = 0.50*((ak[k] + ak[k+1]) + 0.01*1.00e+05*(bk[k] + bk[k+1]));
    end
    return pressures[numlevels:-1:1]
end


"""
    getdata(file)

Read and manipulate a data point from file.
"""
function getdata(file)
    coefficient = 365.5
    variablename = "aoa"
    referencelatitude = -86.0

    #latitudes = ncread(file, "lat")
    #latitudeindex = findfirst(latitudes, referencelatitude)
    #startlist = [1, latitudeindex, 1, 1]
    startlist = [1, 5, 1, 1]
    countlist = [-1, 1, -1, 1]

    # Read the daily average age of air
    ageofair = ncread(file, variablename, start=startlist, count=countlist) / coefficient

    # Determine the zonal mean
    zonalmean = mean(ageofair, 1)
    zonalmean = zonalmean[1, 1, :, 1]

    return zonalmean
end


"""
    getlevels(file)

Get the array of levels data from file.
"""
function getlevels(file)
    levels = ncread(file, "lev")
    numlevels = length(levels)
    #levels = calculate_pressure_levels(numlevels)
    return levels
end 


# Start time
@btime begin

    startyear = 1990
    endyear = 2009
    firstfile = 0
    numdays = 0
    datavalue = zeros(72)
    reference_directory = "../Data/"

    # Loop over the years
    for year in startyear:endyear
        #println( "Processing files for ", year)
        directoryY = reference_directory*"Y"* string(year)*"/"
        fileslist = filter(x -> endswith(x, "_1200z.nc4"),  readdir(directoryY))
        fileslist = [file for file in fileslist]
        numdays = numdays + length(fileslist)

        # Loop over the daily files
        for f in fileslist
            file = string(directoryY, f)
            #println( "     --->File: ", file)
            tempvariable = getdata(file)
            if firstfile == 0
                levels = getlevels(file)
            end 
            
            # Stack the daily values into an existing array
            datavalue = hcat(datavalue,tempvariable)
        end
    end

    # Remove the first row
    datavalue = datavalue[setdiff(1:end, 1),:] # delete the first row

# End time
end

#if numDays == 7305
#   println("Successfully read ", numDays, "files")
#else
#   println("Only read ", numDays, "files! Check your script.")
#end
