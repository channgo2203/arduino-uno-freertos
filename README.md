# FreeRTOS for Arduino Uno with CMake

#### Author: Van C. Ngo (vchngo@gmail.com)
#### Date: October 15, 2019

## Introduction

Each real time kernel port consists of three files that contain the core kernel
components and are common to every port, and one or more files that are 
specific to a particular micro-controller and or compiler.

1. The `include` directory contains the headers that are included by source files 
in `src` and `src/portable` directories.

2. The `src` directory contains the three files that are common to every port:
    1. `list.c`
    2. `queue.c`
    3. `tasks.c`

    The kernel is contained within these three files. The source file `croutine.c` implements the optional co-routine functionality - which is normally only used on very memory limited systems.

3. The `src/portable` directory contains the files that are specific to a particular micro-controller and or compiler.

4. The source file `src/main.c` is the actual user code.

## How to Build

Go somewhere preferably _outside_ of the source tree and create a folder for the build:

```
mkdir build && cd build
```

To build for `Atmega328p`, you just need to run:

```
cmake <repo_directory> -DCMAKE_TOOLCHAIN_FILE=<repo_directory>/cmake/avr-atmega328p.cmake
```

If you prefer to use [Ninja](https://ninja-build.org/) as your build system, remember to pass `-G Ninja` to `cmake` such as:
```
cmake <repo_directory> -G Ninja -DCMAKE_TOOLCHAIN_FILE=<repo_directory>/cmake/avr-atmega328p.cmake
```

You can now build the project:

```
cmake --build . [-- -jN]
```

## How to Flash

To flash the compiled binary, run the following commands:

```
# Go to <repo_directory>/scripts
cd <repo_directory>/scripts
# Run the script
./arduino-install.sh -f <binary_file_with_path> -b <board_name> -p <serial_port>
```