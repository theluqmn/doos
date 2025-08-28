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
           
       DATA DIVISION.
       FILE SECTION.
       FD TASK-FILE.
       01 TASK-RECORD.
           05 TASK-ID          PIC X(8).
           05 TASK-NAME        PIC X(32).
           05 TASK-DATE        PIC X(32).
           05 TASK-STATUS      PIC X.
       WORKING-STORAGE SECTION.
      *file status variables
       01 FS-TASK              PIC XX.

       PROCEDURE DIVISION.
       DISPLAY "halu world".
       END PROGRAM DOOS.