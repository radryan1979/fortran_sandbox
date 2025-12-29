program tsunami

    implicit none ! explicit typing enforced

    integer :: i, n
    integer, parameter :: grid_size = 100 ! the parameter means it can't be changed
    integer, parameter :: num_time_steps = 100! but also needs to have value set when declaring

    real, parameter :: dt = 1. ! time step [s]
    real, parameter :: dx = 1. ! grid spacing [m]
    real, parameter :: c = 1. ! phase or background flow speed

    ! declaring 1D arrays for height and change in height
    real :: h(grid_size), dh(grid_size) 

    integer, parameter :: icenter = 25
    real, parameter :: decay = 0.25

    ! Check that the parameters are set
    if (grid_size <= 0) stop 'grid size must be > 0'

    ! Initialize the array with values
    do concurrent(i = 1:grid_size)
        h(i) = exp(-decay * (i-icenter)**2)
    end do

    print *, 0, h ! print out the initial water height values

    ! apply the periodic boundary condition
    time_loop: do n = 1, num_time_steps
        dh(1) = h(1) - h(grid_size)

        do concurrent (i=2:grid_size)
            dh(i) = h(i) - h(i-1)
        end do

        ! integrate the system forward
        do concurrent (i=1:grid_size)
            h(i) = h(i) - c * dh(i) / dx * dt 
        end do

        print *, n, h
    end do time_loop

end program tsunami
