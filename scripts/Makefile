garnet_verilog:
	cd garnet && python garnet.py -v

pointwise:
	make -C Halide-to-Hardware/apps/hardware_benchmarks/apps/pointwise bin/design_top.json
	cp Halide-to-Hardware/apps/hardware_benchmarks/apps/pointwise/bin/design_top.json /tmp/pointwise.json
	cd garnet && python garnet.py --width 2 --height 2 --input-app /tmp/pointwise.json --interconnect-only
