import synthesijer.lib.axi.*;
import synthesijer.rt.*;

class AXIHP_LABEL {
    private final AXILiteSlave32RTL s0    = new AXILiteSlave32RTL();
    private final AXIMemIface32RTLTest m0 = new AXIMemIface32RTLTest();

    private final LabelingWrapper labeling = new LabelingWrapper();

    private final int BS = 256;


	/*
    private void run_aftrans_proc() {
	int width     = s0.data[1];
	int height    = s0.data[2];
	at.mat00 = (short) s0.data[3];
        at.mat01 = (short) s0.data[4];
        at.mat02 = (short) s0.data[5];
        at.mat10 = (short) s0.data[6];
        at.mat11 = (short) s0.data[7];
        at.mat12 = (short) s0.data[8];

        at.width  = width;
        at.height = height;

	at.proc();
    }

    private void run_aftrans_Src2In() {
	int src_addr  = s0.data[1];
	int size      = s0.data[2];
	int offset = 0;

	while(size>=BS) {
	    m0.fetch(src_addr + (offset<<2), BS);
	    for(int i=0; i<BS; i++) {
		int d = m0.read(i);
		at.inData[offset + i] = d;
	    }
	    offset += BS;
	    size -= BS;
	}
	if(size==0) return;

	m0.fetch(src_addr + (offset<<2), size);
	for(int i=0; i<size; i++) {
	    int d = m0.read(i);
	    at.inData[offset + i] = d;
	}
    }

    private void run_aftrans_Out2Dst() {
	int dst_addr  = s0.data[1];
	int size      = s0.data[2];
	int offset = 0;

	while(size>=BS) {
	    for(int i=0; i<BS; i++) {
		int d = at.outData[offset + i];
		m0.write(i, d);
	    }
	    m0.flush(dst_addr + (offset<<2), BS);
	    offset += BS;
	    size -= BS;
	}
	if(size==0) return;

	for(int i=0; i<size; i++) {
	    int d = at.outData[offset + i];
	    m0.write(i, d);
	}
	m0.flush(dst_addr + (offset<<2), size);
    }
	*/

    private void run_memcpy() {
	int src_addr  = s0.data[1];
	int dest_addr = s0.data[2];
	int size      = s0.data[3];
	int offset = 0;

	while(size>=BS) {
	    m0.fetch(src_addr + (offset<<2), BS);
	    m0.flush(dest_addr + (offset<<2), BS);
	    size -= BS;
	    offset += BS;
	}
	if(size==0) return;
	m0.fetch(src_addr + (offset<<2), size);
	m0.flush(dest_addr + (offset<<2), size);
    }

    private int counter = 0;
    private boolean reset = true;
    @auto void clock() {
	while(true) {
	    if(reset) {
		counter = 0;
		reset = false;
	    } else {
		counter ++;
	    }
	}
    }

    @auto
	public void main() {
	s0.data[0] = 0x00000000;
	while(s0.data[0] == 0x00000000) ;
	int cmd = s0.data[0];
	reset = true;
	switch(cmd) {
	case 1:
	    run_memcpy();
	    break;
	}
	s0.data[1] = counter;
	s0.data[0] = 0x00000000;
    }
}
