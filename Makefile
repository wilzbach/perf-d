SHELL=/bin/bash

DMD_FLAGS=-inline -release -O -boundscheck=off
LDC_FLAGS=-release -O3 -boundscheck=off
GDC_FLAGS=-frelease -finline-functions -O3 -fbounds-check=off
LDC=ldc
DMD=dmd
GDC=gdc

bin/ldc/%: %.d | bin/ldc
	$(LDC) $(LDC_FLAGS) $< -of$@

bin/dmd/%: %.d | bin/dmd
	$(DMD) $(DMD_FLAGS) $< -of$@

bin/gdc/%: %.d | bin/gdc
	$(GDC) $(GDC_FLAGS) $< -o $@

test_%: test_%.d bin/ldc/test_% bin/dmd/test_% bin/gdc/test_%
	@echo ">dmd"
	@bin/dmd/$@
	@echo ">ldc"
	@bin/ldc/$@
	@echo ">gdc"
	@bin/gdc/$@

bin/%:
	mkdir -p $@

clean:
	rm -rf bin

 .SECONDARY:
