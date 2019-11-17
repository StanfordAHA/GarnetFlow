HALIDE_DIR := /GarnetFlow/scripts/Halide-to-Hardware/apps/hardware_benchmarks
WIDTH ?= 12
HEIGHT ?= 12

APPS = pointwise gaussian cascade harris
TESTS = conv_1_2 conv_2_1 conv_3_3 ucomp scomp arith ushift uminmax rom absolute
BITSTREAM = $(APPS) $(TESTS)

# env variables for halide
export COREIR_DIR := /GarnetFlow/scripts/coreir
export OUTPUT_REDIRECTION := ""
export USE_CXX11_ABI := 0

.PHONY: $(BITSTREAM) garnet_verilog

garnet/garnet.v:
	cd garnet && python garnet.py -v --width $(WIDTH) --height $(HEIGHT) --interconnect-only 1> /dev/null

garnet_verilog: garnet/garnet.v

define make-test
# $1: $app
# $2: dir, either apps or tests
$1: $(addprefix /tmp/, $1.bs.out)

/tmp/$1.bs.out: garnet_verilog /tmp/$1.bs
	cd garnet && python tbg.py garnet.v garnet_stub.v $(addprefix /tmp/, $1.bs.json)

/tmp/$1.bs: $(addprefix /tmp/, $1.json)
	cd garnet && python garnet.py --width $(WIDTH) --height $(HEIGHT) --no-pd --input-app /tmp/$1.json \
		--interconnect-only --input-file /tmp/$1_input.raw --output-file /tmp/$1.bs --gold-file /tmp/$1_gold.raw && cd ..

/tmp/$1.json:
	@echo $(COREIR_DIR)
	@echo ${OUTPUT_REDIRECTION}
	@echo $(USR_CXX11_ABI)
	make -C $(HALIDE_DIR)/$2/$1 bin/design_top.json 1> /dev/null
	cd ./BufferMapping/script
	python coreir_gen.py $(HALIDE_DIR)/$2/$1/bin/design_top.json
	cp ./output/output_coreir.json $(HALIDE_DIR)/$2/$1/bin/design_top.json 
	cd ../..
	make -C $(HALIDE_DIR)/$2/$1 bin/input.raw && cp $(HALIDE_DIR)/$2/$1/bin/input.raw /tmp/$1_input.raw
	make -C $(HALIDE_DIR)/$2/$1 bin/output_cpu.raw && cp $(HALIDE_DIR)/$2/$1/bin/output_cpu.raw /tmp/$1_gold.raw
	cp $(HALIDE_DIR)/$2/$1/bin/design_top.json /tmp/$1.json
endef

$(foreach app, $(APPS), $(eval $(call make-test,$(app),apps)))
$(foreach app, $(TESTS), $(eval $(call make-test,$(app),tests)))

clean:
	rm -rf garnet/garnet.v garnet/garnet_stub.v garnet/garnet_stub.sv
	rm -rf garnet/temp/*
	rm -rf garnet/genesis*
