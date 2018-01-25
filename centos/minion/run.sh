#!/bin/bash

# Configure master
sed -i "s/#master: salt/master: 172.17.0.2/g" /etc/salt/minion

# Start the minion
/usr/bin/salt-minion -d
status=$?
if [ $status -ne 0 ]; then
  echo "Failed to start salt-minion: $status"
  exit $status
fi

sleep 30

while /bin/true; do
  ps aux |grep salt-minion |grep -q -v grep
  PROCESS_2_STATUS=$?
  if [ $PROCESS_2_STATUS -ne 0 ]; then
    echo "One of the processes has already exited."
    exit -1
  fi
  sleep 60
done
