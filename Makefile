CF         = pgf90
FFLAGS     = -O2
LD         = pgf90
LDFLAGS    = 
PREPROC    = 

OBJS =  hashtbl.obj \
        test_hashtbl.obj \


.SUFFIXES: .obj .f90 .f
.f90.obj:
	$(LD) -c $(FFLAGS) $<
.f.obj:
	$(LD) -c $(FFLAGS) $<

hashtbl :$(OBJS) 
	$(LD) $(LDFLAGS) -o $@ $(OBJS)

clean :
	rm -f hashtbl *.obj *.mod *.pdb *.dwf