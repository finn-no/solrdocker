Docker solr
============

Base image for solr.
Base your solr install on this and create an /opt/solrhome directory with your
solr.xml / solrconfig.xml and schema setup

Something like
```
FROM finntech/solrdocker

ADD folderwithsolrconfig /opt/solrhome

ENV SOLR_DATA_DIR="-Dsolr.data.dir=/opt/solrdata"
```

Might be worth it to define /opt/solrdata as a volume so it survives restart of containers
