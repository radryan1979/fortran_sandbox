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

hello3: hello.f90
	gfortran -cpp -DCALC $^ -o $@

.PHONY: clean
clean:
	rm -f *.o
	rm -f *.exe
	rm -f hello
	rm -f hello2
	rm -f tsunami
	