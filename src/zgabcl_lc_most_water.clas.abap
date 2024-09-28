CLASS zgabcl_lc_most_water DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.

    DATA: lt_input  TYPE TABLE OF i,
          lt_output TYPE TABLE OF i,
          lv_amount TYPE i,
          lv_output TYPE i.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zgabcl_lc_most_water IMPLEMENTATION.
  METHOD if_oo_adt_classrun~main.

    lt_input = VALUE #( ( 1 )
                        ( 8 )
                        ( 6 )
                        ( 2 )
                        ( 5 )
                        ( 4 )
                        ( 8 )
                        ( 3 )
                        ( 7 )
                      ).

    " Declare variables for the left and right pointers, and to store the maximum area
    DATA: lv_left  TYPE i,
          lv_right TYPE i,
          lv_max   TYPE i,
          lv_area  TYPE i.

    " Initialize the left pointer to the start and the right pointer to the end of the array
    lv_left = 1.
    lv_right = lines( lt_input ).
    lv_max = 0.

    " Loop until the left pointer is less than the right pointer
    WHILE lv_left < lv_right.
      " Calculate the area formed by the lines at the left and right pointers
      IF lt_input[ lv_left ] < lt_input[ lv_right ].
        DATA(lv_height) = lt_input[ lv_left ].
      ELSE.
        lv_height = lt_input[ lv_right ].
      ENDIF.
      lv_area = lv_height * ( lv_right - lv_left ).

      " Update the maximum area if the current area is greater
      IF lv_area > lv_max.
        lv_max = lv_area.
      ENDIF.

      " Move the pointer pointing to the shorter line inward
      IF lt_input[ lv_left ] < lt_input[ lv_right ].
        lv_left += 1.
      ELSE.
        lv_right -= 1.
      ENDIF.
    ENDWHILE.

    " Return the maximum area found
    out->write( |Output: { lv_max }| ). .

  ENDMETHOD.
ENDCLASS.
