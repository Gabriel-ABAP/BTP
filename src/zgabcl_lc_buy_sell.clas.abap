CLASS zgabcl_lc_buy_sell DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.

    TYPES: BEGIN OF ty_stock,
             day TYPE i,
             val TYPE i,
           END OF ty_stock.

    DATA: lt_input  TYPE TABLE OF ty_stock,
          lv_output TYPE i.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zgabcl_lc_buy_sell IMPLEMENTATION.
  METHOD if_oo_adt_classrun~main.

    lt_input = VALUE #( ( day = 1 val = 7 )
                        ( day = 2 val = 6 )
                        ( day = 3 val = 4 )
                        ( day = 4 val = 5 )
                        ( day = 5 val = 5 )
                        ( day = 6 val = 1 )
                      ).
    DATA(lt_sort_asc) = lt_input[].
    DATA(lt_sort_des) = lt_input[].

    SORT lt_sort_asc ASCENDING BY val.  "Defining best buys
    SORT lt_sort_des DESCENDING BY val. "Defining best sells

    CLEAR lv_output.

    LOOP AT lt_sort_asc ASSIGNING FIELD-SYMBOL(<fs_asc>).

      LOOP AT lt_sort_des ASSIGNING FIELD-SYMBOL(<fs_des>).

        IF <fs_des>-day > <fs_asc>-day.
          "It's in the future
          IF <fs_des>-val - <fs_asc>-val > lv_output.
            lv_output = <fs_des>-val - <fs_asc>-val.
          ENDIF.
        ENDIF.

      ENDLOOP.

    ENDLOOP.

    out->write( |Profit: { lv_output }| ).

  ENDMETHOD.
ENDCLASS.
