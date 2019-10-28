fprintf('--------------------------\n')
fprintf('Reading netCDF files \n')
fprintf('--------------------------\n')

tic

var_name = 'aoa';
start_year = 1990;
end_year = 2009;

first_file = 0;

num_days = 0;
coefficient = 365.5;

reference_latitude = -86.0;

reference_directory = '../Data/';

% Loop over the years
for year = start_year:end_year
    %fprintf('Processing files for Year %5g \n', year)

    directory_y = strcat(reference_directory, 'Y', num2str(year), '/');
    list_files = dir(strcat(directory_y, 'runAOA.TR.', num2str(year), '*_1200z.nc4'));

    num_days = num_days + numel(list_files);

    % Loop over the daily files
    for index = 1:numel(list_files)
        filepath = [directory_y,  list_files(index).name];
            
        % Extract information if it is the first file
        if first_file == 0
            longitudes = ncread(filepath, 'lon'); 
            latitudes = ncread(filepath, 'lat'); 
            levels = ncread(filepath, 'lev'); 
            [num_longitudes m] = size(longitudes);
            [num_latitudes m] = size(latitudes);
            [num_levels m] = size(levels);

            lat_index = find(latitudes == reference_latitude);

            %levels = calcPressureLevels(num_levels);
        end;

        % Read the daily average age of air
        var = ncread(filepath, var_name, [1 lat_index 1 1], [Inf 1 Inf 1], [1 1 1 1]) /coefficient; 

        % Determine the zonal mean
        temp_var = mean(var,1);
        temp_var = squeeze(temp_var);

        % Stack the daily values into an existing array
        if first_file == 0
            first_file = 1;
            data_val = temp_var;
        else
            data_val = [data_val, temp_var];
        end
    end
end

% End time
toc

if num_days == 7305
    fprintf('Succesfully processed %5g files \n', num_days)
else
    fprintf('Only processed %5g files. Verify that all is well! \n', num_days)
end
