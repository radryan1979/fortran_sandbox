So if using lowercase .f90 instead of .F90, then -cpp must be part of the compiler flags to enable the preprocessor.

In hello3, the -DCALC corresponds to the macro in hello.f90:
    #ifdef CALC
    ...
    #endif
When this is passed in via the compiler line as -DCALC it will compile that code

If the #define CALC is in the beginning of the code file, then it will be compiled
