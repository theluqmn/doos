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
           05 TASK-ID                      PIC X(16).
           05 TASK-NAME                    PIC X(32).
           05 TASK-DATE                    PIC X(8).
           05 TASK-STATUS                  PIC X.
       WORKING-STORAGE SECTION.
      *logic variables
       01 CLI-INPUT                        PIC X(32).
       01 COUNTER                          PIC 9(8).
       01 WS-DATE                          PIC 9(8).
       01 WS-CURRENT-DATE                  PIC 9(8).
       01 WS-CURRENT-DATE-REDEF REDEFINES WS-CURRENT-DATE.
           05 WS-CURRENT-YEAR              PIC 9(4).
           05 WS-CURRENT-MONTH             PIC 9(2).
           05 WS-CURRENT-DAY               PIC 9(2).
      *file status variables
       01 FS-TASK                          PIC XX.
      *temporary str variables
       01 TEMPSTR-A                        PIC X(32).
       01 TEMPSTR-B                        PIC X(32).
      *temporary number variables
       01 TEMPNUM-A                        PIC 9(8).
       01 TEMPNUM-B                        PIC 9(8).
       01 TEMPNUM-C                        PIC 9(8).
      *temporary date variables
      01 TP-DATE-A                         PIC 9(8).
      01 TP-DATE-A-REDEF REDEFINES TP-DATE-A.
           05 TP-DATE-A-YEAR               PIC 9(4).
           05 TP-DATE-A-MONTH              PIC 9(2).
           05 TP-DATE-A-DAY                PIC 9(2).

       PROCEDURE DIVISION.
       ACCEPT WS-CURRENT-DATE FROM DATE YYYYMMDD.
       DISPLAY "DOOS - the tool to get it done".
       DISPLAY " ".
       PERFORM PROCEDURE-MAIN.
       CLI-HANDLER.
           DISPLAY "---------------------------------------------".
           DISPLAY "> " WITH NO ADVANCING.
           ACCEPT TEMPSTR-A.
           MOVE FUNCTION LOWER-CASE(TEMPSTR-A) TO CLI-INPUT.

           IF CLI-INPUT = "setup" THEN
               PERFORM PROCEDURE-SETUP
           ELSE IF CLI-INPUT = "exit" THEN
               DISPLAY "exiting..."
           ELSE IF CLI-INPUT = "help" THEN
               PERFORM PROCEDURE-HELP
           ELSE IF CLI-INPUT = "add" THEN
               PERFORM PROCEDURE-ADD
           ELSE IF CLI-INPUT = "list" THEN
               PERFORM PROCEDURE-LIST
           ELSE IF CLI-INPUT = "done" THEN
               PERFORM PROCEDURE-DONE
           ELSE
               DISPLAY "unknown command entered"
           END-IF.
       PROCEDURE-SETUP.
           DISPLAY "---------------------------------------------".
           DISPLAY "SETUP DOOS".
           DISPLAY " ".

           OPEN OUTPUT TASK-FILE.
           CLOSE TASK-FILE.
           DISPLAY "(1/1) task file created".

           DISPLAY "setup complete".
       PROCEDURE-HELP.
           DISPLAY "---------------------------------------------".
           DISPLAY "HELP WITH DOOS".
           DISPLAY "github: https://github.com/theluqmn/doos".
           DISPLAY " ".
           DISPLAY "available commands:".
           DISPLAY "-".
           DISPLAY "[setup]            setup doos".
           DISPLAY "[exit]             exit doos".
       PROCEDURE-ADD.
           DISPLAY "---------------------------------------------".
           DISPLAY "ADD A NEW TASK".
           DISPLAY " ".
           DISPLAY "note: please format date as yyyy-mm-dd."
           DISPLAY " ".
           DISPLAY "(1/3) id:          " WITH NO ADVANCING.
           ACCEPT TASK-ID.
           DISPLAY "(2/3) details:     " WITH NO ADVANCING.
           ACCEPT TASK-NAME.
           DISPLAY "(3/3) due:         " WITH NO ADVANCING.
           ACCEPT TEMPSTR-B.
           MOVE TEMPSTR-B(1:4) TO WS-DATE(1:4).
           MOVE TEMPSTR-B(6:2) TO WS-DATE(5:2).
           MOVE TEMPSTR-B(9:2) TO WS-DATE(7:2).
           MOVE WS-DATE TO TASK-DATE.
           MOVE 0 TO TASK-STATUS.

           OPEN I-O TASK-FILE.
           WRITE TASK-RECORD.
           CLOSE TASK-FILE.

           DISPLAY " ".
           DISPLAY "task added successfully".
       PROCEDURE-LIST.
           DISPLAY "---------------------------------------------".
           DISPLAY "ALL TASKS".
           DISPLAY " ".

           DISPLAY
           "NUM     |"
           "ID              |"
           "NAME                            |"
           "DATE      |"
           "STATUS   |".
           DISPLAY
           "--------|"
           "----------------|"
           "--------------------------------|"
           "----------|"
           "---------|".
           MOVE 0 TO COUNTER.
           OPEN INPUT TASK-FILE
           PERFORM UNTIL FS-TASK NOT = '00'
               READ TASK-FILE NEXT
                   AT END MOVE '99' TO FS-TASK
               NOT AT END
                   ADD 1 TO COUNTER
                   DISPLAY
                   COUNTER "|"
                   TASK-ID "|"
                   TASK-NAME "|" WITH NO ADVANCING
                   DISPLAY
                   TASK-DATE(1:4)"-"
                   TASK-DATE(5:2)"-"
                   TASK-DATE(7:2) "|" WITH NO ADVANCING
                   IF TASK-STATUS = 0 THEN
                       DISPLAY "UPCOMING | "
                   ELSE IF TASK-STATUS = 2 THEN
                   END-IF
               END-READ
           END-PERFORM
           CLOSE TASK-FILE.
           DISPLAY " ".
       PROCEDURE-DONE.
           DISPLAY "---------------------------------------------".
           DISPLAY "task id:           " WITH NO ADVANCING.
           ACCEPT TASK-ID.

       PROCEDURE-MAIN.
           PERFORM CLI-HANDLER UNTIL CLI-INPUT = "exit".
           STOP RUN.
       END PROGRAM DOOS.
       