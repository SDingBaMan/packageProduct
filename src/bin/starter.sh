#!/bin/bash

APP_HOME=$(dirname $(cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd))
MAIN_CLASS=SDingBa.App
# 预处理
PID_FILE=${APP_HOME}/bin/crm.pid
CONF_DIR=${APP_HOME}/conf
LOG_DIR=${APP_HOME}/logs

# 避免重复启动
if [ -f ${PID_FILE} ] ; then
        echo "found ${PID_FILE} , Please stop it first!" 2>&2
    exit 1
fi

if [ ! -d ${LOG_DIR} ] ; then
        mkdir -p ${LOG_DIR}
fi

# 定位JAVA_HOME
if [ -x $JAVA_HOME/bin/java ]; then
    JAVA=$JAVA_HOME/bin/java
else
    JAVA=`which java`
fi

# 处理classpath
SYNC_CLASSPATH=${APP_HOME}/conf
for jar in ${APP_HOME}/lib/*.jar; do
    SYNC_CLASSPATH=${SYNC_CLASSPATH}:${jar}
done

# JVM参数
JVM_OPTS=" -Dapp.root=${APP_HOME} \
                    -ea \
                    -Xms128m \
                    -Xmx256m \
                    -XX:PermSize=64m
                    -XX:MaxPermSize=128m
                    -XX:+UseParNewGC \
                    -XX:+UseConcMarkSweepGC \
                    -XX:+CMSParallelRemarkEnabled \
                    -XX:SurvivorRatio=8 \
                    -XX:MaxTenuringThreshold=1 \
                    -XX:+PrintGC \
                    -XX:+PrintGCDetails \
                    -XX:+HeapDumpOnOutOfMemoryError \
                    -Xloggc:${LOG_DIR}/gc.log "

# 启动参数
SYNC_OPTS="-Dlogging.path=${LOG_DIR}"
exec ${JAVA} ${JVM_OPTS} ${SYNC_OPTS} -cp .:${SYNC_CLASSPATH} ${MAIN_CLASS} 1>>${LOG_DIR}/console.log 2>&1 &
echo $! > ${PID_FILE}
