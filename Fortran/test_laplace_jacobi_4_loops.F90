!----------------------------------------------------------------------
! Numerical solution of the 2D Laplce equation:
!
!    u   + u   = 0
!     xx    yy
!----------------------------------------------------------------------
    program test_laplace_jacobi_4_loops

    implicit none
    integer, parameter    :: dp=kind(0.d0)


    real(dp), parameter   :: eps=1.0d-6
    integer, parameter    :: max_sweep=1000000
    integer               :: n
    real(dp), allocatable :: u(:, :)
    real(dp), allocatable :: v(:, :)
    real(dp), allocatable :: x(:)

    real(dp)              :: error, tmp, diff, start, finish
    real(dp), parameter   :: pi=3.141592653589793
    integer               :: count, i, j

    character(len=30)     :: arg(1)

    call cpu_time(start)
    ! Get the dimension from the command line
    call getarg(1, arg(1))
    read(arg(1), *) n

    !-------------------------------------------
    ! Variable allocation and initial conditions
    !-------------------------------------------
    allocate(u(n, n))
    allocate(v(n, n))
    allocate(x(n))

    do i = 1, n
     x(:) = 1.0*(i-1)/n
    end do

    u(:, :) = 0.0
    u(:, 1) = sin(pi*x(:))
    u(:, n) = sin(pi*x(:))*exp(-pi)

    error = 2
    count = 0

    ! Jacobi iterations

    do while ( (count < max_sweep) .and. (error > eps))
        count = count + 1
        error = 0
        do j=2, n-1
            do i=2, n-1
                tmp = u(i, j)
                u(i, j) = (4.0*(u(i-1, j) + u(i+1, j) + u(i, j-1) + u(i, j+1)) + &
                    u(i-1, j-1) + u(i+1, j+1) + u(i+1, j-1) + u(i-1, j+1))/20.0
                diff = u(i, j) - tmp
                error = error + diff*diff
            end do
        end do
        error = sqrt(error)
    end do

    call cpu_time(finish)

    print*, "Fortran Solution of Laplace Equation: (loops)", n
    print*, "    Number of iterations: ", count
    print*, "    Error: ", error
    print '("     Time: ",f6.3," seconds.")', finish-start

!------------------------------------------------------------------------------
    contains
!------------------------------------------------------------------------------

         function normError(w) result(norm2)
             real(dp) w(n, n)
             integer i, j
             real(dp) norm2, err
             err = 0.0d0
             do j=2, n-1
                do i=2, n-1
                   err = err + w(i, j)*w(i, j)
                end do
             end do

             norm2 = sqrt(err)
         end function normError

    end program test_laplace_jacobi_4_loops
