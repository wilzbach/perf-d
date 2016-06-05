SHELL=/bin/bash

DMD_FLAGS=-inline -release -O -boundscheck=off
LDC_FLAGS=-release -O3 -boundscheck=off
# if gcc > 6, you can try -fbounds-check=off
GDC_FLAGS=-finline-functions -frelease -O3
LDC=ldc
DMD=dmd
GDC=gdc

bin/dmd:
	mkdir -p $@

bin/gdc:
	mkdir -p $@

bin/ldc:
	mkdir -p $@

bin/ldc/%: %.d | bin/ldc
	$(LDC) $(LDC_FLAGS) $< -of$@

bin/dmd/%: %.d | bin/dmd
	$(DMD) $(DMD_FLAGS) $< -of$@

bin/gdc/%: %.d | bin/gdc
	$(GDC) $(GDC_FLAGS) $< -o $@

test_%: test_%.dmd test_%.ldc test_%.gdc
	@echo

test_%.dmd: bin/dmd/test_% test_%.d
	@echo ">dmd"
	@$<

test_%.ldc: bin/ldc/test_% test_%.d
	@echo ">ldc"
	@$<

test_%.gdc: bin/gdc/test_% test_%.d
	@echo ">gdc"
	@$<

TESTS=$(subst .d,,$(wildcard test_*.d))
all: $(TESTS)

clean:
	rm -rf bin

 .SECONDARY:
