# Cobol-Examples

Some very basic COBOL examples using GNUCobol 

## Install:

```
Brew install cobc
```

## How to compile: 

#### Don't know if this is needed.. to setup the ENV-variable for the compiler 
```
export COB_LIBRARY_PATH=/Users/[USER-NAME]/cobolfiles
```

#### Compile module with dynamic linkage (dynlib)
```
cobc -m -o other other.cob
```

#### Compile main module
```
cobc -x -o mainpgm mainpgm.cob
```

## Run
```
./cobol
```
