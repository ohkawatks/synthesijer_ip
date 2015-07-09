defualt:
	./build.sh

clean:
	rm -rf *~ *.txt *.dot *.class dump*.xml

cleanall: clean
	rm -rf *.vhd AXIHP_AFTRANS_v1_0

tar: cleanall
	cd ..; tar zcvf aftrans.tgz aftrans

