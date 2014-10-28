DROP TABLE IF EXISTS people;
CREATE TABLE IF NOT EXISTS people (
	name STRING,
	bday STRING
)
ROW FORMAT DELIMITED
   FIELDS TERMINATED BY '|'
STORED AS TEXTFILE;

LOAD DATA LOCAL INPATH 'birthdays.txt' INTO TABLE people;

-- now let's create a partitioned table

DROP TABLE IF EXISTS people_partitioned;
CREATE TABLE people_partitioned(name STRING, bday STRING)
    PARTITIONED BY (year STRING)
    ROW FORMAT DELIMITED
    FIELDS TERMINATED BY '|';

set hive.exec.dynamic.partition=true;
set hive.exec.dynamic.partition.mode=nonstrict;

-- The columns you're partitioning by should be listed at the END of the SELECT statement
INSERT OVERWRITE TABLE people_partitioned 
    PARTITION (year)
    SELECT name, bday, year(bday) as year FROM people;

-- what if we deleted the original, but we decided that we should delete the partitioned table and create a non-partitioned table?
-- we can also see that we can query the whole table, not only a partition
-- If your partitioned table is very large, you could block any full table scan queries by putting Hive into strict mode using the set hive.mapred.mode=strict command. In this mode, when users submit a query that would result in a full table scan (i.e. queries without any partitioned columns) an error is issued

DROP TABLE IF EXISTS people_redone;
CREATE TABLE IF NOT EXISTS people_redone(
        name STRING,
        bday STRING,
	year INT
)
ROW FORMAT DELIMITED
   FIELDS TERMINATED BY '|'
STORED AS TEXTFILE;

INSERT OVERWRITE TABLE people_redone 
	SELECT name, bday, year FROM people_partitioned;
