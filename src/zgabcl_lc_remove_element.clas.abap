CLASS zgabcl_lc_remove_element DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.

    TYPES: BEGIN OF ty_array,
             nums TYPE char1,
           END OF ty_array.

    DATA: lt_input  TYPE STANDARD TABLE OF ty_array WITH NON-UNIQUE KEY nums,
          lv_val    TYPE c VALUE 2,
          lv_output TYPE c.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zgabcl_lc_remove_element IMPLEMENTATION.
  METHOD if_oo_adt_classrun~main.
    lt_input = VALUE #( ( nums = 0 )
                        ( nums = 1 )
                        ( nums = 2 )
                        ( nums = 2 )
                        ( nums = 3 )
                        ( nums = 0 )
                        ( nums = 4 )
                        ( nums = 2 )
                      ).

    LOOP AT lt_input ASSIGNING FIELD-SYMBOL(<fs_input>)
                       WHERE nums = lv_val.
      <fs_input>-nums = '_'.
      lv_output += 1.
    ENDLOOP.

    DATA(lt_final) = lt_input[].
    WHILE sy-subrc = 0.
      DELETE TABLE lt_final WITH TABLE KEY nums = '_'.
    ENDWHILE.
    lv_output = lines( lt_final ).
    out->write( |Output: { lv_output }| ).

    SORT lt_input BY nums ASCENDING.
    LOOP AT lt_input ASSIGNING <fs_input>.
      out->write( |{ <fs_input>-nums }| ).
    ENDLOOP.

  ENDMETHOD.
ENDCLASS.
