TARGET=gray

defualt:
	./build.sh

clean:
	rm -rf *~ *.txt *.dot *.class dump*.xml

cleanall: clean
	rm -rf *.vhd AXIHP_GRAY_v1_0

tar: cleanall
	cd ..; tar zcvf $(TARGET).tgz $(TARGET)


