CLASS zgabcl_lc_long_common_prefix DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.

    DATA: lt_input  TYPE TABLE OF string,
*          lt_output TYPE TABLE OF i,
          lv_output TYPE string.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zgabcl_lc_long_common_prefix IMPLEMENTATION.
  METHOD if_oo_adt_classrun~main.

    lt_input = VALUE #( ( |flower| )
                        ( |flow|   )
                        ( |flight| )
                        ( |ja| )
                      ).
*Suggested by AI
    DATA: lv_pref TYPE string,
          lv_str  TYPE string.

    READ TABLE lt_input INDEX 1 INTO lv_pref.
    IF sy-subrc <> 0.
      CLEAR lv_output.
    ENDIF.

    LOOP AT lt_input ASSIGNING FIELD-SYMBOL(<fs_input>) FROM 2.
      IF lv_str IS INITIAL.
        DO.
          IF strlen( <fs_input> ) >= sy-index.
            IF lv_pref(sy-index) EQ <fs_input>(sy-index).
              lv_str = lv_pref(sy-index).
            ELSE.
              EXIT.
            ENDIF.
          ELSE.
            EXIT.
          ENDIF.
        ENDDO.
      ELSE.
        DATA(lv_off) = strlen( lv_str ).
        DO.
          IF lv_off IS INITIAL.
            EXIT.
          ELSE.
            FIND lv_str(lv_off) IN <fs_input>.
            IF sy-subrc <> 0.
              lv_off -= 1.
            ELSE.
              EXIT.
            ENDIF.
          ENDIF.
        ENDDO.
      ENDIF.
    ENDLOOP.

    out->write( |Output: { lv_str(lv_off) }| ).

  ENDMETHOD.
ENDCLASS.
