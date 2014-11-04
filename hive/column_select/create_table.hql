DROP TABLE IF EXISTS test;
CREATE TABLE IF NOT EXISTS test
(	name STRING,
	age INT,
	birthday STRING,
	birthplace STRING
)
ROW FORMAT DELIMITED
   FIELDS TERMINATED BY '|'
STORED AS TEXTFILE;


LOAD DATA LOCAL INPATH 'data.txt' INTO TABLE test;

-- make sure that we can select based on a regex
set hive.support.quoted.identifiers=none;

-- https://issues.apache.org/jira/browse/HIVE-420
-- https://issues.apache.org/jira/browse/HIVE-7631

-- example how you can select columns with a regular expression

--select everything except the age column
select `(age)?+.+` from test;

--select everything except columns starting with 'birth'
select `(birth.*)?+.+` from test;
