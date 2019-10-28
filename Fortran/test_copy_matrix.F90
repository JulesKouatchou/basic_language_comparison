! **********************************************************
! Given a nxnx3 matrix A, we want to perform the operations:
!
!       A[i][j][0] = A[i][j][1]
!       A[i][j][2] = A[i][j][0]
!       A[i][j][1] = A[i][j][2]
! **********************************************************

    program test_copy_matrix

    !use timer_module
    implicit none
    integer, parameter :: dp=kind(0.d0)


    integer dim1, i, j, l
    !real(dp)             :: start, finish, tarray(2)
    real(dp)              :: r, start1, start2, finish1, finish2
    real(dp), allocatable :: A(:, :, :)
    character(len=30)     :: arg(1)
    !type(Timer)          :: elpTime


    ! Get the dimension from the command line
    call getarg(1, arg(1))
    read(arg(1), *) dim1

    allocate(A(dim1, dim1, 3))

    ! Loop formulation
    !-----------------

    call srand(86456)
    do i = 1, dim1
        do j = 1, dim1
            do l = 1, 3
                call random_number(r)
                A(i, j, l) = r
            end do
        end do
    end do

    call cpu_time(start1)
    !call elpTime%startTimer()

    do j = 1, dim1
        do i = 1, dim1
            A(i, j, 1) = A(i, j, 2)
            A(i, j, 3) = A(i, j, 1)
            A(i, j, 2) = A(i, j, 3)
        end do
    end do

    call cpu_time(finish1)
    !call elpTime%stopTimer('Time Matrix Copy - ji loop: ')
    print "('Time Matrix Copy - ji loop:', 2x,i5, 2x, f15.10,'s')", dim1, finish1 - start1

    ! Vectorization formulation
    !--------------------------
    call srand(86456)
    do i = 1, dim1
        do j = 1, dim1
            do l = 1, 3
                call random_number(r)
                A(i, j, l) = r
            end do
        end do
    end do

    call cpu_time(start2)

    A(:, :, 1) = A(:, :, 2)
    A(:, :, 3) = A(:, :, 1)
    A(:, :, 2) = A(:, :, 3)

    call cpu_time(finish2)
    print "('Time Matrix Copy - vectorization:', 2x,i5, 2x, f15.10,'s')", dim1, finish2 - start2

    end program test_copy_matrix
