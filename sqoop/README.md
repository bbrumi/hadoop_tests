# Sqoop example when no primary key and all keys are varchar

### First we create a table in Mysql

	CREATE TABLE testSqoop (
	  varcharid VARCHAR(11),
	  name VARCHAR(25)
	) TYPE=innodb;

	INSERT INTO testSqoop VALUES (null, 'test1');
	INSERT INTO testSqoop VALUES (null, 'test2');
	INSERT INTO testSqoop VALUES ('a', 'test1');
	INSERT INTO testSqoop VALUES ('b', 'test2');
	INSERT INTO testSqoop VALUES ('c', 'test2');
	INSERT INTO testSqoop VALUES ('d', 'test2');
	INSERT INTO testSqoop VALUES ('e', 'test2');
	INSERT INTO testSqoop VALUES ('f', 'test2');
	INSERT INTO testSqoop VALUES ('g', 'test2');
	INSERT INTO testSqoop VALUES ('h', 'test2');
	INSERT INTO testSqoop VALUES ('i', 'test2');
	INSERT INTO testSqoop VALUES ('d', 'test2');
	INSERT INTO testSqoop VALUES ('e', 'test2');
	INSERT INTO testSqoop VALUES ('f', 'test2');
	INSERT INTO testSqoop VALUES ('g', 'test2');
	INSERT INTO testSqoop VALUES ('h', 'test2');
	INSERT INTO testSqoop VALUES ('i', 'test2');

Now let's try importing this into HDFS with Sqoop:
	
	$ sqoop import --connect jdbc:mysql://localhost/movielens --table testSqoop --fields-terminated-by '\t' --username training --password training
	Warning: /usr/lib/sqoop/../hbase does not exist! HBase imports will fail.
	Please set $HBASE_HOME to the root of your HBase installation.
	Warning: /usr/lib/sqoop/../hive-hcatalog does not exist! HCatalog jobs will fail.
	Please set $HCAT_HOME to the root of your HCatalog installation.
	Warning: /usr/lib/sqoop/../accumulo does not exist! Accumulo imports will fail.
	Please set $ACCUMULO_HOME to the root of your Accumulo installation.
	14/10/02 17:57:12 INFO sqoop.Sqoop: Running Sqoop version: 1.4.4-cdh5.0.0
	14/10/02 17:57:12 WARN tool.BaseSqoopTool: Setting your password on the command-line is insecure. Consider using -P instead.
	14/10/02 17:57:12 INFO manager.MySQLManager: Preparing to use a MySQL streaming resultset.
	14/10/02 17:57:12 INFO tool.CodeGenTool: Beginning code generation
	14/10/02 17:57:15 INFO manager.SqlManager: Executing SQL statement: SELECT t.* FROM `testSqoop` AS t LIMIT 1
	14/10/02 17:57:15 INFO manager.SqlManager: Executing SQL statement: SELECT t.* FROM `testSqoop` AS t LIMIT 1
	14/10/02 17:57:15 INFO orm.CompilationManager: HADOOP_MAPRED_HOME is /usr/lib/hadoop-mapreduce
	Note: /tmp/sqoop-training/compile/d62cb0c36bb5978d7a8479b8a0198e48/testSqoop.java uses or overrides a deprecated API.
	Note: Recompile with -Xlint:deprecation for details.
	14/10/02 17:57:23 INFO orm.CompilationManager: Writing jar file: /tmp/sqoop-training/compile/d62cb0c36bb5978d7a8479b8a0198e48/testSqoop.jar
	14/10/02 17:57:23 WARN manager.MySQLManager: It looks like you are importing from mysql.
	14/10/02 17:57:23 WARN manager.MySQLManager: This transfer can be faster! Use the --direct
	14/10/02 17:57:23 WARN manager.MySQLManager: option to exercise a MySQL-specific fast path.
	14/10/02 17:57:23 INFO manager.MySQLManager: Setting zero DATETIME behavior to convertToNull (mysql)
	14/10/02 17:57:23 ERROR tool.ImportTool: Error during import: No primary key could be found for table testSqoop. Please specify one with --split-by or perform a sequential import with '-m 1'.


Ok, so that didn't work...but we could just specify the first column to split by.

	$ sqoop import --connect jdbc:mysql://localhost/movielens --table testSqoop --fields-terminated-by '\t' --username training --password training --split-by varcharid
	
This job runs successfully. Let's look at the output:

	#hdfs dfs -cat testSqoop/part-m-*
	a	test1
	b	test2
	c	test2
	d	test2
	d	test2
	e	test2
	f	test2
	e	test2
	f	test2
	g	test2
	h	test2
	i	test2
	g	test2
	h	test2
	i	test2

Hey...wait...were are out NULL values?

Let's try it again, but now let's specify "-m 1" instead of split-by.

	$ sqoop import --connect jdbc:mysql://localhost/movielens --table testSqoop --fields-terminated-by '\t' --username training --password training -m 1
	
	$ hdfs dfs -cat testSqoop/part-m-*
	null	test1
	null	test2
	a	test1
	b	test2
	c	test2
	d	test2
	e	test2
	f	test2
	g	test2
	h	test2
	i	test2
	d	test2
	e	test2
	f	test2
	g	test2
	h	test2
	i	test2
	

#### Explanation

So what did you happen? Well Sqoop creates a map-only job to transfer the files and it needs to be able to determine which mapper should handle which part of the data. When there is a primary key on the table then it tries to split the data based on the primary key into buckets which can be transferred by the different mappers. By default Sqoop uses 4 mappers. But we didn't have a primary key.

In the first try  we can just specify which field Sqoop should use to split the data by, but in this case the NULL values were ignored. What else should we take into account when using split-by? We should make sure that the data in the given column can be split into almost equal buckets. Let's say that we have a lot of 'A'-s in the given column and only a couple of 'Z'-s. If we would take the very naive approach that each letter will be processed by one mapper, then the mapper which would be processing the letter 'A' would finish later making all the other mappers wait...and the job would last longer. Of course Sqoop tries to use hashing to create mapper tasks which would process almost the same amount of data...but it cannot do magical things, if your data is really unbalanced you should consider using a different column as the 'split-by' value.

Our final test was to run the whole sqoop job with only 1 mapper, which eliminates the problem of splitting the dataset. We could do this, because our data set is small...no problem for one mapper. We would need to find a smarter solution if we would be transferring a larger table...

