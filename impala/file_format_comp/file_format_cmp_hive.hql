-- Currently, Impala can only insert data into tables that use the TEXT and Parquet formats. For other file formats, insert the data using Hive and use Impala to query it.

DROP TABLE IF EXISTS people;
CREATE TABLE IF NOT EXISTS people (
        name STRING,
        bday STRING
)
ROW FORMAT DELIMITED
   FIELDS TERMINATED BY '|'
STORED AS TEXTFILE;

LOAD DATA LOCAL INPATH 'birthdays.txt' INTO TABLE people;

DROP TABLE IF EXISTS people_rcfile;
CREATE TABLE people_rcfile (
        name STRING,
        bday STRING
)
ROW FORMAT DELIMITED
   FIELDS TERMINATED BY '|'
STORED AS RCFILE;

INSERT OVERWRITE TABLE people_rcfile SELECT * FROM people;

DROP TABLE IF EXISTS people_seqfile;
CREATE TABLE people_seqfile (
        name STRING,
        bday STRING
)
ROW FORMAT DELIMITED
   FIELDS TERMINATED BY '|'
STORED AS SEQUENCEFILE;

INSERT OVERWRITE TABLE people_seqfile SELECT * FROM people;
