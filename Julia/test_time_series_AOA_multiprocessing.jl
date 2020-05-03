#!/usr/bin/env python

using BenchmarkTools
using Printf
using NetCDF
@everywhere using NetCDF


@everywhere begin
    """
        calculate_pressure_levels(numlevels)

    Calculate pressure levels using data from a file for a total number of levels numlevels.
    """
    function calcPressureLevels(numlevels)
        ak = zeros(Float32, numlevels + 1)
        bk = zeros(Float32, numlevels + 1)
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
end

@everywhere begin
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
        #println( "     --->File: ", file)
        ageofair = ncread(file, variablename, start=startlist, count=countlist) / coefficient

        # Determine the zonal mean
        zonalmean = mean(ageofair, 1)
        zonalmean = zonalmean[1 , 1, :, 1]
    
        return zonalmean
    end
end

@everywhere begin
    """
        getlevels(file)

    Get the array of levels data from file.
    """
    function getlevels(file)
        levels = ncread(file, "lev")
        numlevels = length(levels)
        levels = calcPressureLevels(numlevels)
        return levels
    end 
end


@everywhere begin
    """
        getwholedata(startyear, endyear)

    Get and manipulate data from all of the files.
    """
    function getwholedata(startyear, endyear)
        numdays = 0
        datavalue = zeros(72)

        reference_directory = "../Data/"

        # Loop over the years
        for year in startyear:endyear
            #println( "Processing files for ", year)
            directoryY = reference_directory*"Y"*string(year)*"/"
            fileslist = filter(x -> endswith(x, "_1200z.nc4"),  readdir(directoryY))
            fileslist = [file for file in fileslist]
            numfiles = length(fileslist)
            numdays = numdays + numfiles

            # Loop over the daily files
            @sync begin
                tempvariable = @parallel (hcat) for i = 1:numfiles
                    getdata(string(directoryY, fileslist[i]));
                end;
            end

            # Stack the daily values into an existing array
            datavalue = hcat(datavalue, tempvariable)
            #println(month, "       Size of datavalue: ", size(datavalue))    
        end

        @everywhere Base.flush_gc_msgs()
        @everywhere gc()

        return numdays, datavalue
    end
end


# Start time
@btime begin

startyear = 1990
endyear = 2009

numdays, datavalue = getwholedata(startyear, endyear);

    # Remove the first row
    datavalue = datavalue[setdiff(1:end, 1), :] # delete the first row

# End time
end

if numdays == 7305
   println("Successfully read ", numdays, "files")
else
   println("Only read ", numdays, "files! Check your script.")
end
