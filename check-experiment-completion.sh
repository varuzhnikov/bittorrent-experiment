#!/bin/bash
HOME_DIR=~
EXPERIMENT_DIR=$HOME_DIR/experiments
echo check finish of experiment >> $EXPERIMENT_DIR/log.txt
read -r LEECHES_COUNT < $EXPERIMENT_DIR/experiment.txt
START_POSITION=2
FINISHED_LEECHERS="$[`cat $EXPERIMENT_DIR/experiment.txt | wc -l` - $START_POSITION]"
echo finished leechers $FINISHED_LEECHERS >> $EXPERIMENT_DIR/log.txt
echo leeches count $LEECHES_COUNT >> $EXPERIMENT_DIR/log.txt
echo $FINISHED_LEECHERS
echo $LEECHES_COUNT
if [ $FINISHED_LEECHERS == $LEECHES_COUNT ];
	then 
		echo "Entered in fininsh" >> $EXPERIMENT_DIR/log.txt
		echo results > results.txt
		for i in `seq 1 $LEECHES_COUNT`;
		do
			echo $i;
			TIME_INTERVAL_FILE=`echo $EXPERIMENT_DIR/leech$i/timeInterval.txt`
			echo $TIME_INTERVAL_FILE
			START=`cat $TIME_INTERVAL_FILE | head -n 1 | tail -n 1`
			echo $START
			END=`cat $TIME_INTERVAL_FILE | head -n 2 | tail -n 1`
			echo $END
			TIME_INTERVAL=$[$END-$START]
			echo $TIME_INTERVAL >> $EXPERIMENT_DIR/result.txt
		done
		sh $EXPERIMENT_DIR/stop-experiment.sh
fi
