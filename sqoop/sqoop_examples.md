# Sqoop examples

I've used the Cloudera Manager Quickstart VM which came with a script in /home/cloudera/datasets called tpcds-setup.sh. This script downloads the [TPC-DS dataset](http://www.tpc.org/tpcds/) and puts it into HDFS. It also creates a Hive table, but I've uncommented this, because I want to see how I can use sqoop to import/export data. I also changed where the script should put the data in HDFS. By default this was /user/hive, so the Hive warehouse directory, but I wanted to put the data somewhere else so I can then do sqoop-import to a Hive table.

	#!/bin/bash
	
	mkdir /home/cloudera/tpcds
	cd /home/cloudera/tpcds
	curl --output tpcds_kit.zip http://www.tpc.org/tpcds/dsgen/dsgen-download-files.asp?download_key=NaN
	unzip tpcds_kit.zip
	
	cd tools
	make clean
	make
	
	# generate the data
	export PATH=$PATH:.
	DIR=$HOME/tpcds/data
	mkdir -p $DIR
	SCALE=1
	FORCE=Y
	HDFS_PATH=/user/cloudera
	
	dsdgen -verbose -force $FORCE -dir $DIR -scale $SCALE -table store_sales
	dsdgen -verbose -force $FORCE -dir $DIR -scale $SCALE -table date_dim
	dsdgen -verbose -force $FORCE -dir $DIR -scale $SCALE -table time_dim
	dsdgen -verbose -force $FORCE -dir $DIR -scale $SCALE -table item
	dsdgen -verbose -force $FORCE -dir $DIR -scale $SCALE -table customer
	dsdgen -verbose -force $FORCE -dir $DIR -scale $SCALE -table customer_demographics
	dsdgen -verbose -force $FORCE -dir $DIR -scale $SCALE -table household_demographics
	dsdgen -verbose -force $FORCE -dir $DIR -scale $SCALE -table customer_address
	dsdgen -verbose -force $FORCE -dir $DIR -scale $SCALE -table store
	dsdgen -verbose -force $FORCE -dir $DIR -scale $SCALE -table promotion

	# copy data to hdfs
	hdfs dfs -mkdir $HDFS_PATH/tpcds/date_dim
	hdfs dfs -mkdir $HDFS_PATH/tpcds/time_dim
	hdfs dfs -mkdir $HDFS_PATH/tpcds/item
	hdfs dfs -mkdir $HDFS_PATH/tpcds/customer
	hdfs dfs -mkdir $HDFS_PATH/tpcds/customer_demographics
	hdfs dfs -mkdir $HDFS_PATH/tpcds/household_demographics
	hdfs dfs -mkdir $HDFS_PATH/tpcds/customer_address
	hdfs dfs -mkdir $HDFS_PATH/tpcds/store
	hdfs dfs -mkdir $HDFS_PATH/tpcds/promotion
	hdfs dfs -mkdir $HDFS_PATH/tpcds/store_sales
	
	cd $HOME/tpcds/data
	
	for t in date_dim time_dim item customer customer_demographics household_demographics customer_address store promotion store_sales
	do
	hdfs dfs -put ${t}.dat $HDFS_PATH/tpcds/${t}
	done
	
	hdfs dfs -ls -R $HDFS_PATH/tpcds/*/*.dat

After these changes run the script and install MySQL:

	# sh tpcds-setup.sh
	# sudo yum install mysql
	# sudo yum install mysql-server
	# sudo service mysqld start
	
We will only work with the customer table.

Create a dummy user so we can show that we need to provide MySQL credentials when running Sqoop commands:

	# mysql -u root
	> CREATE USER 'cloudera'@'localhost' IDENTIFIED BY 'cloudera';
	> GRANT ALL PRIVILEGES ON *.* TO 'cloudera'@'localhost' WITH GRANT OPTION;
	> exit
	
	# mysql -u cloudera
	ERROR 1045 (28000): Access denied for user 'cloudera'@'localhost' (using password: NO)
	
	# mysql -u cloudera -p
	If password is correct (i.e. cloudera), then it works.


## Exporting a table

When using sqoop export from HDFS to a database table, the table has to already exist. Creating this table can be done with your favourite database software (Toad, MySQL workbench, SQuirreL SQL Client, etc.) or with Sqoop. 

### Create DB table from Sqoop

Sqoop eval command can be used to evaluate a SQL statement and display the results.

** NOTE ** Sqoop is not a general query tool, the "eval" functionality is provided only for evaluation purpose and should not be used in production mode. 

	# sqoop-eval --connect jdbc:mysql://localhost --username cloudera --query 'show databases;'
	14/10/27 03:33:11 INFO manager.MySQLManager: Preparing to use a MySQL streaming resultset.
	14/10/27 03:33:12 WARN tool.EvalSqlTool: SQL exception executing statement: java.sql.SQLException: Access denied for user 'cloudera'@'localhost' (using password: NO)
	
	#sqoop-eval --connect jdbc:mysql://localhost --username cloudera --password cloudera --query 'show databases;'
	14/10/27 03:33:50 WARN tool.BaseSqoopTool: Setting your password on the command-line is insecure. Consider using -P instead.
	14/10/27 03:33:50 INFO manager.MySQLManager: Preparing to use a MySQL streaming resultset.
	------------------------
	| SCHEMA_NAME          | 
	------------------------
	| information_schema   | 
	| mysql                | 
	| test                 | 
	------------------------

The customer table definition can be found in /home/cloudera/datasets/tpcds_ss_tables.sql. After we rewrite the customer HiveQL create statement for MySQL we end up with something like this:

	CREATE TABLE customer
	(
	    c_customer_sk             INTEGER,
	    c_customer_id             VARCHAR(200),
	    c_current_cdemo_sk        INTEGER,
	    c_current_hdemo_sk        INTEGER,
	    c_current_addr_sk         INTEGER,
	    c_first_shipto_date_sk    INTEGER,
	    c_first_sales_date_sk     INTEGER,
	    c_salutation              VARCHAR(200),
	    c_first_name              VARCHAR(200),
	    c_last_name               VARCHAR(200),
	    c_preferred_cust_flag     VARCHAR(200),
	    c_birth_day               INTEGER,
	    c_birth_month             INTEGER,
	    c_birth_year              INTEGER,
	    c_birth_country           VARCHAR(200),
	    c_login                   VARCHAR(200),
	    c_email_address           VARCHAR(200),
	    c_last_review_date        VARCHAR(200)
	)

So let's create the table:

	# sqoop-eval --connect jdbc:mysql://localhost/test --username cloudera --password cloudera --query 'CREATE TABLE customer ( c_customer_sk INTEGER, c_customer_id VARCHAR(200), c_current_cdemo_sk INTEGER, c_current_hdemo_sk INTEGER, c_current_addr_sk INTEGER, c_first_shipto_date_sk INTEGER, c_first_sales_date_sk INTEGER, c_salutation VARCHAR(200), c_first_name VARCHAR(200), c_last_name VARCHAR(200), c_preferred_cust_flag VARCHAR(200), c_birth_day INTEGER, c_birth_month INTEGER, c_birth_year INTEGER, c_birth_country VARCHAR(200), c_login VARCHAR(200), c_email_address VARCHAR(200), c_last_review_date VARCHAR(200))'
	14/10/27 03:42:51 WARN tool.BaseSqoopTool: Setting your password on the command-line is insecure. Consider using -P instead.
	14/10/27 03:42:51 INFO manager.MySQLManager: Preparing to use a MySQL streaming resultset.
	14/10/27 03:42:52 INFO tool.EvalSqlTool: 0 row(s) updated.
	# sqoop-eval --connect jdbc:mysql://localhost/test --username cloudera --password cloudera --query 'show tables;'
	14/10/27 03:43:54 WARN tool.BaseSqoopTool: Setting your password on the command-line is insecure. Consider using -P instead.
	14/10/27 03:43:54 INFO manager.MySQLManager: Preparing to use a MySQL streaming resultset.
	------------------------
	| TABLE_NAME           | 
	------------------------
	| customer             |
	------------------------	

## Exporting data to a table

We need to use sqoop-export. The following command will export data from the HDFS directory into the customer table in MySQL and it also specifies how the fields are split in the input format.

	# sqoop-export --table customer --connect jdbc:mysql://localhost/test --username cloudera --password cloudera --export-dir /user/cloudera/tpcds/customer/ --input-fields-terminated-by '|'
	
Test that the export worked:

	# sqoop-eval --connect jdbc:mysql://localhost/test --username cloudera --password cloudera --query 'select * from customer limit 4;'

In case we run the export command multiple times, it will export the same data multiple times to the table:

	 # sqoop-eval --connect jdbc:mysql://localhost/test --username cloudera --password cloudera --query 'select count(*) from customer'
	14/10/27 03:49:50 WARN tool.BaseSqoopTool: Setting your password on the command-line is insecure. Consider using -P instead.
	14/10/27 03:49:50 INFO manager.MySQLManager: Preparing to use a MySQL streaming resultset.
	------------------------
	| count(*)             | 
	------------------------
	| 100000               | 
	------------------------
	# sqoop-export --table customer --connect jdbc:mysql://localhost/test --username cloudera --password cloudera --export-dir /user/cloudera/tpcds/customer/ --input-fields-terminated-by '|'
	# sqoop-eval --connect jdbc:mysql://localhost/test --username cloudera --password cloudera --query 'select count(*) from customer'
	14/10/27 03:50:49 WARN tool.BaseSqoopTool: Setting your password on the command-line is insecure. Consider using -P instead.
	14/10/27 03:50:50 INFO manager.MySQLManager: Preparing to use a MySQL streaming resultset.
	------------------------
	| count(*)             | 
	------------------------
	| 200000               | 
	------------------------

So what could we do if we do not want duplicate records? We need to make sure that before exported with sqoop, the DB table is truncated. 
 
### Truncating a table

We can truncate a table using the sqoop-eval command.

** NOTE ** Sqoop is not a general query tool, the "eval" functionality is provided only for evaluation purpose and should not be used in production mode. 

	#  sqoop-eval --connect jdbc:mysql://localhost/test --username cloudera --password cloudera --query 'TRUNCATE TABLE customer'
	14/10/27 03:52:34 WARN tool.BaseSqoopTool: Setting your password on the command-line is insecure. Consider using -P instead.
	14/10/27 03:52:34 INFO manager.MySQLManager: Preparing to use a MySQL streaming resultset.
	14/10/27 03:52:34 INFO tool.EvalSqlTool: 0 row(s) updated.
	# sqoop-eval --connect jdbc:mysql://localhost/test --username cloudera --password cloudera --query 'select count(*) from customer'
	14/10/27 03:53:09 WARN tool.BaseSqoopTool: Setting your password on the command-line is insecure. Consider using -P instead.
	14/10/27 03:53:09 INFO manager.MySQLManager: Preparing to use a MySQL streaming resultset.
	------------------------
	| count(*)             | 
	------------------------
	| 0                    | 
	------------------------
	# sqoop-eval --connect jdbc:mysql://localhost/test --username cloudera --password cloudera --query 'select count(*) from customer'
	14/10/27 03:50:49 WARN tool.BaseSqoopTool: Setting your password on the command-line is insecure. Consider using -P instead.

Watch out, this deletes data from the DB table.

### Importing data from Mysql to Hive

We can import from MySQL to Hive using sqoop-import. This will also create the meta information required in the Hive metastore. To create the Hive table we need to specify --hive-import

	# sqoop-import --connect jdbc:mysql://localhost/test --username cloudera --password cloudera --hive-import --table customer --split-by c_customer_sk

This will start a map-only job with 4 mappers (by default). If you want to start more or less map tasks you need to specify the "-m" parameter. Watch out, each map task will connect to the database, so specifying a large number of map tasks could mean that you might get 'Too many connections' error from your database...and this would make your DBA angry.

If you do not want to import the whole table you can use the '--query' parameter and then specify your own query. You can also use the '--columns' option to specify only a subset of columns to import from the specified DB table.

Check that the import worked:

	# hive -e 'select count(*) from customer'
	If this gives 100000 back, then it worked. You can also check that the data format is ok.
	# hive -e 'select * from customer limit 10'

#### Incremental imports

Let's see what the last record is in the MySQL database and let's insert a new row:

	# mysql -u cloudera -p 
	 > select * from test.customer order by c_customer_sk desc limit 1;
	+---------------+------------------+--------------------+--------------------+-------------------+------------------------+-----------------------+--------------+--------------+-------------+-----------------------+-------------+---------------+--------------+-----------------+---------+------------------------+--------------------+
	| c_customer_sk | c_customer_id    | c_current_cdemo_sk | c_current_hdemo_sk | c_current_addr_sk | c_first_shipto_date_sk | c_first_sales_date_sk | c_salutation | c_first_name | c_last_name | c_preferred_cust_flag | c_birth_day | c_birth_month | c_birth_year | c_birth_country | c_login | c_email_address        | c_last_review_date |
	+---------------+------------------+--------------------+--------------------+-------------------+------------------------+-----------------------+--------------+--------------+-------------+-----------------------+-------------+---------------+--------------+-----------------+---------+------------------------+--------------------+
	|        100000 | AAAAAAAAAKGIBAAA |             441077 |               4582 |              8487 |                2449763 |               2449733 | Mrs.         | Erica        | Parrott     | Y                     |          16 |             7 |         1939 | BELGIUM         |         | Erica.Parrott@9pnE.com | 2452621            |
	+---------------+------------------+--------------------+--------------------+-------------------+------------------------+-----------------------+--------------+--------------+-------------+-----------------------+-------------+---------------+--------------+-----------------+---------+------------------------+--------------------+
	1 row in set (0.15 sec)
	
	> INSERT INTO test.customer VALUES (50000000, 'BBBBBBB', 1, 1, 1, 21, 231, 'Mr', 'John', 'Doe', 'N', 3, 4, 1980, 'XXX','', 'email', 23); 
	Query OK, 1 row affected (0.00 sec)
	
	mysql> select * from test.customer order by c_customer_sk desc limit 1;+---------------+---------------+--------------------+--------------------+-------------------+------------------------+-----------------------+--------------+--------------+-------------+-----------------------+-------------+---------------+--------------+-----------------+---------+-----------------+--------------------+
	| c_customer_sk | c_customer_id | c_current_cdemo_sk | c_current_hdemo_sk | c_current_addr_sk | c_first_shipto_date_sk | c_first_sales_date_sk | c_salutation | c_first_name | c_last_name | c_preferred_cust_flag | c_birth_day | c_birth_month | c_birth_year | c_birth_country | c_login | c_email_address | c_last_review_date |
	+---------------+---------------+--------------------+--------------------+-------------------+------------------------+-----------------------+--------------+--------------+-------------+-----------------------+-------------+---------------+--------------+-----------------+---------+-----------------+--------------------+
	|      50000000 | BBBBBBB       |                  1 |                  1 |                 1 |                     21 |                   231 | Mr           | John         | Doe         | N                     |           3 |             4 |         1980 | XXX             |         | email           | 23                 |
	+---------------+---------------+--------------------+--------------------+-------------------+------------------------+-----------------------+--------------+--------------+-------------+-----------------------+-------------+---------------+--------------+-----------------+---------+-----------------+--------------------+
	1 row in set (0.04 sec)

So now how can we get only this one row into Hive, without dropping and re-importing the table?
What we need is sqoop-import with the 'incremental' property specified.

	# 	sqoop-import --connect jdbc:mysql://localhost/test --username cloudera --password cloudera --hive-import --table customer --split-by c_customer_sk --incremental append --check-column c_customer_sk --last-value 100000

From the Sqoop User Manual: 
> Sqoop supports two types of incremental imports: append and lastmodified. You can use the --incremental argument to specify the type of incremental import to perform.
> 
> You should specify append mode when importing a table where new rows are continually being added with increasing row id values. You specify the column containing the row's id with --check-column. Sqoop imports rows where the check column has a value greater than the one specified with --last-value.
> 
> An alternate table update strategy supported by Sqoop is called lastmodified mode. You should use this when rows of the source table may be updated, and each such update will set the value of a last-modified column to the current timestamp. Rows where the check column holds a timestamp more recent than the timestamp specified with --last-value are imported.
> 
> At the end of an incremental import, the value which should be specified as --last-value for a subsequent import is printed to the screen. When running a subsequent import, you should specify --last-value in this way to ensure you import only the new or updated data. This is handled automatically by creating an incremental import as a saved job, which is the preferred mechanism for performing a recurring incremental import. 

