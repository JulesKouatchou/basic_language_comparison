! *************************************************************
! http://www.rosettacode.org/wiki/Pernicious_numbers
!
! *************************************************************
program pernicious_numbers
      implicit none
 
      integer, parameter :: dp=kind(0.d0)

      integer            :: i, n
      integer            :: max_number
      real(dp)           :: r, start1, start2, finish1, finish2
      character(len=30)  :: arg(1)

      ! Get the dimension from the command line
      call getarg(1, arg(1))
      read(arg(1), *) max_number
 
      call cpu_time(start1)
      i = 1
      n = 0
      do
        if (is_prime_number(get_number_of_ones(i))) then
           !if ((n == 0) .OR. (n == max_number-1)) write(*, "(i0, 1x)", advance = "no") i
           n = n + 1
           if (n == max_number) exit
        end if
        i = i + 1
      end do
      call cpu_time(finish1)
      print "('Pernicious number:', 2x,i10, 2x, f15.10,'s')", i, finish1 - start1
 
!-----------------------------------------------------------------
contains
!-----------------------------------------------------------------
 
    function get_number_of_ones(x) result(number_of_ones)
      integer :: number_of_ones
      integer, intent(in) :: x
      integer :: i
     
      number_of_ones = 0
      !do i = 0, 31
      do i = 0, BIT_SIZE(x)-1
        if (BTEST(x, i)) number_of_ones = number_of_ones + 1
      end do
     
    end function get_number_of_ones
 
    function is_prime_number(number) result(iamprime)
      integer, intent(in) :: number
      logical :: iamprime
      integer :: i
     
      if(number == 2) then
        iamprime = .true.
      else if(number < 2 .or. mod(number,2) == 0) then
        iamprime = .false.
      else
        iamprime = .true.
        do i = 3, int(sqrt(real(number))), 2
          if(mod(number,i) == 0) then
            iamprime = .false.
            exit
          end if
        end do
      end if
    end function is_prime_number
end program pernicious_numbers
