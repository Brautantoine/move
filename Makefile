.PHONY: all
all :
	#Nothing to be done for all, just invoke `make install`



.PHONY: install
install : move.sh
	install -m 755 move.sh /usr/bin/move 
