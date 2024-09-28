CLASS zgabcl_lc_palindrome DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.

    DATA: lv_input  TYPE char200 VALUE 'A man, a plan, a canal: Panama',
          lv_pal    TYPE char200,
          lv_trim   TYPE char200,
          lv_off    TYPE i,
          lv_output TYPE char5.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zgabcl_lc_palindrome IMPLEMENTATION.
  METHOD if_oo_adt_classrun~main.

    lv_off = strlen( lv_input ).

    WHILE lv_off > 0.
      DATA(lv_reg) = sy-index - 1.
      lv_off -= 1.

      "Mount the input alphanumeric only
      IF lv_input+lv_reg(1) CA '1234567890ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz'.
        lv_trim = lv_trim && lv_input+lv_reg(1).
      ENDIF.

      "Mount the input backwards
      IF lv_input+lv_off(1) CA '1234567890ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz'.
        lv_pal = lv_pal && lv_input+lv_off(1).
      ENDIF.
    ENDWHILE.

    TRANSLATE: lv_trim TO LOWER CASE,
               lv_pal  TO LOWER CASE.
    IF lv_trim = lv_pal.
      " Return the maximum area found
      out->write( |Output: True| ).
    ELSE.
      out->write( |Output: False| ).
    ENDIF.

  ENDMETHOD.

ENDCLASS.
