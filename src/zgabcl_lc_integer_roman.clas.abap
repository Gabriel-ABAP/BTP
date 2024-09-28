CLASS zgabcl_lc_integer_roman DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.

    DATA: lv_int TYPE string VALUE '3749',
          lv_out TYPE string.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zgabcl_lc_integer_roman IMPLEMENTATION.
  METHOD if_oo_adt_classrun~main.

    WHILE lv_int >= 1000.
      lv_out = lv_out && 'M'.
      lv_int -= 1000.
    ENDWHILE.

    WHILE lv_int >= 900.
      lv_out = lv_out && 'CM'.
      lv_int -= 900.
    ENDWHILE.

    WHILE lv_int >= 500.
      lv_out = lv_out && 'D'.
      lv_int -= 500.
    ENDWHILE.

    WHILE lv_int >= 400.
      lv_out = lv_out && 'CD'.
      lv_int -= 400.
    ENDWHILE.

    WHILE lv_int >= 100.
      lv_out = lv_out && 'C'.
      lv_int -= 100.
    ENDWHILE.

    WHILE lv_int >= 90.
      lv_out = lv_out && 'XC'.
      lv_int -= 90.
    ENDWHILE.

    WHILE lv_int >= 50.
      lv_out = lv_out && 'L'.
      lv_int -= 50.
    ENDWHILE.

    WHILE lv_int >= 40.
      lv_out = lv_out && 'XL'.
      lv_int -= 40.
    ENDWHILE.

    WHILE lv_int >= 10.
      lv_out = lv_out && 'X'.
      lv_int -= 10.
    ENDWHILE.

    WHILE lv_int >= 9.
      lv_out = lv_out && 'IX'.
      lv_int -= 9.
    ENDWHILE.

    WHILE lv_int >= 5.
      lv_out = lv_out && 'V'.
      lv_int -= 5.
    ENDWHILE.

    WHILE lv_int >= 4.
      lv_out = lv_out && 'IV'.
      lv_int -= 4.
    ENDWHILE.

    WHILE lv_int >= 1.
      lv_out = lv_out && 'XC'.
      lv_int -= 1.
    ENDWHILE.

    "Output number
    out->write( |Value: { lv_out }| ).

  ENDMETHOD.
ENDCLASS.
