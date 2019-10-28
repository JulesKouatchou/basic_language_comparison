;----------------------------------------------------------------------
;----------------------------------------------------------------------

FUNCTION FUNCTION_ARG, x, M, func

    FOR i = 1, M DO BEGIN
        t = CALL_FUNCTION(func, x)
    ENDFOR

    RETURN, t
END

; Main program
PRO test_evaluate_functions, n
    PRINT, "------------------------------------------------"
    PRINT, "Compute values: ", n
    PRINT, "------------------------------------------------"

    time0 = SYSTIME(/SECONDS)
    M = 10000
    a = -1500.00
    b =  1500.00
    h = (b-a)/(n-1)
    x = INDGEN(n)*h + a

    FOR i = 1, M DO BEGIN
        y =  SIN(x)
        x = ASIN(y)
        y =  COS(x)
        x = ACOS(y)
        y =  TAN(x)
        x = ATAN(y)
    ENDFOR

    time1 = SYSTIME(/SECONDS) - time0

    PRINT, '       Elapsed time: ', time1
    PRINT, " "

    RETURN
END
