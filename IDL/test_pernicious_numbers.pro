
FUNCTION count_ones,n
   ; -------------------------------------------------------------
   ; Count the number of 1s in a binary number
   ;  1. Convert the binary number into a string
   ;  2. Extract all the 0s from the string and get a string (with empty speces) of 1s
   ;  3. Join the string by removing empty spaces.
   ;  3. Count the length of the new string.
   ; -------------------------------------------------------------
   RETURN, STRLEN(STRJOIN(STRSPLIT(STRING(n), '0', /EXTRACT)))
END

; Use the LAMBDA function to determine if a number is prime
; https://www.l3harrisgeospatial.com/Support/Maintenance-Detail/ArtMID/13350/ArticleID/15792/Whats-New-in-IDL-84
; isprime = LAMBDA(n:n le 3 || MIN(n mod [2:FIX(SQRT(n))]))

FUNCTION is_prime_number, m
   ; Determine if a number is prime (1) or not (0).
   IF (m LT 2) THEN BEGIN
      num = 0
   ENDIF ELSE BEGIN
      isprime = LAMBDA(n:n le 3 || MIN(n mod [2:FIX(SQRT(n))]))
      num = m.Map(isprime)
   ENDELSE
   RETURN, num
END

PRO test_pernicious_numbers, max_num

    time0 = SYSTIME(/SECONDS)

    i = 1L
    num_pernicious = 0L

    WHILE (num_pernicious LT max_num) DO BEGIN
        num_ones = count_ones(i.ToBinary())
        IF (is_prime_number(num_ones) EQ 1) THEN BEGIN
           ;PRINT, i, ' --->', i.ToBinary(), '  ', num_ones, ' ', num_ones.Map(isprime)
           num_pernicious = num_pernicious + 1
        ENDIF
        i = i + 1
    ENDWHILE


    time1 = SYSTIME(/SECONDS) - time0
    PRINT, 'Pernicious Numbers (',max_num,'): ', time1, i-1

    RETURN
END
