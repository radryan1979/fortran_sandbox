! helper for percentile calculations

module perfentile_mod
    implicit none
    private
    public :: percentile_q

contains

    real function percentile_q(x, n, q) result(val)
        ! q in [0,1] percentile from array x(1:n)
        real, intent(in) :: x(n)
        integer, intent(in) :: n
        real, intent(in) :: q
        real, allocatable :: tmp(:)
        integer :: k

        if (n <= 0) then
            val = 0.0
            return
        end if

        allocate(tmp(n))
        tmp = x
        call quicksort(tmp, 1, n)

        k = int(ceiling(q*real(n)))
        if (k < 1) k = 1
        if (k > n) k = n
        val = tmp(k)

        deallocate(tmp)
    end function percentile_q

    recursive subroutine quicksort(a, lo, hi)
        real, intent(inout) :: a(:)
        integer, intent(in) :: lo, hi
        integer :: p
        if (lo < hi) then
            call partition(a, lo, hi, p)
            call quicksort(a, lo, p-1)
            call quicksort(a, p+1, hi)
        end if
    end subroutine quicksort

    subroutine partition(a, lo, hi, p)
        real, intent(inout) :: a(:)
        integer, intent(in) :: lo, hi
        integer, intent(out) :: p
        real :: pivot, tmp
        integer :: i,j

        pivot = a(hi)
        i = lo
        do j = lo, hi-1
            if (a(j) <= pivot) then
                tmp = a(i)
                a(i) = a(j)
                a(j) = tmp
                i = i + 1
            end if
        end do
        tmp = a(i)
        a(i) = a(hi)
        a(hi) = tmp
        p = i
    end subroutine partition
end module percentile_mod