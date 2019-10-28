program munchausen_number

      integer :: i, n
      real    :: start1, finish1
      integer :: power_of_digits(0:9)

      call cpu_time(start1)

      do i = 0, 9
         power_of_digits(i) = raisedto(i)
      end do

      i = 0
      n = 0
     
      DO WHILE (n < 4)
         IF (is_munchausen_number(i)) THEN
            n = n + 1
            PRINT "('Munchausen Number', 1x, I2, ':', 2x, I10)", n,i
          ENDIF
          i = i + 1
      ENDDO

      call cpu_time(finish1)
      print "('Time for Munchausen Numbers:', 2x, f15.10,'s')", finish1 - start1

contains

   
  FUNCTION is_munchausen_number(num) result(answer)
    INTEGER, INTENT(in) :: num
    LOGICAL             :: answer

    INTEGER, DIMENSION(:), ALLOCATABLE :: digs
    INTEGER :: num_digits, ix, rem
    INTEGER :: sum

    IF (num == 0) THEN
       num_digits = 1
    ELSE
       num_digits = FLOOR(LOG10(REAL(num))+1)
    ENDIF
    ALLOCATE(digs(num_digits))

    sum = 0
    rem = num
    DO ix = 1, num_digits
       digs(ix) = rem - (rem/10)*10  ! Take advantage of integer division
       rem = rem/10
       sum = sum +  power_of_digits(digs(ix))
       !sum = sum + raisedto(digs(ix))
    END DO

    DEALLOCATE(digs)

    answer = .FALSE.
    IF (sum .EQ. num) answer = .TRUE.

  END FUNCTION is_munchausen_number

  FUNCTION raisedto(n) result(answer)
     INTEGER, INTENT(in) :: n
     INTEGER             :: answer
     answer = 0
     if (n > 0) answer = n**n
  END FUNCTION raisedto

end program munchausen_number
