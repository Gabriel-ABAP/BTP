CLASS zgabcl_lc_sudoku DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.

    TYPES: BEGIN OF ty_board,
             col1(1) TYPE c,
             col2(1) TYPE c,
             col3(1) TYPE c,
             col4(1) TYPE c,
             col5(1) TYPE c,
             col6(1) TYPE c,
             col7(1) TYPE c,
             col8(1) TYPE c,
             col9(1) TYPE c,
           END OF ty_board.

    DATA: lt_input   TYPE TABLE OF ty_board,
          lt_check   TYPE TABLE OF c,
          lt_matrix1 TYPE TABLE OF c,
          lt_matrix2 TYPE TABLE OF c,
          lt_matrix3 TYPE TABLE OF c,
          lv_output  TYPE string.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.


CLASS zgabcl_lc_sudoku IMPLEMENTATION.
  METHOD if_oo_adt_classrun~main.

    lt_input = VALUE #( ( col1 = '5' col2 = '3' col3 = ' ' col4 = ' ' col5 = '7' col6 = ' ' col7 = ' ' col8 = ' ' col9 = ' ' )
                        ( col1 = '6' col2 = ' ' col3 = ' ' col4 = '1' col5 = '9' col6 = '5' col7 = ' ' col8 = ' ' col9 = ' ' )
                        ( col1 = ' ' col2 = '9' col3 = '8' col4 = ' ' col5 = ' ' col6 = ' ' col7 = ' ' col8 = '6' col9 = '3' )
                        ( col1 = '8' col2 = ' ' col3 = ' ' col4 = ' ' col5 = '6' col6 = ' ' col7 = ' ' col8 = ' ' col9 = '1' )
                        ( col1 = '4' col2 = ' ' col3 = ' ' col4 = '8' col5 = ' ' col6 = '3' col7 = ' ' col8 = ' ' col9 = '6' )
                        ( col1 = '7' col2 = ' ' col3 = ' ' col4 = ' ' col5 = '2' col6 = ' ' col7 = ' ' col8 = ' ' col9 = ' ' )
                        ( col1 = ' ' col2 = '6' col3 = ' ' col4 = ' ' col5 = ' ' col6 = ' ' col7 = '2' col8 = '8' col9 = ' ' )
                        ( col1 = ' ' col2 = ' ' col3 = ' ' col4 = '4' col5 = '1' col6 = '9' col7 = ' ' col8 = ' ' col9 = '5' )
                        ( col1 = ' ' col2 = ' ' col3 = ' ' col4 = ' ' col5 = '8' col6 = ' ' col7 = ' ' col8 = '7' col9 = '9' )
                      ).

    lv_output = 'True'.
    LOOP AT lt_input ASSIGNING FIELD-SYMBOL(<fs_input>).

      "1st rule: each row contain only digits [1-9] without repetition
      CHECK lv_output <> 'False'.
      CLEAR lt_check[].
      DATA(vl_tabix) = sy-tabix.

      DO 9 TIMES.
        ASSIGN COMPONENT sy-index OF STRUCTURE <fs_input> TO FIELD-SYMBOL(<fs_fname>).
        IF ( <fs_fname> ) <> abap_false.
          READ TABLE lt_check WITH KEY table_line = <fs_fname> TRANSPORTING NO FIELDS.
          IF sy-subrc NE 0.
            APPEND <fs_fname> TO lt_check.
          ELSE.
            lv_output = 'False'.
            EXIT.
          ENDIF.

          "3rd rule: each 3x3 matrix contain digits [1-9] without repetition
          CASE sy-index.
            WHEN 1 OR 2 OR 3.
              READ TABLE lt_matrix1 WITH KEY table_line = <fs_fname> TRANSPORTING NO FIELDS.
              IF sy-subrc NE 0.
                APPEND <fs_fname> TO lt_matrix1.
              ELSE.
                lv_output = 'False'.
                EXIT.
              ENDIF.
            WHEN 4 OR 5 OR 6.
              READ TABLE lt_matrix2 WITH KEY table_line = <fs_fname> TRANSPORTING NO FIELDS.
              IF sy-subrc NE 0.
                APPEND <fs_fname> TO lt_matrix2.
              ELSE.
                lv_output = 'False'.
                EXIT.
              ENDIF.
            WHEN 7 OR 8 OR 9.
              READ TABLE lt_matrix3 WITH KEY table_line = <fs_fname> TRANSPORTING NO FIELDS.
              IF sy-subrc NE 0.
                APPEND <fs_fname> TO lt_matrix3.
              ELSE.
                lv_output = 'False'.
                EXIT.
              ENDIF.
          ENDCASE.

        ENDIF.
      ENDDO.

      "Clear 3rd rule matrixes
      IF ( vl_tabix MOD 3 ) = 0.
        CLEAR: lt_matrix1[],
               lt_matrix2[],
               lt_matrix3[].
      ENDIF.

    ENDLOOP.

    "2nd rule: each column contain only digits [1-9] without repetition
    IF lv_output <> 'False'.
      DO 9 TIMES.
        CLEAR lt_check[].
        DATA(lv_index) = sy-index.
        DATA(lv_fname) = 'col' && lv_index.
        ASSIGN lv_fname TO <fs_fname>.

        DO 9 TIMES.
          READ TABLE lt_input INDEX sy-index ASSIGNING <fs_input>.
          ASSIGN COMPONENT sy-index OF STRUCTURE <fs_input> TO <fs_fname>.
          IF <fs_fname> <> abap_false.
            READ TABLE lt_check WITH KEY table_line = <fs_fname> TRANSPORTING NO FIELDS.
            IF sy-subrc NE 0.
              APPEND <fs_fname> TO lt_check.
            ELSE.
              lv_output = 'False'.
              EXIT.
            ENDIF.
          ENDIF.
        ENDDO.
        CLEAR lv_fname.
      ENDDO.

    ENDIF.

    out->write( |Output: { lv_output }| ).

  ENDMETHOD.
ENDCLASS.
