import sys
from pyspark import SparkConf
from pyspark.sql import SparkSession

APP_NAME = "citibike-ingest"
INPUT_PATH = "gs://twengineer/landing/citibike/"
OUTPUT_PATH = "gs://twengineer/raw/citibike"

def sanitize_columns(columns):
    return [column.replace(" ", "_") for column in columns]

def run(spark, ingest_path, transformation_path):
    input_df = (
        spark
        .read
        .format("csv")
        .option("header", True)
        .csv(ingest_path)
    )

    renamed_columns = sanitize_columns(input_df.columns)
    ref_df = input_df.toDF(*renamed_columns)

    (
        ref_df
        .write
        .mode("overwrite")
        .parquet(transformation_path)
    )

if __name__ == '__main__':
    spark = SparkSession.builder.appName(APP_NAME).getOrCreate()
    sc = spark.sparkContext

    run(spark, INPUT_PATH, OUTPUT_PATH)

    spark.stop()
