# gfortran simple_xy_rd.f90 -o simple_xy_rd `nf-config --fflags --flibs`

xy_read: simple_xy_rd.f90
	gfortran -cpp $^ -o $@ `nf-config --fflags --flibs`

xy_write: simple_xy_wr.f90
	gfortran -cpp $^ -o $@ `nf-config --fflags --flibs`

.PHONY: clean
clean:
	rm -f *.o
	rm -f *.exe
	rm -f simple_xy_rd
	rm -f simple_xy_wr