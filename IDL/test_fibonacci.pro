
FUNCTION recursive_fibonacci,n
    IF n lt 3 THEN RETURN,1L ELSE RETURN, recursive_fibonacci(n-1)+recursive_fibonacci(n-2)
END

FUNCTION iterative_fibonacci,n
    psum = (csum = 1uL)
    IF n lt 3 THEN RETURN,csum
    FOR i = 3,n DO BEGIN
        nsum = psum + csum
        psum = csum
        csum = nsum
    ENDFOR
    RETURN,nsum
END

PRO test_fibonacci, n

    time0 = SYSTIME(/SECONDS)
    n1 = iterative_fibonacci(n)
    time1 = SYSTIME(/SECONDS) - time0
    PRINT, 'Iterative Fibonacci (',n,'): ', time1, n1

    time0 = SYSTIME(/SECONDS)
    n2 = recursive_fibonacci(n)
    time1 = SYSTIME(/SECONDS) - time0
    PRINT, 'Recursive Fibonacci (',n,'): ', time1, n2

    RETURN
END
