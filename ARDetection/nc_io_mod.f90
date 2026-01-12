! read and write for netcdf files

module nc_io_mod
    use netcdf
    implicit none
    private
    public :: read_lat_lon_time, read_field_3d, write_armask

contains

    ! make sure we always check netcdf
    ! return status for errors
    subroutine chk(status, where)
        integer, intent(in) :: status
        character(len=*), intent(in) :: where
        if (status /= nf90_noerr) then
            write(*, '(A,": ",A)') trim(where), trim(nf90_strerror(status))
            stop 2
        end if
    end subroutine chk

    ! read the lat, lon, and time from netCDF file
    subroutine read_lat_lon_time(ncfile, lat, lon, times, &
        nt, nlat, nlon, timevar)
        character(len=*), intent(in) :: ncfile
        character(len=*), intent(in) :: timevar
        real, allocatable, intent(out) :: lat(:), lon(:)
        character(len=:), allocatable, intent(out) :: times(:)
        integer, intent(out) :: nt, nlat, nlon

        integer :: ncid, varid, dimid_time, dimid_lat, dimid_lon
        integer :: status
        integer :: n_time, n_lat, n_lon
        integer :: dimid_strlen, n_strlen
        character(len=1), allocatable :: tchar(:,:)
        character(len=512) :: tmp
        integer :: it, j

        status = nf90_open(trim(ncfile), nf90_nowrite, ncid)
        call chk(status, "open")
        
        ! grab the dims
        status = nf90_inq_dimid(ncid, "time", dimid_time)
        if (status /= nf90_noerr) then
            status = nf90_inq_dimid(ncid, "Time", dimid_time)
            call chk(status, "inq_dimid(time/Time)")
        end if
        status = nf90_inq_dimlen(ncid, dimid_time, n_time)
        call chk(status, "dimlen(time)")

        status = nf90_inq_dimid(ncid, "lat", dimid_lat); call chk(status, "inq_dimid(lat)")
        status = nf90_inq_dimlen(ncid, dimid_lat, n_lat); call chk(status, "dimlen(lat)")

        status = nf90_inq_dimid(ncid, "lon", dimid_lon); call chk(status, "inq_dimid(lon)")
        status = nf90_inq_dimlen(ncid, dimid_lon, n_lon); call chk(status, "dimlen(lon)")

        nt = n_time; nlat = n_lat; nlon = n_lon

        allocate(lat(nlat), lon(nlon))

        ! Get the lat and lon var id
        status = nf90_inq_varid(ncid, "lat", varid); call chk(status, "varid(lat)")
        status = nf90_get_var(ncid, varid, lat); call chk(status, "get(lat)")

        status = nf90_inq_varid(ncid, "lon", varid); call chk(status, "varid(lon)")
        status = nf90_get_var(ncid, varid, lon); call chk(status, "get(lon)")

        ! Get the time strings 
        ! WRF has a DateStrLen=19, the dim is Times
        ! The var is char Times(Time=no time steps, DateStrLen=19)

