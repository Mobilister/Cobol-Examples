           IDENTIFICATION DIVISION.
           PROGRAM-ID. other.
           
           ENVIRONMENT DIVISION.
           DATA DIVISION.
           FILE SECTION.
           
           WORKING-STORAGE SECTION.

           LINKAGE SECTION.
               01 ARGS.
               02 ARG-1 PIC 9(4) VALUE 0.
               02 ARG-2 PIC 9(4) VALUE 0.
           
           PROCEDURE DIVISION USING ARGS.
               DISPLAY 'Other program called - with ' ARG-1
               DISPLAY 'And with ' ARG-2
               EXIT PROGRAM. 
