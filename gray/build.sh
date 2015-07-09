#!/bin/sh

rm -rf AXIHP_GRAY_v1_0/

java -cp $SYNTHESIJER:$SYNTHESIJER_APP/bin:. \
synthesijer.Main \
--ip-exact=AXIHP_GRAY \
AXIHP_GRAY.java \
$SYNTHESIJER_APP/src/synthesijer/lib/axi/AXILiteSlave32RTL.java \
$SYNTHESIJER_APP/src/synthesijer/lib/axi/SimpleAXIMemIface32RTL.java \
$SYNTHESIJER_APP/src/synthesijer/lib/axi/SimpleAXIMemIface32RTLTest.java

cp $SYNTHESIJER_APP/hdl/vhdl/axi_lite_slave_32.vhd AXIHP_GRAY_v1_0/src/
cp $SYNTHESIJER_LIB/vhdl/dualportram.vhd AXIHP_GRAY_v1_0/src/
cp synthesijer_lib_axi_SimpleAXIMemIface32RTLTest.vhd AXIHP_GRAY_v1_0/src/
cp $SYNTHESIJER_APP/hdl/vhdl/simple_axi_memiface_32.vhd AXIHP_GRAY_v1_0/src/
cp AXIHP_GRAY.vhd AXIHP_GRAY_v1_0/src/


