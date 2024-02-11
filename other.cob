           IDENTIFICATION DIVISION.
           PROGRAM-ID. other.
           
           ENVIRONMENT DIVISION.
           DATA DIVISION.
           FILE SECTION.
           
           WORKING-STORAGE SECTION.
           01 WS-VAR1 PIC 9(4) VALUE 0.
           01 WS-VAR2 PIC 9(4) VALUE 0.
           01 WS-RESULT PIC 9(4) VALUE 0.
           01 WS-TEXT1 PIC A(10) VALUE 'Hello'.
           01 WS-TEXT2 PIC A(10) VALUE 'World'.
           01 WS-COMBINED-TEXT PIC A(20).
           01 WS-NUMBERS OCCURS 5 TIMES PIC 9(4).

           01 WS-DATE.
              05 WS-YEAR PIC 9(4).
              05 WS-MONTH PIC 9(2).
              05 WS-DAY PIC 9(2).

           01 WS-INDEX PIC 9(4).
           
           PROCEDURE DIVISION.
               DISPLAY 'Other program called - new3'
               STOP RUN.
