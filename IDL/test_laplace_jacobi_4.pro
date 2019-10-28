;----------------------------------------------------------------------
; Numerical solution of the 2D Laplce equation:
;
;    u   + u   = 0
;     xx    yy
;----------------------------------------------------------------------

;##############
; Loop approach
;##############

FUNCTION REGULAR_TIME_STEP_JI, u
    sz = SIZE(u)
    n = sz[1]
    m = sz[2]

    err = 0.0
    FOR j = 1,m-2 DO BEGIN
        FOR i = 1,n-2 DO BEGIN
            tmp = u[i,j]
            u[i,j] = ((u[i-1, j] + u[i+1, j] + $
                       u[i, j-1] + u[i, j+1])*4.0 + $
                       u[i-1,j-1] + u[i-1,j+1] + $
                       u[i+1,j-1] + u[i+1,j+1])/20.0

            diff = u[i,j] - tmp
            err = err + diff*diff
        ENDFOR
    ENDFOR

    RETURN, SQRT(err)
END

FUNCTION REGULAR_SOLVER_JI, u
    max_iter = 100000
    min_err  = 1e-6
    iter =0
    err = 2
    WHILE((iter LT max_iter) AND (err GT min_err)) Do Begin
        err = REGULAR_TIME_STEP_JI(u)
        iter = iter + 1
    ENDWHILE
    RETURN, {err:err, iter:iter}
END

;####################
; Vectorized approach
;####################

FUNCTION VECTORIZED_TIME_STEP, u
    sz = SIZE(u)
    n = sz[1]
    m = sz[2]
    u_old = REFORM(u,[n,m])

    u[1:n-2, 1:m-2] = ((u[0:n-3, 1:m-2] + u[2:n-1, 1:m-2] + $
                        u[1:n-2, 0:m-3] + u[1:n-2, 2:m-1])*4.0 + $
                        u[0:n-3, 0:m-3] + u[0:n-3, 2:m-1] + $
                        u[2:n-1, 0:m-3] + u[2:n-1, 2:m-1])/20.0

    v = REFORM(u - u_old, N_ELEMENTS(u))
    RETURN, SQRT(TRANSPOSE(v)#v)
END

FUNCTION VECTORIZED_SOLVER, u
    max_iter = 100000
    min_err  = 1e-6
    iter =0
    err = 2
    WHILE((iter LT max_iter) AND (err GT min_err)) DO BEGIN
        err = VECTORIZED_TIME_STEP(u)
        iter = iter + 1
    ENDWHILE
    RETURN, {err:err, iter:iter}
END

; Main program
PRO test_laplace_jacobi_4, numPoints

    pi_c = 4.0*ATAN(1.0)

    u = FLTARR(numPoints,numPoints)
    x = FLTARR(numPoints)
    FOR i = 0, numPoints-1 DO BEGIN
        x[i] = i*pi_c/(numPoints-1)
    ENDFOR

    PRINT, "------------------------------------------------"
    PRINT, "Regular Solver (ji loop) for Fourth-Order Scheme: ", numPoints
    PRINT, "------------------------------------------------"

    u[*,*] = 0.0
    u[0,*] = SIN(x)
    u[numPoints-1,*] = SIN(x)*EXP(-pi_c)

    time0 = SYSTIME(/SECONDS)
    sol = REGULAR_SOLVER_JI(u)
    time1 = SYSTIME(/SECONDS) - time0

    PRINT, " "
    PRINT, "  ji   Number of iterations: ", sol.iter
    PRINT, "       Error:", sol.err
    PRINT, '       Elapsed time: ', time1
    PRINT, " "

    PRINT, "-----------------------------------------"
    PRINT, "Vectorized Solver for Fourth-Order Scheme: ", numPoints
    PRINT, "-----------------------------------------"

    u[*,*] = 0.0
    u[0,*] = SIN(x)
    u[numPoints-1,*] = SIN(x)*EXP(-pi_c)

    time0 = SYSTIME(/SECONDS)
    sol = VECTORIZED_SOLVER(u)
    time1 = SYSTIME(/SECONDS) - time0

    PRINT, " "
    PRINT, "       Number of iterations: ", sol.iter
    PRINT, "       Error:", sol.err
    PRINT, '       Elapsed time: ', time1

    RETURN
END
