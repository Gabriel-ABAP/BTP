CLASS zgabcl_lc_inverted_sum DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.

    DATA: lv_1   TYPE string,
          lv_2   TYPE string,
          lv_c1  TYPE string,
          lv_c2  TYPE string,
          lv_out TYPE f.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zgabcl_lc_inverted_sum IMPLEMENTATION.
  METHOD if_oo_adt_classrun~main.

****Sum inverted numbers****

    lv_1 = '33'.   "inverted, is 6625
    lv_2 = '10012'.  "inverted, is 12263

    "Logic 1
    DATA(lv_comp1) = strlen( lv_1 ).
    DATA(lv_comp2) = strlen( lv_2 ).

    DO.

      IF lv_comp1 < 0 AND
         lv_comp2 < 0.
        EXIT.
      ENDIF.

      "Normalize numbers first
      lv_comp1 -= 1.
      lv_comp2 -= 1.

      "Compose new parameters
      IF lv_comp1 >= 0.
        lv_c1 = lv_c1 && lv_1+lv_comp1(1).
      ENDIF.

      IF  lv_comp2 >= 0.
        lv_c2 = lv_c2 && lv_2+lv_comp2(1).
      ENDIF.

    ENDDO.

    lv_out = conv #( lv_c1 + lv_c2 ).

    out->write( |Sum: { lv_out }| ).

  ENDMETHOD.
ENDCLASS.
