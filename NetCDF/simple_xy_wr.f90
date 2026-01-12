! Ryan - 1/11/2026
!
!     This is part of the netCDF package.
!     Copyright 2006 University Corporation for Atmospheric Research/Unidata.
!     See COPYRIGHT file for conditions of use.

!     This is a very simple example which writes a 2D array of
!     sample data. To handle this in netCDF we create two shared
!     dimensions, "x" and "y", and a netCDF variable, called "data".

!     This example demonstrates the netCDF Fortran 90 API. This is part
!     of the netCDF tutorial, which can be found at:
!     http://www.unidata.ucar.edu/software/netcdf/docs/netcdf-tutorial

!     Full documentation of the netCDF Fortran 90 API can be found at:
!     http://www.unidata.ucar.edu/software/netcdf/docs/netcdf-f90

!     $Id: simple_xy_wr.f90,v 1.10 2008/08/20 22:43:53 russ Exp $

program simple_xy_wr
    use netcdf
    implicit none

    ! Name of the data file created
    character (len = *), parameter :: FILE_NAME = "simple_xy.nc"

    ! Writing 2D data, 12x6 grid
    integer, parameter :: NDIMS = 2
    integer, parameter :: NX = 6, NY = 12

    ! netCDF gives back ID for creation of
    ! files, vars, and dims
    integer :: ncid, varid, dimids(NDIMS)
    integer :: x_dimid, y_dimid

    ! The array we will write
    ! Remember Fortran is column major
    integer :: data_out(NY, NX)

    ! Indexes for the loops
    integer :: x, y

    ! Make some fake data for our array
    do x = 1, NX
        do y = 1, NY
            data_out(y,x) = (x-1) * NY + (y-1)
        end do
    end do

    ! netCDF always gives a return code
    ! it should be zero for success
    ! see subroutine for check below

    ! Create the file
    ! ncid becomes the reference to the file
    call check( nf90_create(FILE_NAME, NF90_CLOBBER, ncid) )

    ! Define the dimensions, netcdf gives back
    ! an ID for each
    call check( nf90_def_dim(ncid, "x", NX, x_dimid))
    call check( nf90_def_dim(ncid, "y", NY, y_dimid))

    ! dimids array is used to pass the IDs of dimensions
    ! of the variables
    dimids = (/ y_dimid, x_dimid /)

    ! Now define the variable, we'll use 4-byte int
    ! NF90_INT
    call check( nf90_def_var(ncid, "data", NF90_INT, dimids, varid) )

    ! Now we end the defining mode, we're done
    ! defining metadata
    call check( nf90_enddef(ncid) )

    ! Write some data to the file
    ! This example we're writing all the data
    ! in one operation
    call check( nf90_put_var(ncid, varid, data_out) )

    ! Close the file and free up resources
    call check( nf90_close(ncid) )

    print *, "*** SUCCESS writing example file simple_xy.nc! "

    contains
    subroutine check(status)
        integer, intent (in) :: status

        if(status /= nf90_noerr) then
            print *, trim(nf90_strerror(status))
            stop 2
        end if
    end subroutine check

end program simple_xy_wr
