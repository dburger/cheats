# prevent concurrent execution with flock
(
  flock -n 200
  if [ $? -ne 0 ]; then
    echo "unable to get the lock"
    exit 1
  fi
  echo "got the lock"
  sleep 40
) 200>/var/lock/hourlymapreduce.lock
