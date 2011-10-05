#!/bin/bash
#wondershaper eth0 1100 1100
LEECHES_COUNT=1
for i in `seq 1 $LEECHES_COUNT`;
do
	if  [ -e `echo leech$i` ];
		then rm -rf leech$i;
	fi
	mkdir leech$i;
	cp seed/test-iso.torrent `echo leech$i/test-iso.torrent`;
	cd `echo leech$i`;
	aria2c --on-download-start=/home/nep/experiments/start-download.sh --max-download-limit=1M --max-upload-limit=1M --enable-dht=false test-iso.torrent > log.txt & 
	cd ../
done
cd seed/;
aria2c --max-download-limit=1M --max-upload-limit=1M --enable-dht=false -V -d. test-iso.torrent >log.txt &
cd ..;
