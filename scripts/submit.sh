#!/usr/bin/env bash

# Arguments:
# Arg 0 = organisation_id
#
# Notes:
# If working with log4j 1x use log4j.configuration
# If working with log4j 2x use log4j.configurationFile
spark-submit \
    --master spark://spark-master:7077 \
    --deploy-mode=client \
    --packages com.banzaicloud:spark-metrics_2.12:2.4-1.0.6,io.prometheus:simpleclient:0.15.0,io.prometheus:simpleclient_dropwizard:0.15.0,io.prometheus:simpleclient_pushgateway:0.15.0,io.prometheus:simpleclient_common:0.15.0,io.prometheus.jmx:collector:0.17.0 \
    --files=/files \
    --conf spark.executor.extraJavaOptions=-Dlog4j.configurationFile=file:///files/log4j_2x/log4j2.properties \
    --conf spark.driver.extraJavaOptions=-Dlog4j.configurationFile=file:///files/log4j_2x/log4j2.properties \
    --conf spark.metrics.conf.*.sink.prometheus.class=org.apache.spark.banzaicloud.metrics.sink.PrometheusSink \
    --conf spark.metrics.conf.*.sink.prometheus.labels=organisation_id=$1 \
    --conf spark.metrics.conf.*.sink.prometheus.pushgateway-address-protocol=http \
    --conf spark.metrics.conf.*.sink.prometheus.pushgateway-address=pushgateway:9091 \
    --conf spark.metrics.conf.*.sink.prometheus.pushgateway-enable-timestamp=false \
    --conf spark.metrics.conf.*.sink.prometheus.uni=seconds \
    --conf spark.metrics.conf.*.sink.prometheus.period=5 \
    /applications/helloworld-spark.py
