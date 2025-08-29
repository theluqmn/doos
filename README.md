# doos

CLI-based to-do system

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

- `TASK(id INTEGER PRIMARY KEY (8), name TEXT (32), date TEXT (32), status INTEGER)`
- `LOG(num INTEGER PRIMARY KEY (8), details TEXT (32), date TEXT (32)`

## to-do

very ironic.

- [x] figure out how this system will work
- [x] build the basics (procedures, CLI handler)
- [x] setup procedure
- [x] figure out how dates work
- [x] add task into list
- [ ] list down all tasks
- [ ] mark task as done/complete
- [ ] sort based on date
- [ ] show overdue

## extras

the main objective of building this project is to learn and implement date and time in cobol, for my upcoming planned projects. i procrastinated a lot on working on this - unlike my other projects hehehee.

this project is licensed under the MIT license.
