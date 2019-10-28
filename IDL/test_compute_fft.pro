
; **********************************************************
; **********************************************************

PRO test_compute_fft, n

    PRINT, '----------------------------'
    PRINT, 'FFTs: ', n
    PRINT, '----------------------------'
    PRINT, ' '

    time0 = SYSTIME(/SECONDS)

    seed1 = !NULL
    random_value_1 = RANDOMU(seed1)
    seed2 = !NULL
    random_value_2 = RANDOMN(seed2)

    ;A = RANDOMN(seed, n,n)
    ;B = RANDOMN(seed, n,n)
    mat = COMPLEX(RANDOMN(seed1, n,n), RANDOMN(seed2, n,n))

    result = FFT(mat)
    result = ABS(result)

    time1 = SYSTIME(/SECONDS) - time0
    PRINT, 'Elapsed time: ', time1

    RETURN

END
