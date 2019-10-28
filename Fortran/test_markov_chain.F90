    program test_markov_chain

    implicit none
    integer, parameter :: dp=kind(0.d0)

    real(dp) :: r, start, finish, mysum, mynorm
    integer :: N, i, j, k
    real(dp) :: x(2)
    character(len=50) :: arg(1)

    ! Get the dimension from the command line
    call getarg(1, arg(1))
    read(arg(1), *) N

    call cpu_time(start)

    ! Perform the Markov Chain calculations
    !--------------------------------------
    x(:) = 0.0

    call do_metropolis(x, N)

    call cpu_time(finish)

    print "('Markov Chain Calculations (',i6,'):', 2x, f15.10,'s')", N, finish - start

!------------------------------------------------------------------------------
    contains
!------------------------------------------------------------------------------
        subroutine do_metropolis(x, N)
        implicit none
        real(dp), intent(inout) :: x(2)
        integer, intent(in) :: N
        integer :: i
        real(dp) :: p, p2, r
        real(dp) :: x2(2)

        call srand(86456)
        p = ff(x)
        do i = 1, N
            call random_number(r)
            x2(1) = x(1) + 0.01*random_normal()
            call random_number(r)
            x2(2) = x(2) + 0.01*random_normal()

            p2 = ff(x2)
            call random_number(r)
            if (r .LT. (p2/p)) THEN
                x(:) = x2(:)
                p    = p2
            end if
        end do
        return
        end subroutine do_metropolis

        real(dp) function ff(x)
            implicit none
            real(dp) :: x(2)
            ff = exp(sin(5.0*x(1)) - x(1)*x(1) - x(2)*x(2))
        end function ff

        function random_normal() result(fn_val)

        ! Adapted from the following Fortran 77 code
        !      ALGORITHM 712, COLLECTED ALGORITHMS FROM ACM.
        !      THIS WORK PUBLISHED IN TRANSACTIONS ON MATHEMATICAL SOFTWARE,
        !      VOL. 18, NO. 4, DECEMBER, 1992, PP. 434-435.

        !  The function random_normal() returns a normally distributed pseudo-random
        !  number with zero mean and unit variance.

        !  The algorithm uses the ratio of uniforms method of A.J. Kinderman
        !  and J.F. Monahan augmented with quadratic bounding curves.

        real(dp) :: fn_val

        !     Local variables
        real(dp) :: s  = 0.449871,  t = -0.386595, a = 0.19600, b = 0.25472
        real(dp) :: r1 = 0.27597,  r2 = 0.2784, half = 0.5
        real(dp) :: u, v, x, y, q

        ! Generate P = (u,v) uniform in rectangle enclosing acceptance region

        do
            call random_number(u)
            call random_number(v)
            v = 1.7156 * (v - half)

            ! Evaluate the quadratic form
            x = u - s
            y = abs(v) - t
            q = x**2 + y*(a*y - b*x)

            ! Accept P if inside inner ellipse
            if (q < r1) exit
            ! Reject P if outside outer ellipse
            if (q > r2) cycle
            ! Reject P if outside acceptance region
            if (v**2 < -4.0*LOG(u)*u**2) exit
        end do

        !     Return ratio of P's coordinates as the normal deviate
        fn_val = v/u
        return

        end function random_normal

    end program test_markov_chain
