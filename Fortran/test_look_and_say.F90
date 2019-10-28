    program test_look_and_say

    implicit none
    integer, parameter :: dp=kind(0.d0)
    integer, parameter :: stringlen=700

    integer :: i, N
    character(len=stringlen) :: t, r
    real(dp) start, finish
    character(len=50) :: arg(1)


    ! Get the dimension from the command line
    call getarg(1, arg(1))
    read(arg(1), *) N

    call cpu_time(start)

    call look_and_say("1223334444", r, N)

    call cpu_time(finish)

    print "('Time for Look and Say (',i4,'):', 2x, f15.10,'s')", N, finish - start

!------------------------------------------------------------------------------
    contains
!------------------------------------------------------------------------------
        subroutine look_and_say(startseq, lastseq, n)
        integer, intent(in) :: n                   ! number of iterations
        character(len=*), intent(in) :: startseq   ! starting sequence
        character(len=*), intent(out) :: lastseq   ! ending   sequence

        integer :: i, c, iter, it
        character(len=1) :: x
        character(len=2) :: d
        character(len=stringlen) :: currentseq

        currentseq = startseq
        if (n < 2) then
            lastseq = startseq
        else
            do it = 2, n
                lastseq = ""
                c = 1
                x = currentseq(1:1)
                do i = 2, len(trim(currentseq))
                    if ( x == currentseq(i:i) ) then
                        c = c + 1
                    else
                        write(d, "(I2)") c
                        lastseq = trim(lastseq) // trim(adjustl(d)) // trim(x)
                        c = 1
                        x = currentseq(i:i)
                    end if
                end do
                write(d, "(I2)") c
                lastseq = trim(lastseq) // trim(adjustl(d)) // trim(x)
                currentseq = lastseq
            end do
        end if
        end subroutine look_and_say

    end program test_look_and_say
