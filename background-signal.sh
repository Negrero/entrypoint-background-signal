#!/usr/bin/env bash
set -x

pid=0

# SIGUSR1 -handler
my_handler() {
  echo "restarted apache"
  /usr/sbin/apachectl restart
}

# SIGTERM -handler
term_handler() {
  if [ $pid -ne 0 ]; then
       # stop service and clean up here
       echo "stopping apache"
       /usr/sbin/apachectl stop
        #kill -SIGTERM "$pid"
        wait "$pid"
  fi
  exit 143; # 128 + 15 -- SIGTERM
}

# setup handlers
# on callback, kill the last background process, which is `tail -f /dev/null` and execute the specified handler
trap 'kill ${!}; my_handler' SIGUSR1
trap 'kill ${!}; term_handler' SIGTERM

# run application
# start service in background here
/usr/sbin/apachectl start
pid="$!"

# wait forever
while true
do
  tail -f /dev/null & wait ${!}
done