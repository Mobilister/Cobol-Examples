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
       01 WS-NUMBERS OCCURS 10 TIMES PIC 9(4).

       01 WS-DATE.
          05 WS-YEAR PIC 9(4).
          05 WS-MONTH PIC 9(2).
          05 WS-DAY PIC 9(2).

       01 WS-INDEX PIC 9(4).
       01 WS-SEARCH-VALUE PIC 9(4) VALUE 15.
       01 WS-FOUND PIC X VALUE 'N'.

       01 WS-REDEFINE-EXAMPLE.
          05 WS-NUMERIC-VALUE PIC 9(4) VALUE 1234.
          05 WS-ALPHANUMERIC-REDEF REDEFINES WS-NUMERIC-VALUE PIC X(4).

       PROCEDURE DIVISION.
           DISPLAY 'COBOL Demo Program'

      * Arithmetic Operations
           ADD 100 TO WS-VAR1
           SUBTRACT 50 FROM WS-VAR1
           MULTIPLY WS-VAR1 BY 2 GIVING WS-RESULT
           DIVIDE WS-VAR1 BY 2 GIVING WS-RESULT

           DISPLAY 'Result of arithmetic operations: ' WS-RESULT

      * String Manipulation
           MOVE WS-TEXT1 TO WS-COMBINED-TEXT
           STRING WS-TEXT1 DELIMITED BY SIZE ' ' WS-TEXT2 
           DELIMITED BY SIZE
               INTO WS-COMBINED-TEXT
           DISPLAY 'Combined Text: ' WS-COMBINED-TEXT

      * Conditional Statements
           IF WS-VAR1 > WS-VAR2 THEN
               DISPLAY 'VAR1 is greater than VAR2'
           ELSE
               DISPLAY 'VAR1 is not greater than VAR2'
           END-IF

      * Looping Structure
           PERFORM VARYING WS-INDEX FROM 1 BY 1 UNTIL WS-INDEX > 10
               DISPLAY 'Loop iteration: ' WS-INDEX
               COMPUTE WS-NUMBERS(WS-INDEX) = WS-INDEX * 10
           END-PERFORM

      * Comparison
           IF WS-VAR1 = WS-VAR2 THEN
               DISPLAY 'VAR1 equals VAR2'
           END-IF

      * Working with Indexed Data
           MOVE 10 TO WS-NUMBERS(1)
           MOVE 20 TO WS-NUMBERS(2)
           DISPLAY 'First number: ' WS-NUMBERS(1)

      * Using COMPUTE
           COMPUTE WS-RESULT = WS-VAR1 + WS-VAR2
           DISPLAY 'Computed result: ' WS-RESULT

      * Redefines Example
           DISPLAY 'Before REDEFINES: ' WS-NUMERIC-VALUE
           MOVE 'ABCD' TO WS-ALPHANUMERIC-REDEF
           DISPLAY 'After REDEFINES: ' WS-ALPHANUMERIC-REDEF

      * Using PERFORM...THRU
           PERFORM 100-PERFORM-ROUTINE THRU 104-PERFORM-ROUTINE

      * Searching in an Array
           PERFORM VARYING WS-INDEX FROM 1 BY 1 
                   UNTIL WS-INDEX > 10 OR WS-FOUND = 'Y'
               IF WS-NUMBERS(WS-INDEX) = WS-SEARCH-VALUE THEN
                   DISPLAY 'Value found at position: ' WS-INDEX
                   MOVE 'Y' TO WS-FOUND
               END-IF
           END-PERFORM
           IF WS-FOUND = 'N' THEN
               DISPLAY 'Value not found'
           END-IF

      * CALL Statement
           MOVE 10 TO WS-VAR1
           MOVE 20 TO WS-VAR2
           CALL 'other' USING ARGS

      * Using ACCEPT
           DISPLAY "Time to write a number (1-9999): "
           ACCEPT WS-VAR1 FROM CONSOLE.
           DISPLAY 'You entered: ' WS-VAR1.
        
      * Display a date 
           MOVE '20240211' TO WS-DATE.
           DISPLAY 'Date: ' WS-YEAR '/' WS-MONTH '/' WS-DAY.

      * Sub-procedures
           100-PERFORM-ROUTINE.
           DISPLAY 'Performing routine 100'.
           101-PERFORM-ROUTINE.
           DISPLAY 'Performing routine 101'.
           102-PERFORM-ROUTINE.
           DISPLAY 'Performing routine 102'.
           103-PERFORM-ROUTINE.
           DISPLAY 'Performing routine 103'.
           104-PERFORM-ROUTINE.
           DISPLAY 'Performing routine 104'.
           EXIT.

           200-INTERNAL-PROCEDURE.
           DISPLAY 'This is an internal procedure'.
           EXIT.
           
      * Exiting the Program
           STOP RUN.

