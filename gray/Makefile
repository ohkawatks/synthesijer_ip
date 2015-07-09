TARGET=gray
TARGET_IP_NAME=AXIHP_GRAY
TARGET_IP_VERSION=v1_0
TARGET_IP=$(TARGET_IP_NAME)_$(TARGET_IP_VERSION)

SRCS=		$(SYNTHESIJER_EXTRA_LIB)/src/synthesijer/lib/axi/AXILiteSlave32RTL.java \
                $(SYNTHESIJER_EXTRA_LIB)/src/synthesijer/lib/axi/SimpleAXIMemIface32RTL.java \
                $(SYNTHESIJER_EXTRA_LIB)/src/synthesijer/lib/axi/SimpleAXIMemIface32RTLTest.java

HDL_SRCS=	*.vhd \
		$(SYNTHESIJER_EXTRA_LIB)/hdl/vhdl/axi_lite_slave_32.vhd \
		$(SYNTHESIJER_EXTRA_LIB)/hdl/vhdl/simple_axi_memiface_32.vhd \
		$(SYNTHESIJER_LIB)/vhdl/dualportram.vhd 

defualt: ip

ip:
	rm -rf $(TARGET_IP)

	java -cp $(SYNTHESIJER):$(SYNTHESIJER_EXTRA_LIB)/bin:. \
		synthesijer.Main \
		--ip-exact=$(TARGET_IP_NAME) \
		$(TARGET_IP_NAME).java \
		$(SRCS)

	cp $(HDL_SRCS) $(TARGET_IP)/src/
	tar zcvf ../$(TARGET_IP).tgz $(TARGET_IP)

clean:
	rm -rf *~ *.txt *.dot *.class dump*.xml

cleanall: clean
	rm -rf *.vhd $(TARGET_IP)

tar: cleanall
	cd ..; tar zcvf $(TARGET).tgz $(TARGET)


