-- Currently, Impala can only insert data into tables that use the TEXT and Parquet formats. For other file formats, insert the data using Hive and use Impala to query it.

--needed because we created the tables with Hive
INVALIDATE METADATA;

DROP TABLE IF EXISTS people_parquet;
CREATE TABLE people_parquet LIKE people STORED AS PARQUETFILE;

INSERT OVERWRITE TABLE people_parquet SELECT * FROM people;

-- let's look at the difference between storing as text file vs. parquet file

SELECT * FROM people;

SUMMARY;
PROFILE;

SELECT * FROM people_parquet;

SUMMARY;
PROFILE;

SELECT * FROM people_rcfile;

SUMMARY;
PROFILE;

SELECT * FROM people_seqfile;

SUMMARY;
PROFILE;
