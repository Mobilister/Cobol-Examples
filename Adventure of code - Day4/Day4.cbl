
       IDENTIFICATION DIVISION.
       PROGRAM-ID. Day4.
       ENVIRONMENT DIVISION. 
       INPUT-OUTPUT SECTION. 
       FILE-CONTROL. 
            SELECT InputFile ASSIGN TO DISK 
             ORGANIZATION LINE SEQUENTIAL. 
       
       DATA DIVISION.
       FILE SECTION.
       FD InputFile 
           LABEL RECORDS ARE STANDARD
           VALUE OF FILE-ID IS "day4.txt".
           01 ws-data PIC X(200).

       WORKING-STORAGE SECTION.
           01 CurrentNumber PIC 9(10) VALUE 0.
           01 CurrentNumerLength PIC 9(10) VALUE 0.
           01 ws-sum PIC 9(10) VALUE 0.
           
           01 ws-tot-sum PIC 9(10) VALUE 0.
           01 ws-nr-of-matches PIC 9(3) VALUE 0.
           01 EOF-Switch PIC 9 VALUE 0.
           01 ix PIC 9(5).
           01 ij PIC 9(5).
           01 cx PIC 9(5).
           01 cj PIC 9(5).
           01 startPos PIC 9(5).
           01 startMatching PIC X VALUE 'N'.
   

       PROCEDURE DIVISION.
           OPEN INPUT InputFile.

           MOVE 0 TO ws-tot-sum
           MOVE 10 TO startPos 
           PERFORM UNTIL EOF-Switch = 1
               READ InputFile
                   AT END
                        MOVE 1 TO EOF-Switch
                   NOT AT END
                       PERFORM Process-Line
                     
               END-READ
           END-PERFORM.

           DISPLAY ws-tot-sum

           CLOSE InputFile.
           STOP RUN.

           Process-Line.
           MOVE 0 TO ws-sum
           MOVE 0 to ws-nr-of-matches
           PERFORM VARYING ix FROM 7 BY 3
                   UNTIL ws-data(ix:3) = ' | ' 
               PERFORM VARYING cx FROM startPos BY 3
                 UNTIL cx > LENGTH OF ws-data 
                 IF startMatching = 'Y'
                   IF NUMERIC(ws-data(ix:3)) = 
                      NUMERIC(ws-data(cx:3))
                      ADD 1 TO ws-nr-of-matches
                   END-IF 
                 ELSE 
                   IF startMatching = 'N' AND ws-data(cx:3) = ' | ' 
                      MOVE 'Y' TO startMatching
                      MOVE cx TO startPos
                      ADD 2 TO startPos
                      DISPLAY "Start pos "  startPos
                   END-IF
                 END-IF
               END-PERFORM
           END-PERFORM
           
           
           IF ws-nr-of-matches > 0
             COMPUTE ws-sum = 2 ** (ws-nr-of-matches - 1)
           END-IF    
           
           ADD ws-sum TO ws-tot-sum
           
           
           MOVE ZERO TO ws-nr-of-matches
           .
