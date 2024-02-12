           IDENTIFICATION DIVISION.
           PROGRAM-ID. MAINPGM.
           
           ENVIRONMENT DIVISION.
           DATA DIVISION.
           FILE SECTION.
           
           WORKING-STORAGE SECTION.
           01 ARGS.
               02 WS-VAR1 PIC 9(4) VALUE 12.
               02 WS-VAR2 PIC 9(4) VALUE 22.
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
               DISPLAY 'COBOL Demo Program'
           
      * Arithmetic Operations
               ADD 100 TO WS-VAR1.
               SUBTRACT 50 FROM WS-VAR1.
               MULTIPLY WS-VAR1 BY 2 GIVING WS-RESULT.
               DIVIDE WS-VAR1 BY 2 GIVING WS-RESULT.
           
               DISPLAY 'Result of arithmetic operations: ' WS-RESULT
           
      * String Manipulation
               MOVE WS-TEXT1 TO WS-COMBINED-TEXT.
               STRING WS-TEXT1 DELIMITED BY SIZE ' ' WS-TEXT2 
               DELIMITED BY SIZE
                   INTO WS-COMBINED-TEXT.
               DISPLAY 'Combined Text: ' WS-COMBINED-TEXT.
           
      * Conditional Statements
               IF WS-VAR1 > WS-VAR2 THEN
                   DISPLAY 'VAR1 is greater than VAR2'
               ELSE
                   DISPLAY 'VAR1 is not greater than VAR2'
               END-IF.
           
      * Looping Structure
               PERFORM VARYING WS-INDEX FROM 1 BY 1 UNTIL WS-INDEX > 5
                   DISPLAY 'Loop iteration: ' WS-INDEX
               END-PERFORM.
           
      * Comparison
               IF WS-VAR1 = WS-VAR2 THEN
                   DISPLAY 'VAR1 equals VAR2'
               END-IF.
           
      * Working with Indexed Data
               MOVE 10 TO WS-NUMBERS(1).
               MOVE 20 TO WS-NUMBERS(2).
               DISPLAY 'First number: ' WS-NUMBERS(1).
           
      * Using COMPUTE
               COMPUTE WS-RESULT = WS-VAR1 + WS-VAR2.
               DISPLAY 'Computed result: ' WS-RESULT.
           
      * CALL Statement
               MOVE 10 TO WS-VAR1
               MOVE 20 TO WS-VAR2
               CALL 'other' USING ARGS.
           
      * Using ACCEPT
               DISPLAY "Time to write a number (1-9999): "
               ACCEPT WS-VAR1 FROM CONSOLE.
               DISPLAY 'You entered: ' WS-VAR1.
           
      * File Handling (Pseudo code)
      *         OPEN INPUT SOMEFILE
      *         READ SOMEFILE
      *         CLOSE SOMEFILE
           
      * Handling Dates
        
               MOVE '20240211' TO WS-DATE.
           
               DISPLAY 'Date: ' WS-YEAR '/' WS-MONTH '/' WS-DAY.
           
      * Exiting the Program
               STOP RUN.
