program ompsum
    use OMP_LIB

    integer :: partial_Sum, total_Sum

    ! partial sum is private, copied to each thread
    ! total sum is public and shared
    !$OMP PARALLEL PRIVATE(partial_Sum) SHARED(total_Sum)

    partial_Sum = 0;
    total_Sum = 0;

    ! kick off the loop that can be paralelleized
    !$OMP DO
    do i=1, 1000
        partial_Sum = partial_Sum + i
    end do
    !$OMP END DO

    ! critical tells us to wait for the threads
    ! to finish, then we sum all the partial sums
    !$OMP CRITICAL
    total_Sum = total_Sum + partial_Sum
    !$OMP END CRITICAL

    !$OMP END PARALLEL

    print *, 'Total Sum:', total_Sum

end program ompsum