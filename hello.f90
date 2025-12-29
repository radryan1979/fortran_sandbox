

program hello
    implicit none

    real :: x,y

    ! This is a comment
    print *, 'Hello, World!'
    print *, 'Hello, Universe!'

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
