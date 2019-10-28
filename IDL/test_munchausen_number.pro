
FUNCTION raised_to, x
    IF x eq 0 THEN RETURN,0 ELSE RETURN, LONG64(x^x)
END

FUNCTION sum_digit_power, i
    A = STRTRIM(STRING(i),1)
    my_sum = LONG64(0)
    FOR k=0, A.STRLEN()-1 DO BEGIN
        my_sum = my_sum + raised_to(FIX(A.CharAt(k)))
        ;PRINT, k, my_sum
    ENDFOR
    RETURN, my_sum
END

PRO test_munchausen_number

    time0 = SYSTIME(/SECONDS)
    num = 0
    i = LONG64(0)
    WHILE (num LE 4) DO BEGIN
        IF (i EQ sum_digit_power(i)) THEN BEGIN
            num++
            PRINT, 'The Munchausen number', num, ' is: ', i
        ENDIF

        ;IF ((i MOD 1000000LL) EQ 0) THEN print, 'Number: ', i
        i++
    ENDWHILE
    time1 = SYSTIME(/SECONDS) - time0
    PRINT, 'Time for Munchausen numbers: ', time1

    RETURN
END
