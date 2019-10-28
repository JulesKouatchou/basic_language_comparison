;
; .run beliefPropagation
; beliefPropagation, nx
;
PRO test_belief_propagation, N

    PRINT, '----------------------------'
    PRINT, 'Belief calculations: ', N
    PRINT, '----------------------------'
    PRINT, ' '

    time0 = SYSTIME(/SECONDS)

    random_value = RANDOMN(Seed)

    dim = 5000

    A = RANDOMN(Seed, dim,dim)
    x = FLTARR(dim)

    x[0:dim-1] = 1.0

    FOR i = 1,N DO BEGIN
        x = ALOG10(A#EXP(x))
        x -= ALOG10(TOTAL(EXP(x)))  
    ENDFOR

    time1 = SYSTIME(/SECONDS) - time0
    PRINT, 'Elapsed time: ', time1

    RETURN
END
