tsunami: tsunami.F90
	gfortran -cpp $^ -o $@

hello: hello.f90
	gfortran hello.f90 -o hello.exe
	# note the difference where here we exclusively define the output file name
	# but in hello2 we do not and thus it simply is just hello2 with no
	# file extension

hello2: hello.f90
	gfortran -cpp $^ -o $@
	# the $^ all the file names in the prereqs
	# the $@  is the filename representing the target, aka hello2

# Notice the dependency is libmath_utils.a
# using the linking and target is listed as
# libmath_utils.a
hello3: hello.f90 libmath_utils.a
	gfortran -cpp -DCALC -L. -lmath_utils $^ -o $@

# Makes a library - first compile only to object
# Then ar (archive) builds static library from .o files
# r replace, c create, s index symbol table
libmath_utils.a: math_utils.F90
	gfortran -c math_utils.F90
	ar rcs libmath_utils.a math_utils.o

.PHONY: clean
clean:
	rm -f *.o
	rm -f *.exe
	rm -f hello
	rm -f hello2
	rm -f tsunami
	rm -f math_utils.mod
	rm -f math_utils.o
	rm -f libmath_utils.a

	