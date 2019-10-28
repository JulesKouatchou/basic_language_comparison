PRO test_gauss_legendre_quadrature, n


    PRINT, "-------------------------"
    PRINT, "Gauss Legendre Quadrature", n
    PRINT, "-------------------------"

    time_beg = SYSTIME(/SECONDS)

    x1 = -3.0
    x2 =  3.0
    x = FLTARR(1,n)
    w = FLTARR(1,n)

    brm_gau_leg_54, x1, x2, n, x, w

    quad = TOTAL(w*exp(x))

    time_end = SYSTIME(/SECONDS) - time_beg
    PRINT, 'Time for Gauss Legendre Quadrature: ', time_end

    PRINT, " "

END
