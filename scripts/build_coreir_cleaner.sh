COREIR_DIR=/GarnetFlow/scripts/coreir
BUFFERLIB_DIR=/GarnetFlow/scripts/BufferMapping
COREIR_LD_FLAGS="-L$COREIR_DIR/lib -Wl,-rpath,$COREIR_DIR/lib -lcoreir-commonlib -lcoreir -lcoreirsim -lcoreir-float -L$BUFFERLIB_DIR/cfunc/bin -lcoreir-lakelib"
#-Wl,-rpath $COREIR_DIR/lib

#rm -f coreir_cleaner
echo "Compiling..."
cmd="g++ coreir_interface_cleaner.cpp -I $BUFFERLIB_DIR/cfunc/include -I ./coreir/include/ $COREIR_LD_FLAGS -o coreir_cleaner"
echo "Cmd = $cmd"
eval $cmd
echo "done compiling..."
export LD_LIBRARY_PATH=/GarnetFlow/scripts/coreir/lib:/GarnetFlow/scripts/BufferMapping/cfunc/bin
./coreir_cleaner $1
