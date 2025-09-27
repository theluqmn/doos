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
       DISPLAY "DOOS - the tool to get it done". DISPLAY " ".
       DISPLAY "run 'help' for the list of commands".
       PERFORM PROCEDURE-MAIN.
       CLI-HANDLER.
           DISPLAY "> " WITH NO ADVANCING.
           ACCEPT TP-STR-A.
           MOVE FUNCTION LOWER-CASE(TP-STR-A) TO CLI-INPUT.

           IF CLI-INPUT = "exit" THEN
               DISPLAY "[i] exiting..."
           ELSE IF CLI-INPUT = "setup" THEN
               PERFORM PROCEDURE-SETUP
           ELSE IF CLI-INPUT = "help" THEN
               PERFORM PROCEDURE-HELP
           ELSE IF CLI-INPUT = "add" THEN
               PERFORM PROCEDURE-ADD
           ELSE IF CLI-INPUT = "list" THEN
               PERFORM PROCEDURE-LIST
           ELSE IF CLI-INPUT = "done" THEN
               PERFORM PROCEDURE-COMPLETE
           ELSE IF CLI-INPUT = "update" THEN
               PERFORM PROCEDURE-RESCHEDULE
           ELSE
               DISPLAY "[!] unknown command entered"
           END-IF.
       PROCEDURE-PROCESSOR.
           OPEN I-O TASK-FILE
           PERFORM UNTIL FS-TASK NOT = '00'
               READ TASK-FILE NEXT
                   AT END MOVE '99' TO FS-TASK
               NOT AT END
                   IF TASK-STATUS NOT = 2 THEN
                       MOVE TASK-DATE TO TP-DATE
                       COMPUTE TP-NUM-A = FUNCTION
                       INTEGER-OF-DATE(TP-DATE)
                       COMPUTE TP-NUM-B = FUNCTION
                       INTEGER-OF-DATE(WS-CURRENT-DATE)
            
                       IF TP-NUM-A < TP-NUM-B THEN
                           MOVE 0 TO TASK-STATUS
                           REWRITE TASK-RECORD
                       ELSE
                           MOVE 1 TO TASK-STATUS
                           REWRITE TASK-RECORD
                       END-IF
                   END-IF
               END-READ
           END-PERFORM
           CLOSE TASK-FILE.
       PROCEDURE-HELP.
           DISPLAY
           "------------------------------------------------------".
           DISPLAY "HELP".
           DISPLAY "github: https://github.com/theluqmn/doos"
           DISPLAY " ". 
           DISPLAY "command:                   description:".
           DISPLAY " ".
           DISPLAY "[setup]                    setup doos".
           DISPLAY "[add]                      add a new task".
           DISPLAY "[list]                     view all tasks".
           DISPLAY "[done]                     mark a task as complete".
           DISPLAY "[update]                   reschedule a task".
           DISPLAY "-                          -".
           DISPLAY "[exit]                     exit the program".
           DISPLAY " ".
       PROCEDURE-SETUP.
           DISPLAY
           "------------------------------------------------------".
           DISPLAY "SETUP DOOS". DISPLAY " ".

           OPEN OUTPUT TASK-FILE.
           CLOSE TASK-FILE.

           DISPLAY "(1/1) task file created".
           DISPLAY "setup complete!".
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

           PERFORM PROCEDURE-PROCESSOR.

           DISPLAY " ".
           DISPLAY "task added successfully!".
       PROCEDURE-LIST.
           DISPLAY
           "------------------------------------------------------".
           DISPLAY "ALL TASKS". DISPLAY " ".

           PERFORM PROCEDURE-PROCESSOR.

           DISPLAY
           "| NUM      "
           "| TASK ID                          "
           "| DETAILS                          "
           "| DUE DATE   "
           "| STATUS   |"
           DISPLAY
           "|----------"
           "|----------------------------------"
           "|----------------------------------"
           "|------------"
           "|----------|"
           MOVE 0 TO COUNTER.
           OPEN INPUT TASK-FILE.
           PERFORM UNTIL FS-TASK NOT = '00'
               READ TASK-FILE NEXT
                   AT END MOVE '99' TO FS-TASK
               NOT AT END
                   ADD 1 TO COUNTER
                   DISPLAY "| "
                   COUNTER " | "
                   TASK-ID " | "
                   TASK-DETAILS " | " WITH NO ADVANCING
                   DISPLAY
                   TASK-DATE(1:4)"-"
                   TASK-DATE(5:2)"-"
                   TASK-DATE(7:2) " | " WITH NO ADVANCING
                   IF TASK-STATUS = 1 THEN
                       DISPLAY "UPCOMING |"
                   ELSE IF TASK-STATUS = 2 THEN
                       DISPLAY "COMPLETE |"
                   ELSE
                       DISPLAY "OVERDUE  |"
                   END-IF
               END-READ
           END-PERFORM
           CLOSE TASK-FILE.
           DISPLAY " ".
           DISPLAY "total tasks: " COUNTER.
       PROCEDURE-COMPLETE.
           DISPLAY
           "------------------------------------------------------".
           DISPLAY "MARK AS COMPLETE". DISPLAY " ".
           DISPLAY "task id:                   " WITH NO ADVANCING.
           ACCEPT TASK-ID.

           OPEN I-O TASK-FILE.
           READ TASK-FILE KEY IS TASK-ID
               INVALID KEY
                   DISPLAY "[!] task id is invalid"
               NOT INVALID KEY
                   MOVE 2 TO TASK-STATUS
                   REWRITE TASK-RECORD
                   DISPLAY "[i] item marked as complete!"
           END-READ.
           CLOSE TASK-FILE.

           DISPLAY " ".
       PROCEDURE-RESCHEDULE.
           DISPLAY
           "------------------------------------------------------".
           DISPLAY "RESCHEDULE A TASK". DISPLAY " ".

           DISPLAY "(1/2) task id:             " WITH NO ADVANCING.
           ACCEPT TASK-ID.

           DISPLAY "(2/2) due YYYY-MM-DD:      " WITH NO ADVANCING.
           ACCEPT TP-STR-A.
           MOVE TP-STR-A(1:4) TO TP-DATE(1:4).
           MOVE TP-STR-A(6:2) TO TP-DATE(5:2).
           MOVE TP-STR-A(9:2) TO TP-DATE(7:2).

           OPEN I-O TASK-FILE.
           READ TASK-FILE KEY IS TASK-ID
               INVALID KEY
                   DISPLAY "[!] invalid task id"
               NOT INVALID KEY
                   MOVE TP-DATE TO TASK-DATE
                   REWRITE TASK-RECORD
                   DISPLAY "[i] task rescheduled successfully!"
           END-READ
           CLOSE TASK-FILE.

           PERFORM PROCEDURE-PROCESSOR.

           DISPLAY " ".
       PROCEDURE-MAIN.
           PERFORM CLI-HANDLER UNTIL CLI-INPUT = "exit".
           STOP RUN.
       END PROGRAM DOOS.
