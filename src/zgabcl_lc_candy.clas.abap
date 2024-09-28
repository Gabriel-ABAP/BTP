CLASS zgabcl_lc_candy DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.

    TYPES: BEGIN OF ty_children,
             rat TYPE i,
           END OF ty_children.

    DATA: lt_input       TYPE TABLE OF ty_children,
          lv_output      TYPE i,
          lv_prior_child TYPE i,
          ls_front_child LIKE LINE OF lt_input.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zgabcl_lc_candy IMPLEMENTATION.
  METHOD if_oo_adt_classrun~main.

    lt_input = VALUE #( ( rat = 1 )
                        ( rat = 0 )
                        ( rat = 2 )
                      ).

    LOOP AT lt_input ASSIGNING FIELD-SYMBOL(<fs_input>).
      IF sy-tabix = lines( lt_input ).
        CLEAR ls_front_child-rat.
      ELSE.
        READ TABLE lt_input INDEX ( sy-tabix + 1 )
                     TRANSPORTING rat
                             INTO ls_front_child.
      ENDIF.

      IF <fs_input>-rat > 0              AND
         <fs_input>-rat > lv_prior_child OR
         <fs_input>-rat > ls_front_child-rat.
        lv_output += 2.
      ELSE.
        lv_output += 1.
      ENDIF.
      lv_prior_child = <fs_input>-rat.

    ENDLOOP.

    out->write( |Output: { lv_output }| ).

* Suggested by AI
*    DATA: ratings       TYPE TABLE OF i WITH EMPTY KEY,
*          candies       TYPE TABLE OF i WITH EMPTY KEY,
*          i             TYPE i,
*          n             TYPE i,
*          total_candies TYPE i.
*
** Initialize ratings array
*    ratings = VALUE #( ( 1 ) ( 2 ) ( 2 ) ).
*
** Get the number of children
*    n = lines( ratings ).
*
** Initialize candies array with 1 candy for each child
*    candies = VALUE #( FOR j = 1 UNTIL j > n ( 1 ) ).
*
** Forward pass to ensure higher rated children get more candies than left neighbor
*    DO n TIMES.
*      IF i > 1 AND ratings[ i ] > ratings[ i - 1 ].
*        candies[ i ] = candies[ i - 1 ] + 1.
*      ENDIF.
*      i = i + 1.
*    ENDDO.
*
** Backward pass to ensure higher rated children get more candies than right neighbor
*    i = n.
*    DO n TIMES.
*      IF i < n AND ratings[ i ] > ratings[ i + 1 ] AND candies[ i ] <= candies[ i + 1 ].
*        candies[ i ] = candies[ i + 1 ] + 1.
*      ENDIF.
*      i = i - 1.
*    ENDDO.
*
** Calculate the total number of candies
*    LOOP AT candies INTO DATA(candy).
*      total_candies = total_candies + candy.
*    ENDLOOP.
*
*    out->write( |Output: { total_candies }| ).

  ENDMETHOD.
ENDCLASS.
