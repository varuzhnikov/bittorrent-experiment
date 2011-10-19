#!/bin/bash
HOME_DIR=~
EXPERIMENTS_DIR=$HOME_DIR/experiments
echo Entererd in stop process >> $EXPERIMENTS_DIR/log.txt
while read line; do
   kill -9 $line
done < $EXPERIMENTS_DIR/peers.txt
rm -rf $EXPERIMENTS_DIR/peers.txt
