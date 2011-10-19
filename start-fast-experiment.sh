#!/bin/bash
#wondershaper eth0 1100 1100
LEECHES_COUNT=2
echo $LEECHES_COUNT > /home/nep/experiments/experiment.txt
echo finished >> /home/nep/experiments/experiment.txt
for i in `seq 1 $LEECHES_COUNT`;
do
	if  [ -e `echo leech$i` ];
		then rm -rf leech$i;
	fi
	mkdir leech$i;
	cp seed/test-iso.torrent `echo leech$i/test-iso.torrent`;
	cd `echo leech$i`;
	aria2c --seed-ratio=0.0 --on-download-start /home/nep/experiments/start-download.sh --on-bt-download-complete /home/nep/experiments/complete-download.sh --enable-dht=false test-iso.torrent > /dev/null & 
	cd ../
done
cd seed/;
aria2c --seed-ratio=0.0 --on-download-start=/home/nep/experiments/start-download.sh --enable-dht=false -V -d. test-iso.torrent > log.txt &
cd ..;
