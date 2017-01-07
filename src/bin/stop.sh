#!/bin/bash

this="${BASH_SOURCE-$0}"
APP_HOME=$(dirname $(cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd))
# 预处理
PID_FILE=${APP_HOME}/bin/crm.pid
if readlink -f "$this" > /dev/null 2>&1
then
  this=`readlink -f "$this"`
fi

[ -f $PIDFILE ] && pid=$(cat $PIDFILE)
[ -n "$pid" ] && ps -p $pid|grep $pid >/dev/null
if [ $? -eq 0 ]; then
  echo "kill process by pid match."
  kill -9 $pid
  exit
fi
echo "can not find process."
