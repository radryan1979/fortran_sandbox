! This is part of the netCDF package.
! Copyright 2006 University Corporation for Atmospheric Research/Unidata.
! See COPYRIGHT file for conditions of use.

! This is a simple example which reads a small dummy array, from a
! netCDF data file created by the companion program simple_xy_wr.f90.

! This is intended to illustrate the use of the netCDF fortran 90
! API. This example program is part of the netCDF tutorial, which can
! be found at:
! http://www.unidata.ucar.edu/software/netcdf/docs/netcdf-tutorial

! Full documentation of the netCDF Fortran 90 API can be found at:
! http://www.unidata.ucar.edu/software/netcdf/docs/netcdf-f90

! $Id: simple_xy_rd.f90,v 1.10 2009/02/25 21:44:07 ed Exp $

program simple_xy_rd
    use netcdf
    implicit none

    ! Name of file
    character (len = *), parameter :: FILE_NAME = "simple_xy.nc"

    ! Reading the 2d data of 12x6 grid
    integer, parameter :: NX = 6, NY = 12
    integer :: data_in(NY, NX)

    ! netCDF file and var IDs
    integer :: ncid, varid

    ! some loop indexes
    integer :: x, y

    ! open the file read only
    ! using check subroutine below
    call check( nf90_open(FILE_NAME, NF90_NOWRITE, ncid) )

    ! Get the varid of the data variable based on name
    call check( nf90_inq_varid(ncid, "data", varid) )

    ! Read the data
    call check( nf90_get_var(ncid, varid, data_in) )

    ! print the data
    print *, "The data is:"
    do x = 1, NX
        do y=1, NY
            print *, data_in(y,x)
        end do
    end do

    ! Close the file
    call check( nf90_close(ncid) )

    print *,"*** SUCCESS reading example file", FILE_NAME, "! "

    contains
    subroutine check(status)
        integer, intent (in) :: status

        if(status /= nf90_noerr) then
            print *, trim(nf90_strerror(status))
            stop 2
        end if
    end subroutine check

end program simple_xy_rd