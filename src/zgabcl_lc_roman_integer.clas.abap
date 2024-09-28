CLASS zgabcl_lc_roman_integer DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.

    DATA: lv_roman   TYPE string VALUE 'LXXVII',
          lv_out     TYPE i,
          lv_symb(1) TYPE c.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zgabcl_lc_roman_integer IMPLEMENTATION.
  METHOD if_oo_adt_classrun~main.

    DO.
      IF sy-index > strlen( lv_roman ).
        EXIT.
      ELSEIF sy-index = strlen( lv_roman ).
        DATA(lv_lastdigit) = abap_true.
      ENDIF.

      DATA(lv_off) = sy-index - 1.
      lv_symb = lv_roman+lv_off(1).
      CASE lv_symb.
        WHEN 'I'.
          IF lv_lastdigit IS INITIAL.
            IF lv_roman+sy-index(1) EQ 'V' OR
               lv_roman+sy-index(1) EQ 'X'.
              lv_out -= 1.
            ELSE.
              lv_out += 1.
            ENDIF.
          ELSE.
            lv_out += 1.
          ENDIF.
        WHEN 'V'.
          lv_out += 5.
        WHEN 'X'.
          IF lv_lastdigit IS INITIAL.
            IF lv_roman+sy-index(1) EQ 'L' OR
               lv_roman+sy-index(1) EQ 'C'.
              lv_out -= 10.
            ELSE.
              lv_out += 10.
            ENDIF.
          ELSE.
            lv_out += 10.
          ENDIF.
        WHEN 'L'.
          lv_out += 50.
        WHEN 'C'.
          IF lv_lastdigit IS INITIAL.
            IF lv_roman+sy-index(1) EQ 'D' OR
               lv_roman+sy-index(1) EQ 'M'.
              lv_out -= 100.
            ELSE.
              lv_out += 100.
            ENDIF.
          ELSE.
            lv_out += 100.
          ENDIF.
        WHEN 'D'.
          lv_out += 500.
        WHEN 'M'.
          lv_out += 1000.
        WHEN OTHERS.
      ENDCASE.
    ENDDO.

    "Output number
    out->write( |Value: { lv_out }| ).

  ENDMETHOD.
ENDCLASS.
