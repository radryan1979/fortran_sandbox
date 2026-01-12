

program hello

    use math_utils
    implicit none

    integer :: i = 0
    real :: x,y
    real :: z(5)

    z(1) = 5.0
    z(2) = 3.0
    z(3) = 2.5
    z(4) = 6.5
    z(5) = 2.25

    ! This is a comment
    print *, 'Hello, World!'
    print *, 'Hello, Universe!'

    ! Calls sumit from the module math_utils
    print *, 'The sum is:', sumit(z)

#ifdef CALC
    print *, 'Enter the first number:'
    read(*,*) x

    print *, 'Enter the second number:'
    read(*,*) y

    print *, 'The product is: ', a_product(x,y)
#endif

contains

    ! Function Example
    function a_product(n,m) result(q)
        implicit none
        real, intent(in) :: n,m
        real :: q
        q = n*m
    end function a_product

end program hello
