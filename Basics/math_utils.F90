module math_utils

    !use iso_fortran_env, only: int32, real32
    implicit none

contains

    function sumit(x) result(s)
        real, intent(in) :: x(:)
        real :: s
        real :: running_total = 0.
        integer :: i

        do i = 1, size(x)
            running_total = running_total + x(i)
        end do

        s = running_total

    end function sumit

end module math_utils