% How to run this script:
%
%  time matlab -nodisplay -nodesktop -r "run timeSeries_AOA.m"
%
% Start time
%-----------
fprintf('--------------------------\n')
fprintf('Reading netCDF files \n')
fprintf('--------------------------\n')

tic

vName = 'aoa';
begYear = 1990;
endYear = 2009;

firstFile = 0;

numDays = 0;
coef = 365.5;

ref_lat = -86.0;

refDIR = '../Data/';

% Loop over the years
%--------------------
for year = begYear:endYear
    %fprintf('Processing files for Year %5g \n', year)

    dirY = strcat(refDIR, 'Y', num2str(year), '/');
    listFiles = dir(strcat(dirY, 'runAOA.TR.', num2str(year), '*_1200z.nc4'));

    numDays = numDays + numel(listFiles);

    % Loop over the daily files
    %--------------------------
    for idx = 1:numel(listFiles)
        filepath = [dirY,  listFiles(idx).name];
            
        % Extract information if it is the first file
        %--------------------------------------------
        if firstFile == 0
           lons = ncread(filepath, 'lon'); 
           lats = ncread(filepath, 'lat'); 
           levs = ncread(filepath, 'lev'); 
           [nlons m] = size(lons);
           [nlats m] = size(lats);
           [nlevs m] = size(levs);

           lat_index = find(lats == ref_lat);

           % levs = calcPressureLevels(nlevs);
        end;

        % Read the daily average age of air
        %----------------------------------
        var = ncread(filepath, vName, [1 lat_index 1 1], [Inf 1 Inf 1], [1 1 1 1]) /coef; 

        % Determine the zonal mean
        %-------------------------
        tempVar = mean(var,1);
        tempVar = squeeze(tempVar);

        % Stack the daily values into an existing array
        %----------------------------------------------
        if firstFile == 0
           firstFile = 1;
           dataVal = tempVar;
        else
           dataVal = [dataVal,tempVar];
        end
    end
end

% End time
%-----------
toc

if numDays == 7305
    fprintf('Succesfully processed %5g files \n', numDays)
else
    fprintf('Only processed %5g files. Verify that all is well! \n', numDays)
end
