#!/bin/sh

export CMD_OPTS="-f -p 8983"

if [ -f /opt/run-java-options ]; then
  export EXTRA_JAVA_OPTS=`sh /opt/run-java-options`
  export CMD_OPTS="$CMD_OPTS -a $EXTRA_JAVA_OPTS"
fi

if [ -d /opt/solrhome ]; then
  export SOLR_FOLDER="/opt/solrhome"
  export CMD_OPTS="$CMD_OPTS -s $SOLR_FOLDER"
fi

cd /opt/solr

./bin/solr $CMD_OPTS