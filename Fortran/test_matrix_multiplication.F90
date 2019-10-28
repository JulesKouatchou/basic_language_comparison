
    program test_matrix_multiplication

    implicit none
    integer, parameter :: dp=kind(0.d0)

    real(dp) :: r, start, finish
    integer :: dim1, dim2, dim3, i, j, k
    real(dp), allocatable :: A(:, :)
    real(dp), allocatable :: B(:, :)
    real(dp), allocatable :: C(:, :)

    integer, parameter :: n = 3
    character(len=50) :: arg(n)

    ! Get the dimension from the command line
    do i =1, n
        call getarg(i,arg(i))
    end do
    read(arg(1), *) dim1
    read(arg(2), *) dim2
    read(arg(3), *) dim3

    write(*, 110) 'Perform matrix multiplication:', &
                  ' C(', dim1, ',', dim3, ') = A(', dim1, ',', dim2, ') x B(', dim2, ',', dim3, ')'
110 format(a30, a3, i4, a1, i4, a6, i4, a1, i4, a6, i4, a1, i4, a1)

    ! Allocate the three matrices
    allocate(A(dim1, dim2))
    allocate(B(dim2, dim3))
    allocate(C(dim1, dim3))

    ! Initialize the matrices A & B
    call srand(86456)
    do i = 1, dim1
        do j = 1, dim2
            call random_number(r)
            A(i, j) = r
        end do
    end do
    do i = 1, dim2
        do j = 1, dim3
            call random_number(r)
            B(i, j) = r
        end do
    end do

    ! Perform the matrix multiplication using loops
    call cpu_time(start)
    do j = 1, dim3
        do i = 1, dim1
            C(i, j) = 0.
            do k = 1, dim2
                C(i, j) = C(i, j) + A(i, k)*B(k, j)
            end do
        end do
    end do
    call cpu_time(finish)
    write(*, 100)'   --->  Loops: ', finish - start, ' s'

    ! Perform the matrix multiplication the intrinsic
    ! function matmul
    call cpu_time(start)
    C = matmul(A, B)
    call cpu_time(finish)

    write(*, 100) '   --->  Function matmul: ', finish - start, ' s'     
100 format(a26, f10.4, a2)

    end program test_matrix_multiplication
