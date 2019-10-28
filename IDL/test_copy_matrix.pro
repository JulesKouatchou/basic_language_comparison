; **********************************************************
; Given a nxnx3 matrix A, we want to perform the operations:
;
;       A[i][j][0] = A[i][j][1]
;       A[i][j][2] = A[i][j][0]
;       A[i][j][1] = A[i][j][2]
; **********************************************************

PRO test_copy_matrix, nx


    PRINT, "-------------------------"
    PRINT, "Copy of matrix (ji loop)"
    PRINT, "-------------------------"

    random_value = RANDOMN(Seed)
    A = RANDOMN(Seed, nx,nx, 3)

    time0 = SYSTIME(/SECONDS)
    FOR j = 0,nx-1 DO BEGIN
        FOR i = 0,nx-1 DO BEGIN
            A[i,j,0] = A[i,j,1]
            A[i,j,2] = A[i,j,0]
            A[i,j,1] = A[i,j,2]
        ENDFOR
    ENDFOR

    time_ji_loop = SYSTIME(/SECONDS) - time0
    print, 'Time for ji Loop: ', time_ji_loop

    PRINT, " "

    PRINT, "--------------------------"
    PRINT, "Vectorized Copy of matrix"
    PRINT, "--------------------------"

    random_value = RANDOMN(Seed)
    A = RANDOMN(Seed, nx,nx, 3)

    time0 = SYSTIME(/SECONDS)

    A[*,*,0] = A[*,*,1]
    A[*,*,2] = A[*,*,0]
    A[*,*,1] = A[*,*,2]

    time_vec = SYSTIME(/SECONDS) - time0
    PRINT, 'Time for vectorization: ', time_vec

    PRINT, " "

END
