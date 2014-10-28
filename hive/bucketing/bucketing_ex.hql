DROP TABLE IF EXISTS people;
CREATE TABLE IF NOT EXISTS people (
        name STRING,
        bday STRING
)
ROW FORMAT DELIMITED
   FIELDS TERMINATED BY '|'
STORED AS TEXTFILE;

LOAD DATA LOCAL INPATH 'birthdays.txt' INTO TABLE people;

-- now let's create buckets

DROP TABLE IF EXISTS people_bucketed;
CREATE TABLE people_bucketed(name STRING, bday STRING)
   CLUSTERED BY (name) INTO 3 BUCKETS
   ROW FORMAT DELIMITED
     FIELDS TERMINATED BY '|';

set hive.enforce.bucketing = true; 

FROM people
INSERT OVERWRITE TABLE people_bucketed
SELECT name, bday;

-- now let's create a partitioned and bucketed table

DROP TABLE IF EXISTS people_partitioned_bucketed;
CREATE TABLE people_partitioned_bucketed(name STRING, bday STRING)
    PARTITIONED BY (year STRING)
    CLUSTERED BY (name) INTO 3 BUCKETS
    ROW FORMAT DELIMITED
    	FIELDS TERMINATED BY '|';

set hive.exec.dynamic.partition=true;
set hive.exec.dynamic.partition.mode=nonstrict;

-- The columns you're partitioning by should be listed at the END of the SELECT statement
INSERT OVERWRITE TABLE people_partitioned_bucketed
    PARTITION (year)
    SELECT name, bday, year(bday) as year FROM people;


