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
           05 TASK-ID          PIC X(8).
           05 TASK-NAME        PIC X(32).
           05 TASK-DATE        PIC X(32).
           05 TASK-STATUS      PIC X.
       WORKING-STORAGE SECTION.
      *logic variables
       01 CLI-INPUT            PIC X(32).
      *file status variables
       01 FS-TASK              PIC XX.
      *temporary str variables
       01 TEMPSTR-A            PIC X(32).

       PROCEDURE DIVISION.
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
           DISPLAY "(1/2) name:        " WITH NO ADVANCING.
           ACCEPT TEMPSTR-A.

       PROCEDURE-MAIN.
           PERFORM CLI-HANDLER UNTIL CLI-INPUT = "exit".
           STOP RUN.
       END PROGRAM DOOS.
       