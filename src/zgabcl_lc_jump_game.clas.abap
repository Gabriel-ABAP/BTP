CLASS zgabcl_lc_jump_game DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.

    DATA: lt_input     TYPE TABLE OF i,
          lv_steps     TYPE i,
          lv_jumps     TYPE i,
          lv_max_reach TYPE i,
          lv_out       TYPE i.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zgabcl_lc_jump_game IMPLEMENTATION.
  METHOD if_oo_adt_classrun~main.
    lt_input = VALUE #( ( 2 )
                        ( 3 )
                        ( 1 )
                        ( 1 )
                        ( 4 )
                      ).

    DATA(lv_num) = lines( lt_input ).
    lv_steps = lt_input[ 1 ].
    lv_max_reach = lt_input[ 1 ].
    lv_out = 1.

    DO lv_num TIMES.
      DATA(lv_idx) = sy-index.

      IF lv_idx = lv_num - 1.
        EXIT.
      ENDIF.

      DATA(lv_tmp_reach) = lv_idx + lt_input[ lv_idx ].

      IF lv_tmp_reach > lv_max_reach.
        lv_max_reach = lv_tmp_reach.
      ENDIF.

      lv_steps -= 1.

      IF lv_steps IS INITIAL.
        lv_out += 1.

        IF lv_idx >= lv_max_reach.
          lv_out = 999.
          EXIT.
        ENDIF.

        lv_steps = lv_max_reach - lv_idx.

      ENDIF.

    ENDDO.

    "Output number
    out->write( |Value: { lv_out }| ).

  ENDMETHOD.
ENDCLASS.
