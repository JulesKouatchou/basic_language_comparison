    program test_munchausen_number

    implicit none
    integer, parameter :: dp=kind(0.d0)

    integer  :: i, n
    real(dp) :: start1, finish1
    integer  :: power_of_digits(0:9)

    call cpu_time(start1)

    do i = 0, 9
        power_of_digits(i) = raisedto(i)
    end do

    i = 0
    n = 0

    do while (n < 4)
        if (is_munchausen_number(i)) then
            n = n + 1
            print "('Munchausen Number', 1x, I2, ':', 2x, I10)", n,i
        end if
        i = i + 1
    end do

    call cpu_time(finish1)
    print "('Time for Munchausen Numbers:', 2x, f15.10,'s')", finish1 - start1

!------------------------------------------------------------------------------
    contains
!------------------------------------------------------------------------------
        function is_munchausen_number(num) result(answer)
        integer, intent(in)                :: num
        logical                            :: answer

        integer, dimension(:), allocatable :: digs
        integer                            :: num_digits, ix, rem
        integer                            :: sum

        if (num == 0) then
            num_digits = 1
        else
            num_digits = floor(LOG10(real(num))+1)
        end if
        allocate(digs(num_digits))

        sum = 0
        rem = num
        do ix = 1, num_digits
            digs(ix) = rem - (rem/10)*10  ! Take advantage of integer division
            rem = rem/10
            sum = sum +  power_of_digits(digs(ix))
            !sum = sum + raisedto(digs(ix))
        end do

        deallocate(digs)

        answer = .FALSE.
        if (sum .EQ. num) answer = .TRUE.
        end function

        function raisedto(n) result(answer)
        integer, intent(in) :: n
        integer             :: answer
        answer = 0
        if (n > 0) answer = n**n
        end function raisedto

    end program test_munchausen_number
