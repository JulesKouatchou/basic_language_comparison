    program test_fibonacci

    implicit none

    integer, parameter :: dp=kind(0.d0)

    real(dp)          :: start, finish
    integer m, n1, n2
    character(len=50) :: arg(1)

    ! Get the dimension from the command line
    call getarg(1,arg(1))
    read(arg(1), * ) m

    ! Calculation with loop
    !----------------------
    call cpu_time(start)
    n2 = fibonacci_iterative(m)
    call cpu_time(finish)
    print "('Iterative Fibonacci (',i2,'):', 2x, f15.10,'s')", m, finish - start

    ! Calculation with recursive function
    !------------------------------------
    call cpu_time(start)
    n1 = fibonacci_recursive(m)
    call cpu_time(finish)
    print "('Recursive Fibonacci (',i2,'):', 2x, f15.10,'s')", m, finish - start

!------------------------------------------------------------------------------
    contains
!------------------------------------------------------------------------------
        recursive function fibonacci_recursive(n) result(fib)
            integer, intent(in) :: n
            integer :: fib

            select case (n)
                case (:0);      fib = 0
                case (1);       fib = 1
                case default;   fib = fibonacci_recursive(n-1) + fibonacci_recursive(n-2)
            end select
        end function fibonacci_recursive

        function fibonacci_iterative(n) result(fib)
            integer, intent(in) :: n
            integer, parameter  :: fib0 = 0, fib1 = 1
            integer             :: fib, back1, back2, i
          
            select case (n)
                case (:0);      fib = fib0
                case (1);       fib = fib1
                case default
                    fib = fib1
                    back1 = fib0
                    do i = 2, n
                        back2 = back1
                        back1 = fib
                        fib   = back1 + back2
                    end do
            end select
        end function fibonacci_iterative

    end program test_fibonacci
