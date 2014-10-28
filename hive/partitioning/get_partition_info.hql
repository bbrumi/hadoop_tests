SHOW PARTITIONS people_partitioned;

EXPLAIN EXTENDED 
SELECT name FROM PEOPLE
WHERE year(bday)='2008';


-- see that in this case we only read the year=2008 directory
EXPLAIN EXTENDED
SELECT name FROM people_partitioned
WHERE year='2008';
