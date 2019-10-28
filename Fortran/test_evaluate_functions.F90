    program test_evaluate_functions

    !use timer_module
    implicit none
    integer, parameter :: dp=kind(0.d0)


    integer, parameter    :: num_iterations = 10000
    integer               :: n, i
    real(dp)              :: start, finish, tarray(2)
    real(dp)              :: a_min = -1500.00
    real(dp)              :: a_max =  1500.00
    real(dp)              :: h
    
    real(dp), allocatable :: vect1(:)
    real(dp), allocatable :: vect2(:)
    character(len=30)     :: arg(1)
    !type(Timer)          :: elpTime

    ! Get the dimension from the command line
    call getarg(1, arg(1))
    read(arg(1), *) n

    call srand(86456)
    call cpu_time(start)
    !call elpTime%startTimer()

    allocate(vect1(n))
    allocate(vect2(n))
    h = (a_max - a_min)/(n-1)

    do i = 1, n
       vect1(i) = a_min + (i-1)*h
    end do

    do i = 1, num_iterations
       vect2(:) = DSIN(vect1(:))
       vect1(:) = DASIN(vect2(:))
       vect2(:) = DCOS(vect1(:))
       vect1(:) = DACOS(vect2(:))
       vect2(:) = DTAN(vect1(:))
       vect1(:) = DATAN(vect2(:))
    end do

    call cpu_time(finish)
    !call elpTime%stopTimer('Time Matrix Copy - ji loop: ')
    print "('Time Evaluate Function:', 2x,i7, 2x, f15.10,'s')", n, finish - start

    end program test_evaluate_functions
