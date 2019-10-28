    program test_gauss_legendre_quadrature

    implicit none
    integer, parameter :: qp = 16 ! quadruple precision

    integer                    :: n, k, m
    !integer                   :: n = 10, k
    real(kind=qp), allocatable :: r(:,:)
    real(kind=qp)              :: z, exact
    real(kind=qp)              :: a_min, a_max

    real start, finish
    CHARACTER(len=50)          :: arg(1)

    ! Get the dimension from the command line
    call getarg(1, arg(1))
    read(arg(1), *) m

    a_min = -3
    a_max =  3
    exact = exp(3.0_qp)-exp(-3.0_qp)

    call cpu_time(start)
    r = gauss_quadrature(m)
    z = gauss_integral(r, a_min, a_max, m)
    call cpu_time(finish)
    print "('Gauss-Legendre Quadrature (',i4,'):', 2x, f15.10,'s')", m, finish - start

!------------------------------------------------------------------------------
    contains 
!------------------------------------------------------------------------------

        function gauss_quadrature(n) result(r)
            integer                     :: n
            real(kind=qp), parameter    :: pi = 4*atan(1._qp)
            real(kind=qp)               :: r(2, n), x, f, df, dx
            integer                     :: i,  iter
            real(kind =qp), allocatable :: p0(:), p1(:), tmp(:)

            p0 = [1._qp]
            p1 = [1._qp, 0._qp]

            do k = 2, n
               tmp = ((2*k-1)*[p1, 0._qp]-(k-1)*[0._qp, 0._qp, p0])/k
               p0 = p1
               p1 = tmp
            end do
            do i = 1, n
               x = cos(pi*(i-0.25_qp)/(n+0.5_qp))
               do iter = 1, 10
                  f = p1(1)
                  df = 0._qp
                  do k = 2, size(p1)
                     df = f + x*df
                     f  = p1(k) + x * f
                  end do
                  dx =  f / df
                  x = x - dx
                  if (abs(dx)<10*epsilon(dx)) exit
               end do
               r(1, i) = x
               r(2, i) = 2/((1-x**2)*df**2)
            end do
        end function gauss_quadrature

        function gauss_integral(coef, a, b, n) result(approx_integral)
            integer           :: n
            real(kind=qp)     :: coef(2, n)
            real(kind=qp)     :: a, b
            real(kind=qp)     :: approx_integral
            approx_integral = (b-a)/2*dot_product(coef(2, :), exp((a+b)/2+coef(1, :)*(b-a)/2))
        end function gauss_integral

    end program test_gauss_legendre_quadrature
