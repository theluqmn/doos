<img width="1284" height="634" alt="doos" src="https://github.com/user-attachments/assets/b140b44c-627f-4453-8f9f-8d00292a8f37" />

## features

- add tasks with a deadline
- list all tasks, with its statuses (upcoming, overdue, complete)
- reschedule tasks to a new date
- mark tasks as complete
- all tasks are stored in a file (`tasks`)

## notes

- **do not leave any parameters empty** as it may cause errors (this project has minimal input validation to avoid overcomplication).
- this program only stores 32 character long texts. please keep this in mind when naming your **TASK-ID** and **DETAILS**. for numbers, only 8 digits are supported.
- when entering a date, please use the `YYYY-MM-DD` format. for example, if you would like to input 16th April 2009, enter it as `2009-04-16`.
- the main console (when entering commands, with the following `>` visible) is not case sensitive, but other inputs are.

## to-do

> [!NOTE]
> this project is already considered complete.

- [x] cobol setup
- [x] cli-handler
- [x] setup procedure
- [x] add task
- [x] process tasks (overdue, upcoming)
- [x] list tasks
- [x] mark task as complete
- [x] reschedule task
- [x] delete tasks
- [x] add colours
- [x] purge (delete all completed tasks)
- [ ] sort listing of tasks based on due date
- [ ] overview
- [ ] show top 5 upcoming tasks
- [x] help

## extras

the primary objective of this project is to allow me to learn and implement date and time in a functionally-working cobol project. this project was originally started over a month prior to allowing public access to the repository - a lot of procrastination went into this project. i abandoned it for more than 4 weeks, and when i finally went back in (to finish my debt), i had forgotten how the code works therefore i needed a fresh restart (aka v2).

this project is licensed under the [MIT license](https://github.com/theluqmn/doos/blob/main/LICENSE).
