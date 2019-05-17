HALIDE_DIR := /GarnetFlow/scripts/Halide-to-Hardware/apps/hardware_benchmarks
WIDTH ?= 12
HEIGHT ?= 12

APPS = pointwise gaussian cascade
TESTS = conv_1_2 conv_2_1 conv_3_3 ucomp

garnet/garnet.v:
	cd garnet && python garnet.py -v --width $(WIDTH) --height $(HEIGHT) --interconnect-only 1> /dev/null

garnet_verilog: garnet/garnet.v

$(TESTS): garnet_verilog
	make -C $(HALIDE_DIR)/tests/$@ bin/design_top.json 1> /dev/null
	make -C $(HALIDE_DIR)/tests/$@ bin/input.raw && cp $(HALIDE_DIR)/tests/$@/bin/input.raw /tmp/$@_input.raw
	make -C $(HALIDE_DIR)/tests/$@ bin/output_cpu.raw && cp $(HALIDE_DIR)/tests/$@/bin/output_cpu.raw /tmp/$@_gold.raw
	cp $(HALIDE_DIR)/tests/$@/bin/design_top.json /tmp/$@.json
	cd garnet && python garnet.py --width $(WIDTH) --height $(HEIGHT) --no-pd --input-app /tmp/$@.json \
		--interconnect-only --input-file /tmp/$@_input.raw --output-file /tmp/$@.bs --gold-file /tmp/$@_gold.raw && cd ..
	cd garnet && python tbg.py garnet.v garnet_stub.v /tmp/$@.bs.json

$(APPS): garnet_verilog
	make -C $(HALIDE_DIR)/apps/$@ bin/design_top.json 1> /dev/null
	cp $(HALIDE_DIR)/apps/$@/bin/design_top.json /tmp/$@.json
	make -C $(HALIDE_DIR)/apps/$@ bin/input.raw && cp $(HALIDE_DIR)/apps/$@/bin/input.raw /tmp/$@_input.raw
	make -C $(HALIDE_DIR)/apps/$@ bin/output_cpu.raw && cp $(HALIDE_DIR)/apps/$@/bin/output_cpu.raw /tmp/$@_gold.raw
	cd garnet && python garnet.py --width $(WIDTH) --height $(HEIGHT) --input-app /tmp/$@.json \
		--interconnect-only --no-pd --input-file /tmp/$@_input.raw --output-file /tmp/$@.bs --gold-file /tmp/$@_gold.raw
	cd garnet && python tbg.py garnet.v garnet_stub.v /tmp/$@.bs.json
