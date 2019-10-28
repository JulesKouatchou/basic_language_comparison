!------------------------------------------------------------------------------
!BOP
!
! !MODULE: timer_module
!
      module timer_module

      implicit none

      INTEGER, PARAMETER :: prec = 8

      TYPE Timer
         PRIVATE
         INTEGER :: clock_start
         INTEGER :: clock_rate = -1
      CONTAINS
         PROCEDURE, PUBLIC :: startTimer
         PROCEDURE, PUBLIC :: stopTimer
      END TYPE Timer
!
! !DESCRIPTION:
! Create a class Timer and the two methods startTimer and stopTimer
! to measure the elapsed time a computing unit. 
! Here is how this class can be used:
! \begin{verbatim}
!      use timer_module
!      ...
!      TYPE(Timer) :: elpTime
!      ...
!      call elpTime%startTimer()
!      ...doYourCalculations
!      call elpTime%stopTimer('My calculations took: ')
! \end{verbatim}
!
!EOP
!------------------------------------------------------------------------------
      CONTAINS
!------------------------------------------------------------------------------
!BOP
!
! !IROUTINE: startTimer
!
! !INTERFACE:
!
        subroutine startTimer(self)
!
! !INPUT/OUTPUT PARAMETERS:
           class(timer), intent(inOut) :: self
!
! !DESCRIPTION:
! Find the rate and obtain the start time.
!EOP
!------------------------------------------------------------------------------
!BOC
      CALL SYSTEM_CLOCK(COUNT_RATE=self%clock_rate) ! Find the rate
      CALL SYSTEM_CLOCK(COUNT=self%clock_start)     ! Start timing

      end subroutine startTimer
!EOC
!------------------------------------------------------------------------------
!BOP
!
! !IROUTINE: stopTimer
!
! !INTERFACE:
!
        subroutine stopTimer(self, msg)
!
! !INPUT/OUTPUT PARAMETERS:
           class(timer),               intent(inOut) :: self
!
! !INPUT PARAMETERS:
           character(len=*), optional, intent(in)    :: msg
!
! !LOCAL VARIABLES:
           integer                                   :: clock_end
           REAL(KIND=prec)                           :: elapsedTime
!
! !DESCRIPTION:
! Obtain the current time and compute the elapsed time.
!EOP
!------------------------------------------------------------------------------
!BOC
      ! Make sure that startTimer was computed before
      IF (self%clock_rate .LT. 0) THEN
         PRINT*, 'Call to ''stopTimer'' should come after call to ''startTimer'''
         STOP
      ENDIF

      CALL SYSTEM_CLOCK(COUNT=clock_end) ! Stop timing

      ! Calculate the elapsed time in seconds:
      elapsedTime = REAL(clock_end-self%clock_start, prec) / REAL(self%clock_rate, prec)
 
      IF (PRESENT(msg)) THEN
         write(*, '(a,f18.10,a)') TRIM(msg), elapsedTime, ' seconds'
      ELSE
         write(*, '(a,f18.10,a)') 'Ellapsed time: ', elapsedTime, ' seconds'
      ENDIF
      end subroutine stopTimer
!EOC
!------------------------------------------------------------------------------
        
      end module timer_module
