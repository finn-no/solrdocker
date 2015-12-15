FROM finntech/openjdk8bond

ENV SOLR_USER solr
ENV SOLR_UID 8983

RUN adduser -u $SOLR_UID -S $SOLR_USER && addgroup -S $SOLR_USER

RUN apk --update add bash && rm /var/cache/apk/*

ENV SOLR_KEY CFCE5FBB920C3C745CEEE084C38FF5EC3FCFDB3E

ENV SOLR_VERSION 5.4.0
ENV SOLR_SHA256 84c0f04a23047946f54618a092d4510d88d7205a756b948208de9e5afb42f7cd

ADD solr_jmx_exporter_config.json /opt/agent-bond/jmx_exporter_config.json

RUN mkdir -p /opt/solr && \
  mkdir -p /opt/solrdata && \
  wget -q -O /opt/solr.tgz http://apache.uib.no/lucene/solr/$SOLR_VERSION/solr-$SOLR_VERSION.tgz && \
  echo "$SOLR_SHA256 */opt/solr.tgz" | sha256sum -c - && \
  tar -C /opt/solr -zxf /opt/solr.tgz && \
  rm /opt/solr.tgz* && \
  mv /opt/solr/solr-$SOLR_VERSION/* /opt/solr && \
  rm -rf /opt/solr/solr-$SOLR_VERSION && \
  rm -rf /opt/solr/docs && \
  rm -rf /opt/solr/example && \
  rm -rf /opt/solr/licenses && \
  rm -rf /opt/solr/contrib && \
  rm -rf /opt/solr/dist && \
  mkdir -p /opt/solr/server/solr/lib && \
  chown -R $SOLR_USER:$SOLR_USER /opt/solr /opt/solrdata

ENV RMI_PORT=28181

EXPOSE 8983
EXPOSE 28181

USER solr

ADD run-solr.sh /opt/solr/run-solr.sh

WORKDIR /opt/solr

ENV ENABLE_REMOTE_JMX_OPTS "true"

CMD [ "./run-solr.sh" ]
