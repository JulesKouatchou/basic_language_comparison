; Read data from 7305 netCDF-4 files and do plotting

FUNCTION CALC_PRESSURE_LEVS, nlevs
;    """
;      This function takes the number of vertical levels
;      to read a file that contains the values of ak and bk.
;      It then computes the pressure levels using the formula:
;
;          0.5*(ak[l]+ak[l+1]) + 0.1*1.0e5*(bk[l]+bk[l+1])
;
;      Input Varialble:
;        nlevs: number of vertical levels
;
;      Returned Value:
;        phPa: pressure levels from bottom to top
;    """

    ak   = FLTARR(nlevs+1)
    bk   = FLTARR(nlevs+1)
    phPa = FLTARR(nlevs)

    file_name = STRTRIM(nlevs,1) + '-layer.p'

    OPENR, lun, file_name, /GET_LUN

    ; Read the header
    header = STRARR(2)
    READF, lun, header

    k = 0
    WHILE (NOT EOF(lun)) DO BEGIN
        READF, lun, dump, a, b
        ak[k] = a
        bk[k] = b
        k     = k + 1
    ENDWHILE
    FREE_LUN, lun

    FOR k = 0,nlevs-1 DO BEGIN
        phPa[k] = 0.50*((ak[k] + ak[k+1])+0.01*1.00e+05*(bk[k] + bk[k+1]))
    ENDFOR

    RETURN, REVERSE(phPa)
END



PRO test_time_series_aoa

    ; Start time
    time0 = SYSTIME(/SECONDS)

    var_name = 'aoa'
    start_year = 1990
    ;end_year = 1990
    end_year = 2009

    first_file = 0
    ref_lat = -86.0

    num_days = 0

    ref_dir = '../Data/'

    coef = 365.5
    ; Loop over the years
    FOR year = start_year, end_year DO BEGIN
        ;print, "Processing files for Year:", year
        dir_y = ref_dir + 'Y' + STRTRIM(year,1)

        list_files = FILE_SEARCH(dir_y + "/runAOA.TR." + STRTRIM(year, 1) + "*_1200z.nc4")
        num_days = num_days + N_ELEMENTS(list_files)

        ; Loop over the daily files
        FOREACH file, list_files DO BEGIN
            ; Open file
            nf = NCDF_OPEN(file)

            ; Extract information if it is the first file
            IF (first_file EQ 0) THEN BEGIN
                NCDF_VARGET,nf,'lat',lats
                NCDF_VARGET,nf,'lon',lons
                NCDF_VARGET,nf,'lev',levs
                num_lons = (SIZE(lons, /Dimensions))[0]
                num_lats = (SIZE(lats, /Dimensions))[0]
                num_levs = (SIZE(levs, /Dimensions))[0]

                ;levs = CALC_PRESSURE_LEVS(num_levs)

                lat_index = VALUE_LOCATE(lats, ref_lat)
            ENDIF

            ; Read the daily average age of air
            NCDF_VARGET, nf, var_name, var, $
                         OFFSET = [0, lat_index, 0, 0], $
                         COUNT  = [num_lons, 1, num_levs, 1], $
                         STRIDE = [1, 1, 1, 1]
            var = var / coef

            ; Determine the zonal mean
            temp_var = REVERSE(MEAN(var, DIMENSION=1))

            ; Stack the daily values into an existing array
            IF (first_file EQ 0) THEN BEGIN
                first_file = 1
                data_val = temp_var
            ENDIF ELSE BEGIN
                data_val = [data_val, temp_var]
            ENDELSE
    
            ; Close file
            NCDF_CLOSE, nf
        ENDFOREACH
    ENDFOR

    ; End time
    time1 = SYSTIME(/SECONDS) - time0

    PRINT, " "
    PRINT, 'Elapsed Time for the time series calculations: ', time1

    IF (num_days EQ 7305) THEN BEGIN
        PRINT, 'Successful reading of all the files'
    ENDIF ELSE BEGIN
        PRINT, 'Only read ', num_days, ' files! Check your script.'
    ENDELSE

    RETURN
END
