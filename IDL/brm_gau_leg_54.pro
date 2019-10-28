;+
; PROJECT:
;	HESSI
;
; NAME:
;	Brm_GauLeg54
;
; PURPOSE:
;	Returns arrays x and w, containing the abscissas and weights of the
;	Gauss-Legendre n-point quadrature formula.
;
; CATEGORY:
;	HESSI, Spectra, Modeling
;
; CALLING SEQUENCE:
;	Brm_GauLeg54, x1, x2, n, x, w
;
; CALLS:
;	none
;
; INPUTS:
;
;	x1		-	Array containing lower limits of integration.
;
;	x2		-	Upper limit(s) of integration.  This input may be either a
;				scalar, or an array corresponding to x1.
;
;	n		-	Number of points evaluated.
;
;
; OPTIONAL INPUTS:
;	none
;
; OUTPUTS:
;
;   x		-	Two-dimensional array containing the abscissas of the Gauss-
;				Legendre n-point quadrature formula.  Each column of this array
;				corresponds to an element of the input array x1.
;
;	w		-	Two-dimensional array containing the weights of the Gauss-
;				Legendre n-point quadrature formula.  Each column of this array
;				corresponds to an element of the input array x1.
;
;
; OPTIONAL OUTPUTS:
;	none
;
; KEYWORDS:
;	none
;
; COMMON BLOCKS:
;	none
;
; SIDE EFFECTS:
;
;
; RESTRICTIONS:
;
;
; PROCEDURE:
;	This procedure is based upon the subroutine in "Numerical Recipes in
;	Fortran 77," Second Edition, Cambridge University Press, p. 145.  This
;	procedure may be used only with IDL Version 5.4 or later.
;
; MODIFICATION HISTORY:
;   Version 1, holman@stars.gsfc.nasa.gov, 23 July 2001
;   IDL version:  Sally House, summer intern
;	Documentation for the Fortran Version of this code can be found at
;	http://hesperia.gsfc.nasa.gov/hessi/modelware.htm
;
;-

Pro brm_gau_leg_54, x1, x2, n, x, w

eps = 3.d-14

m = (n+1)/2

xm = 0.5d0*(x2+x1)
xl = 0.5d0*(x2-x1)

FOR i = 1, m DO BEGIN

	z = Cos(!dpi*(i-0.25d0)/(n+0.5d0))

	noconv:

	p1 = Legendre(z, n, /Double)
	p2 = Legendre(z, n-1, /Double)

	pp = n*(z*p1-p2)/(z^2-1.d0)

	z1 = z
	z = z1-p1/pp

	IF (Abs(z-z1) GT eps) THEN GOTO, noconv

	x(*,i-1) = xm-xl*z
	x(*,n-i) = xm+xl*z
	w(*,i-1) = 2.d0*xl/((1.d0-z^2)*pp^2)
	w(*,n-i) = w(*,i-1)

ENDFOR

END
