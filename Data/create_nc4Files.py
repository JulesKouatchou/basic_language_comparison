#!/usr/bin/env python

from __future__ import print_function

#-------------
# Load modules
#-------------
import os
import sys
from netCDF4 import Dataset
import numpy as np
import datetime as dttime

begYear = 1990 # starting year
endYear = 2009 # ending year

nlats = 181  # number of latitudes
nlons = 360  # number of longitudes
nlevs = 72   # number of vertical levels

def num_days_months(y):
    """
      For a given year, provide the number of days of each month.
    """
    ndays = [31,28,31,30,31,30,31,31,30,31,30,31]
    if y%4 == 0:
       ndays[1] = 29
    return ndays

def create_nc4_file(fname, y, m, d, var):
    """
       Create a netCDF file.
    """
    with Dataset(fname, mode='w') as ncFid:
         #------------------------
         # Defining the dimensions
         #------------------------
         time = ncFid.createDimension('time', None)
         lev  = ncFid.createDimension('lev', nlevs)
         lat  = ncFid.createDimension('lat', nlats)
         lon  = ncFid.createDimension('lon', nlons)

         #------------------------------------------
         # Creating variables and Setting attributes
         #------------------------------------------
         longitudes = ncFid.createVariable('lon','f8',('lon',))
         longitudes.long_name = 'longitude'
         longitudes.units = 'degrees east'

         latitudes = ncFid.createVariable('lat','f8',('lat',))
         latitudes.long_name = 'latitude'
         latitudes.units = 'degrees north'

         levels = ncFid.createVariable('lev','f8',('lev',))
         levels.long_name = 'vertical level'
         levels.units = 'layer'
         levels.positive = 'down'
         levels.coordinate = 'eta'
         levels.standard_name = 'model_layers'

         times = ncFid.createVariable('time','i4',('time',))
         times.long_name='time'
         times.units = 'minutes since '+str(y)+'-'+str(m).zfill(2)+'-'+str(d).zfill(2)+' 12:00:00'
         times.time_increment = 240000
         times.begin_date = 10000*y + 100*m + d
         times.begin_time = 120000

         aoa = ncFid.createVariable('aoa','f4',('time','lev','lat','lon',))
         aoa.units = 'days'
         aoa.valid_min = 0.0
         aoa.valid_max = 15.0
         aoa._FilledValue = 1.0e15
         aoa.scale_factor = 1.0
         aoa.add_offset = 0.0
         aoa.standard_name = 'Age of air (uniform source) tracer'

         ncFid.Title = 'Age-of-Air_experiments'
         ncFid.comment = 'Sample netCDF file to simulate Age-of-Air'

         #---------------
         # Setting values
         #---------------
         delta_lat = 180.0 / nlats
         delta_lon = 360.0 / nlons
         latitudes[:]  =  np.linspace( -90.0,  90.0, num=nlats)
         longitudes[:] =  np.linspace(-180.0, 180.0, num=nlons, endpoint=False)
         levels[:]     =  np.arange(1, 73)
         aoa[0,:,:,:]  = var

beg_time = dttime.datetime.now()

print(31*'-')
print('Begin the creation of the files')
print(31*'-')

# Get the current directory
cwd = os.getcwd()

range_year = endYear - begYear + 1

for iy in np.arange(begYear, endYear+1):

    print('    ---> Year: %d' %(iy))

    # Number of days of each month of the year
    ndays = num_days_months(iy)

    #----------------------------------
    # Create the directory for the year
    #----------------------------------
    cyear = cwd+'/Y'+str(iy)
    if not os.path.exists(cyear):
       os.makedirs(cyear)

    os.chdir(cyear)

    # Loop over the months
    for im in np.arange(1,12+1):
        # Loop over the days
        for id in np.arange(1,ndays[im-1]+1):
            fname = 'runAOA.TR.'+str(iy)+str(im).zfill(2)+str(id).zfill(2)+'_1200z.nc4'

            var = (iy-begYear+1)*np.random.uniform(low=0.0, high=10.0, size=(nlevs, nlats, nlons))/range_year
            create_nc4_file(fname, iy, im, id, var)

end_time    = dttime.datetime.now()
delta       = end_time-beg_time
elapsed_time = ((1000000 * delta.seconds + delta.microseconds) / 1000000.0)
print('%s  %15.4f s' % ('Processing time: ', elapsed_time))
