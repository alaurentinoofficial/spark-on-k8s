# docker image [gcp]
FROM gcr.io/spark-operator/spark-py:v3.1.1
MAINTAINER Anderson Laurentino <anderson@laurentino.me>

# using root user
USER root:root

# create directory for apps
RUN mkdir -p /app

# copy spark program
COPY citibike /app/

# copy jar files
COPY ./jars/ /opt/spark/jars

# set work directory
WORKDIR /app

# user
USER 1001