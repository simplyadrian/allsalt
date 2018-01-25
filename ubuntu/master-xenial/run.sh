#!/bin/bash

# Configure master
sed -i "s/#master: salt/master: localhost/g" /etc/salt/minion

# Start the first process
/usr/bin/salt-master -d
status=$?
if [ $status -ne 0 ]; then
  echo "Failed to start salt-master: $status"
  exit $status
fi

sleep 5

# Start the second process
/usr/bin/salt-minion -d
status=$?
if [ $status -ne 0 ]; then
  echo "Failed to start salt-minion: $status"
  exit $status
fi

sleep 30

salt-key --yes --accept-all

while /bin/true; do
  ps aux |grep salt-master |grep -q -v grep
  PROCESS_1_STATUS=$?
  ps aux |grep salt-minion |grep -q -v grep
  PROCESS_2_STATUS=$?
  # If the greps above find anything, they will exit with 0 status
  # If they are not both 0, then something is wrong
  if [ $PROCESS_1_STATUS -ne 0 -o $PROCESS_2_STATUS -ne 0 ]; then
    echo "One of the processes has already exited."
    exit -1
  fi
  sleep 60
done
