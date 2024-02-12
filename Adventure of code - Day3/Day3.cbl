
       IDENTIFICATION DIVISION.
       PROGRAM-ID. Day3.
       ENVIRONMENT DIVISION. 
       INPUT-OUTPUT SECTION. 
       FILE-CONTROL. 
            SELECT InputFile ASSIGN TO DISK 
             ORGANIZATION LINE SEQUENTIAL. 
       
       DATA DIVISION.
       FILE SECTION.
       FD InputFile 
           LABEL RECORDS ARE STANDARD
           VALUE OF FILE-ID IS "day3.txt".
           01 ws-data PIC X(200).

       WORKING-STORAGE SECTION.
           01 CurrentNumber PIC 9(10) VALUE 0.
           01 CurrentNumerLength PIC 9(10) VALUE 0.
           01 ws-sum PIC 9(10) VALUE 0.
           01 ws-start PIC 9(3) VALUE 0.
           01 ws-stop PIC 9(3) VALUE 0.
           01 FileStatus PIC X(2).
           01 EOF-Switch PIC 9 VALUE 0.
           01 ix PIC 9(5).
           01 ij PIC 9(5).
           01 cx PIC 9(5).
           01 cj PIC 9(5).
           01 Current-Number PIC 9(10) VALUE 0.
           01 Is-Number-Building-In-Progress PIC X(1) VALUE 'N'.
           01 Did-find-special-char PIC X(1) VALUE 'N'.
           
      * Buffer håller 3 rader som vi alltid jobbar med
           01 TAB1.
             02 Buf OCCURS 3 TIMES.
              05 BufLine PIC X(200) VALUE SPACE.

       PROCEDURE DIVISION.
           OPEN INPUT InputFile.

      * Börja med att  initiera våra tre rader
           INITIALIZE TAB1 

      * Läs en ny 
           PERFORM UNTIL EOF-Switch = 1
               READ InputFile
                   AT END
                        MOVE 1 TO EOF-Switch
                   NOT AT END
                       PERFORM Process-Line
               END-READ
           END-PERFORM.

      * Eftersom vi alltid jobbar med rad 2 så måste vi 
      * flytta in en dummy-rad i slutet och processera ytterligare 
      * en gång så att sista raden också kommer med

           PERFORM Process-Line.

           DISPLAY "Summan blir: " ws-sum.
           CLOSE InputFile.
           STOP RUN.
       
       PROCESS-LINE.

      * Rotera så vi alltid har senast inlästa i mitten Buf(2) 
      *     
      *      buf(1) . . . . 
      *      buf(2) . 2 3 . <-- Den här raden jobbar vi med
      *      buf(3) . # . .

           MOVE Buf(2) TO Buf(1)
           MOVE Buf(3) TO Buf(2)
           STRING " " ws-data " " DELIMITED BY SIZE INTO buf(3).

           PERFORM VARYING ix FROM 2 BY 1 UNTIL ix > LENGTH OF Buf(2)
      
      *     Här har vi hittat ett nummer.. så då fortsätter vi leta 
      *     siffra för siffra multiplicera med 10 för varje siffra :) 

             IF Buf(2)(ix:1) IS NUMERIC
                MOVE 'Y' TO Is-Number-Building-In-Progress
                COMPUTE Current-Number = (Current-Number * 10) + 
                       FUNCTION NUMVAL(Buf(2)(ix:1))
                ADD 1 to CurrentNumerLength
             ELSE
      
      *     Så nu har vi hittat slutet på ett tal.. anropa
      *     CHECK-SPECIAL-CHARACTERS för att ta leta efter icke-siffror

               IF Is-Number-Building-In-Progress = 'Y'
                   MOVE ix TO ws-start
                   SUBTRACT 1 from ws-start
                   MOVE ix TO ws-stop
                   SUBTRACT CurrentNumerLength FROM ws-start
                   
                   PERFORM CHECK-SPECIAL-CHARACTERS
                  
                   IF Did-find-special-char = 'Y'
                       ADD Current-Number TO ws-sum
                       MOVE 'N' TO Did-find-special-char
                   END-IF
                   
                   MOVE 'N' TO Is-Number-Building-In-Progress
                 
               END-IF
               MOVE ZERO TO Current-Number
               MOVE ZERO TO CurrentNumerLength
              END-IF
           END-PERFORM.

      *     Så letar vi runt om talet som vi nyss hittat 
      *     För att det ska bli enkelt så kollar vi även raderna där 
      *     talet ligger.. lite onödigt men slipper if-satser

       CHECK-SPECIAL-CHARACTERS. 
           MOVE 'N' TO Did-find-special-char
           PERFORM VARYING cx FROM 1 BY 1 UNTIL cx > 3
               PERFORM VARYING cj FROM ws-start BY 1 UNTIL cj > ws-stop
               IF (BUF(cx)(cj:1) IS NUMERIC 
                   OR BUF(cx)(cj:1) = ' '
                   OR BUF(cx)(cj:1) = '.')
                   CONTINUE 
               ELSE 
                   MOVE 'Y' TO Did-find-special-char
                   EXIT PERFORM
               END-IF
               END-PERFORM
           END-PERFORM
           .
        