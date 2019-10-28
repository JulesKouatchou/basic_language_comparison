! **********************************************************
! Given two nxn matrices A and B, we perform:
!       C = A x B
! **********************************************************

    program test_matrix_multiplication_DGEMM

    implicit none
    integer, parameter :: dp=kind(0.d0)

    integer iseed /3/
    real(dp) start, finish, r, alpha, beta
    integer :: n, i, j, lda, ldb, ldc
    real(dp), allocatable :: A(:, :), B(:, :), C(:, :)

    character(len=30) :: arg(1)

    ! Get the dimension from the command line
    call getarg(1, arg(1))
    read(arg(1), *) n

    write(*, 110) 'Perform matrix multiplication:', &
                 ' C(', n, ',', n, ') = A(', n, ',', n, ') x B(', n, ',', n, ')'
110 format(a30, a3, i4, a1, i4, a6, i4, a1, i4, a6, i4, a1, i4, a1)

    alpha = 1.0
    beta  = 0.0
    lda = n
    ldb = n
    ldc = n

    ! Allocate and initialize the matrices
    allocate(A(n, n))
    allocate(B(n, n))
    allocate(C(n, n))

    call srand(86456)
    do i = 1, n
        do j = 1, n
            call random_number(r)
            A(i, j) = r
            call random_number(r)
            B(i, j) = r
         end do
    end do

    ! Perform the matrix multiplication
    C = 0.0
    call cpu_time(start)

    call dgemm("N", "N", n, n, n, alpha, A, lda, B, ldb, beta, C, ldc)

    call cpu_time(finish)

    write(*, 100) '   --->  Function DGEMM: ', finish - start, ' s'     
100 format(a26, f10.4, a2)

    end program test_matrix_multiplication_DGEMM


