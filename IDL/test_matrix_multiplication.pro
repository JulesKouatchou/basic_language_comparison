; **********************************************************
; Given two nxn matrices A and B, we perform:
;       C = A x B
; **********************************************************
;
PRO test_matrix_multiplication, nx

    PRINT, '----------------------------'
    PRINT, 'Matrix dimensions: ', nx
    PRINT, '----------------------------'
    PRINT, ' '

    random_value = RANDOMN(seed)

    A = RANDOMN(seed, nx,nx)
    B = RANDOMN(seed, nx,nx)
    C = FLTARR(nx,nx)

    PRINT, 'multiply two matrices'

    time0 = SYSTIME(/SECONDS)

    C = A#B

    time1 = SYSTIME(/SECONDS) - time0
    PRINT, 'Elapsed time: ', time1

    RETURN
END
