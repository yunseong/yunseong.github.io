#!/bin/bash
#PROCESS_NAME='CoarseGrainedExecutorBackend'
PROCESS_NAME=$1
LOG='/tmp/killer.log'

echo "Started" >> /tmp/killer.log
date >> $LOG
if [ `jps -m | grep -c $PROCESS_NAME` -gt 0 ]
then
  echo 'X' >> $LOG
  PID=`jps -m | grep $PROCESS_NAME | cut -d " " -f 1`
  kill $PID
else
  echo '.' >> $LOG
fi
