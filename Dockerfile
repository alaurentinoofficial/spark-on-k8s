FROM gcr.io/spark-operator/spark-py:v3.1.1

USER root:root

RUN mkdir -p /app

COPY src/*.py /app/
COPY jars/gcs-connector-hadoop3-latest.jar /opt/spark/jars/

WORKDIR /app

USER 1001