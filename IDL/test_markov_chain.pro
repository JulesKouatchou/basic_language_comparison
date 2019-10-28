
PRO test_markov_chain, N

    PRINT, '----------------------------'
    PRINT, 'Markov Chain calculations: ', N
    PRINT, '----------------------------'
    PRINT, ' '

    time0 = SYSTIME(/SECONDS)

    random_value_N = RANDOMN(seedN)
    random_value_U = RANDOMN(seedU)

    x = FLTARR(2)
    x2= FLTARR(2)

    x[0:1] = 0.0

    p = EXP(SIN(5.0*x[0]) - x[0]*x[0] - x[1]*x[1])
    ;p = FF(x)

    FOR i = 1,N DO BEGIN
        x2 = x + 0.01*RANDOMN(seedN, 2)
        p2 = EXP(SIN(5.0*x2[0]) - x2[0]*x2[0] - x2[1]*x2[1])
        ;p2 = FF(x2)
        IF (RANDOMU(seedU, 1) < (p2/p)) THEN BEGIN
           x = x2
           p = p2
        ENDIF
    ENDFOR

    time1 = SYSTIME(/SECONDS) - time0
    PRINT, 'Elapsed time: ', time1

    RETURN
END
