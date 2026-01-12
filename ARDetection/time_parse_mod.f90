! parses a time string into month
! takes in YYYY-MM-DD_HH:MM:SS or
! YYYY-MMDDTHH:MM:SS

module time_parse_mod
    implicit none
    private
    public :: month_from_string

contains

    integer function month_from_string(tstr) result(mo)
        character(len=*), intent(in) :: tstr
        character(len=2) :: mm

        ! Assuming YYYY-MM- so month at positions 6-7
        if (len_trim(tstr) < 7) then
            mo = -1
            return
        end if

        mm = tstr(6:7)
        read(mm, '(I2)', err=10) mo
        return
        10 mo = -1
    end function month_from_string
end module time_parse_mod