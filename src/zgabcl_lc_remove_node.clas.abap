CLASS zgabcl_lc_remove_node DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.

    DATA: lt_input  TYPE TABLE OF i,
          lt_output TYPE TABLE OF i,
          lv_node   TYPE i.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zgabcl_lc_remove_node IMPLEMENTATION.
  METHOD if_oo_adt_classrun~main.

    "Populate list and set removal node >> bottom to top.
    lv_node = 2.
    DO 4 TIMES.
      APPEND sy-index * 2 TO lt_input.
    ENDDO.

    DATA(lv_lines) = lines( lt_input ).
    DATA(lv_removal) = lv_lines - lv_node + 1.
    DELETE lt_input INDEX lv_removal.
    lt_output[] = lt_input[].

    "Output list
    LOOP AT lt_output ASSIGNING FIELD-SYMBOL(<fs_out>).
      out->write( |Value: { <fs_out> }| ).
    ENDLOOP.

  ENDMETHOD.
ENDCLASS.
