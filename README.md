# C Boilerplate for Library

A C boilerplate project to build a C based library.

## System Requirements

* C compiler (Clang or GCC)
* GNU Make (for compilation only)

## Usage

Clone the project:

```
$ git clone https://github.com/cwchentw/c-boilerplate-library.git mylib
```

Move your working directory to the root of *mylib*:

```
$ cd mylib
```

Modify the header and the source as needed. You may add and remove C source files (*.c*) as well.

Compile the project to a dynamic library:

```
$ make
```

Alternatively, compile the project to a static library:

```
$ make static
```

Set your own remote repository:

```
$ git remote set-url origin https://example.com/user/project.git
```

Push your modification to your own repo:

```
$ git push
```

## Project Configuration

Here are the parameters in *Makefile*:

* **LIBRARY**: the name of the compiled library, including *lib* the prefix
* **C_STD**: the C standard as a GCC C dialect

## Note

The project assumes a Unix console environment. Windows users can install [MSYS2](https://www.msys2.org/) to obtain a decent Unix environment.

Because seldom Visual C++ users compile programs with Make, we don't include the compiler in the project.

## Copyright

Copyright (c) 2020 Michelle Chen. Licensed under MIT.