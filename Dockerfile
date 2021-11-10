ARG SOLR_VERSION=6.6.6
ARG CKAN_VERSION=2.9.4


FROM solr:${SOLR_VERSION}-slim

ARG SOLR_VERSION
ARG CKAN_VERSION

ENV SOLR_CORE ckan
ENV CORE_DIR /opt/solr/server/solr/${SOLR_CORE}

RUN mkdir -p ${CORE_DIR}/conf \
 && mkdir -p ${CORE_DIR}/data \
 && echo name=${SOLR_CORE} > ${CORE_DIR}/core.properties

ADD --chown=${SOLR_USER}:${SOLR_GROUP} \
    https://raw.githubusercontent.com/ckan/ckan/ckan-${CKAN_VERSION}/ckan/config/solr/schema.xml \
    https://raw.githubusercontent.com/ckan/ckan/ckan-${CKAN_VERSION}/contrib/docker/solr/solrconfig.xml \
    https://raw.githubusercontent.com/apache/lucene-solr/releases/lucene-solr/${SOLR_VERSION}/solr/server/solr/configsets/basic_configs/conf/currency.xml \
    https://raw.githubusercontent.com/apache/lucene-solr/releases/lucene-solr/${SOLR_VERSION}/solr/server/solr/configsets/basic_configs/conf/synonyms.txt \
    https://raw.githubusercontent.com/apache/lucene-solr/releases/lucene-solr/${SOLR_VERSION}/solr/server/solr/configsets/basic_configs/conf/stopwords.txt \
    https://raw.githubusercontent.com/apache/lucene-solr/releases/lucene-solr/${SOLR_VERSION}/solr/server/solr/configsets/basic_configs/conf/protwords.txt \
    https://raw.githubusercontent.com/apache/lucene-solr/releases/lucene-solr/${SOLR_VERSION}/solr/server/solr/configsets/data_driven_schema_configs/conf/elevate.xml \
    ${CORE_DIR}/conf/
