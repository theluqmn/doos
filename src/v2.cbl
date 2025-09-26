       IDENTIFICATION DIVISION.
       PROGRAM-ID. DOOS.
       AUTHOR. theluqmn.

       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
       
       DATA DIVISION.
       WORKING-STORAGE SECTION.
      *logic variables
       01 CLI-INPUT                        PIC X(32).
       01 COUNTER                          PIC 9(8).
       01 WS-CURRENT-DATE                  PIC 9(8).
       01 WS-CURRENT-DATE-REDEF REDEFINES WS-CURRENT-DATE.
           05 WS-CURRENT-YEAR              PIC 9(4).
           05 WS-CURRENT-MONTH             PIC 9(2).
           05 WS-CURRENT-DAY               PIC 9(2).
      *temporary variables
       01 TEMPSTR-A                        PIC X(32).
       01 TEMPSTR-B                        PIC X(32).
       01 TEMPNUM-A                        PIC 9(8).
       01 TEMPNUM-B                        PIC 9(8).

       PROCEDURE DIVISION.
       ACCEPT WS-CURRENT-DATE FROM DATE YYYYMMDD.
       DISPLAY "DOOS - the tool to get it done".
       PERFORM PROCEDURE-MAIN.
       CLI-HANDLER.
           DISPLAY "> " WITH NO ADVANCING.
           ACCEPT TEMPSTR-A.
           MOVE FUNCTION LOWER-CASE(TEMPSTR-A) TO CLI-INPUT.

           IF CLI-INPUT = "exit" THEN
               DISPLAY "[i] exiting..."
           ELSE
               DISPLAY "[!] unknown command entered"
           END-IF.
       PROCEDURE-MAIN.
           PERFORM CLI-HANDLER UNTIL CLI-INPUT = "exit".
           STOP RUN.
       END PROGRAM DOOS.