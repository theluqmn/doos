# doos

CLI-based to-do system

**doos** is a to-do list management software powered by cobol and the supreme command line.

## features

> [!NOTE]
> this project is a work-in-progress.

- add tasks, with deadlines

## how to use

> [!WARNING]
> the release only offers an executable compiled for Ubuntu. if you are not on the same distro or operating system, please refer to the [compiling it yourself](#compiling-it-yourself) guide.

1. go to [releases](https://github.com/theluqmn/doos/releases/latest), download the latest release.
2. navigate to the directory of the executable and simply run `./main`.

### compiling it yourself

the following are the steps for Ubuntu.

1. install `gnucobol` using your package manager (download gnucobol).
2. clone this repository.
3. run `cobc src/main.cbl` in the project directory.
4. run `./main` to run the program.

## how this works

it is a very simple, straightforward to-do list system. create tasks, which you mark as complete once you did it. doos also shows you tasks are due soon, and overdue (if there is any).

### file system design

- `TASK(TASK-ID PRIMARY KEY TEXT(32), TASK-DETAILS TEXT(32), TASK-DATE TEXT(8), TASK-STATUS TEXT(1))`

## to-do

very ironic.

sorted by importance (top-bottom):

- [x] cobol setup
- [x] cli-handler
- [x] setup procedure
- [x] add task
- [ ] list tasks
- [ ] process tasks (overdue, upcoming)
- [ ] mark task as complete
- [ ] reschedule task
- [ ] remove tasks
- [ ] sort listing of tasks based on due date
- [ ] overview
- [ ] show top 5 upcoming tasks

## extras

the main objective of building this project is to learn and implement date and time in cobol, for my upcoming planned projects. i procrastinated a lot on working on this - unlike my other projects hehehee.

this project is licensed under the MIT license.
