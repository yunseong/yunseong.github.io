#!/bin/bash

# Periodically kills slaves with given probability
PROB=0.3
INTERVAL_SEC=1

MASTER_NAME=REEFLauncher # Please change this if it's not correct.
SLAVE_NAME=Evaluator # Change this as well

RANDOM_MAX=32767

while [ `jps -m | grep -c $MASTER_NAME` -gt 0 ]
do
  echo "$MASTER found"

  NUMBER=$(echo "$PROB * $RANDOM_MAX" | bc)
  ROUNDED=${NUMBER%%.*}

  RESULT=""
  for i in {1..16}
  do
    if [ $RANDOM -lt $ROUNDED ]
    then
      RESULT+="X"
      ssh slave-$i kill `jps -m | grep $SLAVE_NAME | cut -d " " -f 1`
    else
      RESULT+="o"
    fi
  done
  echo $RESULT

  sleep $INTERVAL_SEC
done
echo "There is no process that contains $MASTER_NAME. Bye"
