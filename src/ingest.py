import sys
from pyspark import SparkConf
from pyspark.sql import SparkSession

from data_transformations.citibike import ingest

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
        .parquet(transformation_path
    )

if __name__ == '__main__':
    if len(sys.argv) is not 3:
        logging.warning("Input source and output path are required")
        sys.exit(1)

    conf = (
        SparkConf()
        
        # AWS S3
        .set("spark.hadoop.fs.s3a.endpoint", "http://localhost:9000")
        .set("spark.hadoop.fs.s3a.access.key", "minioadmin")
        .set("spark.hadoop.fs.s3a.secret.key", "minioadmin")
        .set("spark.hadoop.fs.s3a.path.style.access", True)
        .set("spark.hadoop.fs.s3a.fast.upload", True)
        .set("spark.hadoop.fs.s3a.connection.maximum", 100)
        .set("spark.hadoop.fs.s3a.impl", "org.apache.hadoop.fs.s3a.S3AFileSystem")
    )

    spark = SparkSession.builder.appName(APP_NAME).config(conf=conf).getOrCreate()
    sc = spark.sparkContext

    input_path = sys.argv[1]
    output_path = sys.argv[2]

    run(spark, input_path, output_path)

    spark.stop()
