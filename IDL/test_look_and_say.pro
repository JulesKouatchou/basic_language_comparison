
;      Construct the look and say sequence of order num and
;      starting sequence, start_seq (string).

PRO test_look_and_say, num
    time0 = SYSTIME(/SECONDS)

    start_seq = '1223334444'
    i = 0

    WHILE (i LT num) DO BEGIN
        IF (i EQ 0) THEN BEGIN
            cur_seq = start_seq
        ENDIF ELSE BEGIN
            count = 1
            temp_series = ''
            FOR j = 1, STRLEN(cur_seq)-1 DO BEGIN
                IF (STRMID(cur_seq, j, 1) EQ STRMID(cur_seq, j-1, 1)) THEN BEGIN
                    count = count + 1
                ENDIF ELSE BEGIN
                    temp_series = temp_series + STRTRIM(count,1) + STRMID(cur_seq, j-1, 1)
                    count = 1
                ENDELSE
            ENDFOR
            temp_series = temp_series + STRTRIM(count,1) + STRMID(cur_seq, STRLEN(cur_seq)-1, 1)
            cur_seq = temp_series
        ENDELSE
        i = i + 1
    ENDWHILE

    time1 = SYSTIME(/SECONDS) - time0
    PRINT, 'Look and Say Sequence (',num,'): ', time1
    ;print, cur_seq
END
