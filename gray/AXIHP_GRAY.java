import synthesijer.lib.axi.*;
import synthesijer.rt.*;

@synthesijerhdl
class AXIHP_GRAY {
    private final AXILiteSlave32RTL s0 = new AXILiteSlave32RTL();
    private final SimpleAXIMemIface32RTLTest m0 = 
	new SimpleAXIMemIface32RTLTest();

    private void run() {
	int src_addr  = s0.data[1];
	int dest_addr = s0.data[2];
	int size      = s0.data[3];
	for(int i=0; i<size; i++) {
	    int rgb=m0.read_data(src_addr + (i<<2));
	    int r = (rgb >> 16) & 0xff;
	    int g = (rgb >>  8) & 0xff;
	    int b = rgb & 0xff;
	    int gray = (r+g+g+b) >> 2;
	    m0.write_data(dest_addr + (i<<2), gray);
	}
    }

    @auto
	public void main() {
	s0.data[0] = 0x00000000;
	while(s0.data[0] == 0x00000000) ;
	run();
	s0.data[0] = 0x00000000;
    }
}
