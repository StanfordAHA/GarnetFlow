COREIR_DIR=/GarnetFlow/scripts/coreir
COREIR_LD_FLAGS="-L$COREIR_DIR/lib -Wl,-rpath,$COREIR_DIR/lib -lcoreir-commonlib -lcoreir -lcoreirsim -lcoreir-float"
#-Wl,-rpath $COREIR_DIR/lib

rm -f coreir_cleaner
echo "Compiling..."
g++ coreir_interface_cleaner.cpp -I ./coreir/include/ $COREIR_LD_FLAGS -o coreir_cleaner
echo "done compiling..."
export LD_LIBRARY_PATH=/GarnetFlow/scripts/coreir/lib
./coreir_cleaner
