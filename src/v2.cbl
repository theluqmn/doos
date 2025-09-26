       IDENTIFICATION DIVISION.
       PROGRAM-ID. DOOS.
       AUTHOR. theluqmn.

       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           SELECT TASK-FILE ASSIGN TO "tasks"
               ORGANIZATION IS INDEXED
               ACCESS IS DYNAMIC
               RECORD KEY IS TASK-ID
               FILE STATUS IS FS-TASK.
       
       DATA DIVISION.
       FILE SECTION.
       FD TASK-FILE.
       01 TASK-RECORD.
           05 TASK-ID                          PIC X(32).
           05 TASK-DETAILS                     PIC X(32).
           05 TASK-DATE                        PIC X(8).
           05 TASK-STATUS                      PIC X.
       WORKING-STORAGE SECTION.
      *logic variables
       01 CLI-INPUT                            PIC X(32).
       01 COUNTER                              PIC 9(8).
       01 WS-CURRENT-DATE                      PIC 9(8).
       01 WS-CURRENT-DATE-REDEF REDEFINES WS-CURRENT-DATE.
           05 WS-CURRENT-YEAR                  PIC 9(4).
           05 WS-CURRENT-MONTH                 PIC 9(2).
           05 WS-CURRENT-DAY                   PIC 9(2).
      *status variables
       01 FS-TASK                              PIC XX.
      *temporary variables
       01 TP-STR-A                             PIC X(32).
       01 TP-STR-B                             PIC X(32).
       01 TP-STR-C                             PIC X(32).
       01 TP-NUM-A                             PIC 9(8).
       01 TP-NUM-B                             PIC 9(8).
       01 TP-NUM-C                             PIC 9(8).
       01 TP-DATE                              PIC 9(8).
       01 TP-DATE-REDEF REDEFINES TP-DATE.
           05 TP-DATE-YEAR                     PIC 9(4).
           05 TP-DATE-MONTH                    PIC 9(2).
           05 TP-DATE-DAY                      PIC 9(2).

       PROCEDURE DIVISION.
       ACCEPT WS-CURRENT-DATE FROM DATE YYYYMMDD.
       DISPLAY "DOOS - the tool to get it done".
       PERFORM PROCEDURE-MAIN.
       CLI-HANDLER.
           DISPLAY "> " WITH NO ADVANCING.
           ACCEPT TP-STR-A.
           MOVE FUNCTION LOWER-CASE(TP-STR-A) TO CLI-INPUT.

           IF CLI-INPUT = "exit" THEN
               DISPLAY "[i] exiting..."
           ELSE IF CLI-INPUT = "add" THEN
               PERFORM PROCEDURE-ADD
           ELSE
               DISPLAY "[!] unknown command entered"
           END-IF.
       PROCEDURE-ADD.
           DISPLAY
           "------------------------------------------------------".
           DISPLAY "ADD A NEW TASK". DISPLAY " ".
           DISPLAY "(1/3) id:                  " WITH NO ADVANCING.
           ACCEPT TASK-ID.

           DISPLAY "(2/3) details:             " WITH NO ADVANCING.
           ACCEPT TASK-DETAILS.
           
           DISPLAY "(3/3) due YYYY-MM-DD:      " WITH NO ADVANCING.
           ACCEPT TP-STR-A.
           MOVE TP-STR-A(1:4) TO TP-DATE(1:4).
           MOVE TP-STR-A(6:2) TO TP-DATE(5:2).
           MOVE TP-STR-A(9:2) TO TP-DATE(7:2).
           MOVE TP-DATE TO TASK-DATE.

           OPEN I-O TASK-FILE.
           WRITE TASK-RECORD.
           CLOSE TASK-FILE.

           DISPLAY " ".
           DISPLAY "task added successfully!".
       PROCEDURE-MAIN.
           PERFORM CLI-HANDLER UNTIL CLI-INPUT = "exit".
           STOP RUN.
       END PROGRAM DOOS.
