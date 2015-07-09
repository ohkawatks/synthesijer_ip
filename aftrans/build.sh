#!/bin/sh

target=AXIHP_AFTRANS
ipname=AXIHP_AFTRANS_v1_0

rm -rf $ipname/
rm *.dot *.txt

java -cp $SYNTHESIJER:$SYNTHESIJER_APP/bin:. \
synthesijer.Main \
--ip-exact=$target \
$target.java \
AffineTransform.java \
$SYNTHESIJER_APP/src/synthesijer/lib/axi/AXILiteSlave32RTL.java \
$SYNTHESIJER_APP/src/synthesijer/lib/axi/AXIMemIface32RTL.java \
$SYNTHESIJER_APP/src/synthesijer/lib/axi/AXIMemIface32RTLTest.java 

#$SYNTHESIJER_APP/src/synthesijer/lib/axi/SimpleAXIMemIface32RTL.java \
#$SYNTHESIJER_APP/src/synthesijer/lib/axi/SimpleAXIMemIface32RTLTest.java

cp $SYNTHESIJER_APP/hdl/vhdl/axi_lite_slave_32.vhd $ipname/src/
cp $SYNTHESIJER_LIB/vhdl/dualportram.vhd $ipname/src/
cp $SYNTHESIJER_LIB/vhdl/synthesijer_mul32.vhd $ipname/src/
cp synthesijer_lib_axi_AXIMemIface32RTLTest.vhd $ipname/src/
cp $SYNTHESIJER_APP/hdl/vhdl/axi_memiface_32.vhd $ipname/src/
#cp synthesijer_lib_axi_SimpleAXIMemIface32RTLTest.vhd $ipname/src/
#cp $SYNTHESIJER_APP/hdl/vhdl/simple_axi_memiface_32.vhd $ipname/src/
cp $target.vhd $ipname/src/
cp AffineTransform.vhd $ipname/src/


