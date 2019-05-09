HALIDE_DIR := /GarnetFlow/Halide-to-Hardware/apps/hardware_benchmarks

APPS = pointwise gaussian
TESTS = conv_1_2

garnet_verilog:
	cd garnet && python garnet.py -v 1> /dev/null

$(TESTS):
	make -C $(HALIDE_DIR)/tests/$@ bin/design_top.json 1> /dev/null
	make -C $(HALIDE_DIR)/tests/$@ bin/input.raw && cp $(HALIDE_DIR)/tests/$@/bin/input.raw /tmp/$@_input.raw
	make -C $(HALIDE_DIR)/tests/$@ bin/output_cpu.raw && cp $(HALIDE_DIR)/tests/$@/bin/output_cpu.raw /tmp/$@_gold.raw
	cp $(HALIDE_DIR)/tests/$@/bin/design_top.json /tmp/$@.json
	cd garnet && python garnet.py --width 8 --height 8 --input-app /tmp/$@.json \
		--interconnect-only --input-file /tmp/$@_input.raw --output-file /tmp/$@.bs --gold-file /tmp/$@_gold.raw

$(APPS):
	make -C $(HALIDE_DIR)/apps/$@ bin/design_top.json 1> /dev/null
	cp $(HALIDE_DIR)/apps/$@/bin/design_top.json /tmp/$@.json
	cd garnet && python garnet.py --width 12 --height 12 --input-app /tmp/$@.json --interconnect-only
