
public class AffineTransform {
    int width  = 256;
    int height = 128;
    int[] inData  = new int[32768]; // MAX 256*128 = width*height
    int[] outData = new int[32768]; // MAX 256*128 = width*height
    int[] cmpData = new int[32768]; // MAX 256*128 = width*height

    short mat00 = 0;
    short mat01 = 1024;
    short mat02 = 0;
    short mat10 = 1024;
    short mat11 = 0;
    short mat12 = 0;

    boolean modeInterpolation = true;
    boolean modeCompare = true;
    int diffCompare = 0;
    
    public void clear() {
	for(int i=0; i<height; i++) {
	    for(int j=0; j<width; j++) {
		int indexPixel = i*width + j;
		outData[indexPixel] = 0;
	    }
	}
    }
    
    public void proc() {
	diffCompare = 0;
	for(int i=0; i<height; i++) {
	    for(int j=0; j<width; j++) {
		int indexPixel  = i*width + j;
		int warpedXorg  = (mat00 * i + mat01 * j + mat02);
		int warpedYorg  = (mat10 * i + mat11 * j + mat12);
		int warpedX     = warpedXorg >> 10;
		int warpedY     = warpedYorg >> 10;
		if(warpedX < 0 || warpedX>=width-1  || warpedY < 0 || warpedY>=height-1) continue;
		
		int indexWarpedPixel = warpedY*width + warpedX;
		int pixel = 0;
		if(modeInterpolation) {
		    int warpedXfrac = warpedXorg & 0x3ff;
		    int warpedYfrac = warpedYorg & 0x3ff;

		    int pixel00 = inData[indexWarpedPixel];
		    int pixel01 = inData[indexWarpedPixel+1];
		    int pixel10 = inData[indexWarpedPixel+width];
		    
		    pixel = 
			(pixel00 * (1024 - warpedXfrac) 
			 + pixel01 * warpedXfrac
			 + pixel00 * (1024 - warpedYfrac)
			 + pixel10 * warpedYfrac) >> 11;
		} else {
		    pixel = inData[indexWarpedPixel];
		}
		
		if(modeCompare) {
		    int diff =  (int) cmpData[indexPixel] - pixel;
		    if(diff > 0) {
			diffCompare += diff;
		    } else {
			diffCompare -= diff;
		    }
		} else {
		    outData[indexPixel] = pixel;
		}
	    }
	}
    }
}

