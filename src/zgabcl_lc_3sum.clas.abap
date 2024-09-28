CLASS zgabcl_lc_3sum DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.

    DATA: lt_input TYPE TABLE OF i,
          lt_out   TYPE TABLE OF char100,
          ls_out   TYPE char100.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zgabcl_lc_3sum IMPLEMENTATION.
  METHOD if_oo_adt_classrun~main.

    lt_input = VALUE #( ( 0 )
                        ( 1 )
                        ( 1 )
*                        ( 2 )
*                        ( -1 )
*                        ( -4 )
                      ).

    DATA(lv_string_size) = lines( lt_input ).
*    LOOP AT lt_input ASSIGNING FIELD-SYMBOL(<fs_input>).

    DO lv_string_size TIMES.
      "1st parcel
      DATA(lv_next_triplet) = abap_false.
      DATA(lv_parc1_idx) = sy-index.
      READ TABLE lt_input INDEX lv_parc1_idx INTO DATA(lv_parc1).

      DO lv_string_size - 1 TIMES.
        "2nd parcel
        DATA(lv_parc2_idx) = sy-index + lv_parc1_idx.
        READ TABLE lt_input INDEX lv_parc1_idx + 1 INTO DATA(lv_parc2).

        DO lv_string_size - 2 TIMES.
          "3rd parcel
          DATA(lv_parc3_idx) = sy-index + lv_parc2_idx.
          READ TABLE lt_input INDEX lv_parc1_idx + 2 INTO DATA(lv_parc3).

          "Sum of 3 must equal to 0
          IF lv_parc1 + lv_parc2 + lv_parc3 = 0.
            "They must all differ
            IF lv_parc1 <> lv_parc2 AND
               lv_parc1 <> lv_parc3 AND
               lv_parc2 <> lv_parc3.

              ls_out = lv_parc1 && ',' &&
                       lv_parc2 && ',' &&
                       lv_parc3.
              APPEND ls_out TO lt_out.
              lv_next_triplet = abap_true.
              EXIT.
            ENDIF.
            "Result must contain 3 elements
          ENDIF.
        ENDDO.
        CHECK lv_next_triplet IS NOT INITIAL.
        EXIT.
      ENDDO.
      CHECK lv_string_size - lv_parc1_idx = 3.
      EXIT.
    ENDDO.

    "Output number
    LOOP AT lt_out INTO DATA(lv_out).
      out->write( |Value: { lv_out }| ).
    ENDLOOP.

  ENDMETHOD.
ENDCLASS.
