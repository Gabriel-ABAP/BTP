CLASS zgabcl_lc_last_word DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.

    DATA: lv_input     TYPE string VALUE 'Hello World',
          lv_last_word TYPE char100,
          lv_output    TYPE i.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zgabcl_lc_last_word IMPLEMENTATION.
  METHOD if_oo_adt_classrun~main.

    DATA(lv_size) = strlen( lv_input ).

    DO strlen( lv_input ) TIMES.
      lv_size -= 1.
      IF lv_input+lv_size(1) = ' '.
        IF lv_last_word IS INITIAL.
          CONTINUE.
        ELSE.
          EXIT.
        ENDIF.
      ELSE.
        lv_last_word+lv_size(1) = lv_input+lv_size(1).
      ENDIF.
    ENDDO.

    lv_output = strlen( lv_last_word ).
    out->write( |Value: { lv_output }| ).

  ENDMETHOD.
ENDCLASS.
