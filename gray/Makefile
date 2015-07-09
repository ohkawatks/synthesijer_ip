TARGET=gray

defualt:
	./build.sh

clean:
	rm -rf *~ *.txt *.dot *.class dump*.xml

cleanall: clean
	rm -rf *.vhd

tar: clean
	cd ..; tar zcvf $(TARGET).tgz $(TARGET)


