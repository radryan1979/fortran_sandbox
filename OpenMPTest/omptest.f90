! This is example code taken from here:
! https://research-computing-user-tutorials.readthedocs.io/en/stable/programming/OpenMP-Fortran.html

program Parallel_Hello_World
    use OMP_LIB

    ! make sure you export OMP_NUM_THREADS=4
    ! so that OpenMP knows how many
    ! threads it can use

    ! use private or public omp variable delarations
    ! private gets copied to memory for each process
    ! public is shared across processes

    integer :: thread_id

!$OMP PARALLEL PRIVATE(thread_id)
    thread_id = OMP_GET_THREAD_NUM()
    print *, 'Hello from process: ', thread_id
!$OMP END PARALLEL
end program