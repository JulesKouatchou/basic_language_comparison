    program test_belief_propagation

    implicit none

    integer, parameter:: dp=kind(0.d0)
    
    real(dp)              :: r, start, finish, mysum, mynorm
    integer               :: N, i, j, k
    integer, parameter    :: dim = 5000
    real(dp), allocatable :: A(:,:)
    real(dp), allocatable :: x(:), x2(:)
    character(len=50)     :: arg(1)

    ! Get the dimension from the command line
    call getarg(1, arg(1))
    read(arg(1), *) N

    call cpu_time(start)

    ! Allocate and initialize the matrices
    !-------------------------------------
    allocate(A(dim, dim))
    allocate(x(dim))

    call srand(86456)
    do i = 1, dim
       x(i) = 1.0
       do j = 1, dim
          call random_number(r)
          A(i, j) = r
       end do
    end do

    ! Perform the belief calculations
    !--------------------------------
    do k = 1, N
       x2     = matmul(A,x)
       x(:)   = log(x2(:))
       mysum  = sum(exp(x(:)))
       mynorm = log(mysum)
       x(:)   = x(:) - mynorm
    end do

    call cpu_time(finish)

    print "('Time for Belief Calculations (',i4,'):', 2x, f15.10,'s')", N, finish - start

    end program test_belief_propagation
