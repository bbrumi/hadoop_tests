# My link collection

## Architecture
* [Architectural Patterns for Near Real-Time Data Processing with Apache Hadoop](http://blog.cloudera.com/blog/2015/06/architectural-patterns-for-near-real-time-data-processing-with-apache-hadoop/)

## High Availability

* [CDH 5 High availability guide](http://www.cloudera.com/content/www/en-us/documentation/enterprise/latest/topics/admin_ha.html)

* [Configuring HiveServer2](http://www.cloudera.com/content/www/en-us/documentation/enterprise/latest/topics/cdh_ig_hiveserver2_configure.html)

* [Hue High Availability](http://www.cloudera.com/content/www/en-us/documentation/enterprise/latest/topics/cdh_hag_hue_config.html)

## HDFS

* [Apache Hadoop FileSystem commands](https://hadoop.apache.org/docs/r2.4.1/hadoop-project-dist/hadoop-common/FileSystemShell.html)

* [Deprecated properties](http://archive.cloudera.com/cdh5/cdh/5/hadoop/hadoop-project-dist/hadoop-common/DeprecatedProperties.html)

*  [A guide to checkpointing in Hadoop](http://blog.cloudera.com/blog/2014/03/a-guide-to-checkpointing-in-hadoop/)

*  [Celebrate failure(s) – a real-world Hadoop example (HDFS issues) -- heartbeat intervals](http://hakunamapdata.com/celebrate-failures-a-real-world-hadoop-example-hdfs-issues/)

*  [The Small Files Problem](http://blog.cloudera.com/blog/2009/02/the-small-files-problem/)

*  [Scalability of the Hadoop Distributed File System](https://developer.yahoo.com/blogs/hadoop/scalability-hadoop-distributed-file-system-452.html)

* [How Improved Short-Circuit Local Reads Bring Better Performance and Security to Hadoop](http://blog.cloudera.com/blog/2013/08/how-improved-short-circuit-local-reads-bring-better-performance-and-security-to-hadoop/)
* [Expose disk-location information for blocks to enable better scheduling](https://issues.apache.org/jira/browse/HDFS-3672)
* [DFS read performance suboptimal when client co-located on nodes with data](https://issues.apache.org/jira/browse/HDFS-347)

* [Two memory-related issues on the Apache Hadoop cluster (memory swapping and the OOM killer)](http://hakunamapdata.com/two-memory-related-issues-on-the-apache-hadoop-cluster/)


* [Datanode metrics](http://www.cloudera.com/content/cloudera/en/documentation/cloudera-manager/v5-1-x/Cloudera-Manager-Health-Tests/ht_datanode.html)

* [RAID vs. JBOD](http://hadoop.6.n7.nabble.com/RAID-vs-JBOD-td6860.html)

* [Best Practices: Linux File Systems for HDFS](http://hortonworks.com/kb/linux-file-systems-for-hdfs/)

* [HDFS Encryption at rest -- Cloudera](http://www.cloudera.com/content/cloudera/en/documentation/core/v5-2-x/topics/cdh_sg_hdfs_encryption.html)

##### HDFS fsImage backup

* [Backing Up and Restoring HDFS Metadata](http://www.cloudera.com/content/www/en-us/documentation/enterprise/latest/topics/cm_mc_hdfs_metadata_backup.html)

* [Backing up Namenode FSImage](https://community.cloudera.com/t5/Storage-Random-Access-HDFS/Backing-up-Namenode-FSImage/td-p/24268)

##### File appends
*  [File appends in HDFS](http://blog.cloudera.com/blog/2009/07/file-appends-in-hdfs/)
*  [An update on Apache Hadoop 1.0](http://blog.cloudera.com/blog/2012/01/an-update-on-apache-hadoop-1-0/)

##### Cache Management
* [New in CDH 5.1: HDFS Read Caching](http://blog.cloudera.com/blog/2014/08/new-in-cdh-5-1-hdfs-read-caching/)
*  [Centralized cache management](https://hadoop.apache.org/docs/r2.3.0/hadoop-project-dist/hadoop-hdfs/CentralizedCacheManagement.html)
*  [Centralized cache management in HDFS](http://www.cloudera.com/content/cloudera/en/documentation/cdh5/latest/CDH5-Installation-Guide/cdh5ig_hdfs_caching.html)


##### REST API
* [WebHDFS REST API](http://hadoop.apache.org/docs/r1.0.4/webhdfs.html)


##### Security
* [Explain like I’m 5: Kerberos](http://www.roguelynn.com/words/explain-like-im-5-kerberos/)
* [How-to: Set Up a Hadoop Cluster with Network Encryption](http://blog.cloudera.com/blog/2013/03/how-to-set-up-a-hadoop-cluster-with-network-encryption/)
* [ Direct Active Directory Integration for Kerberos Authentication](http://blog.cloudera.com/blog/2014/07/new-in-cloudera-manager-5-1-direct-active-directory-integration-for-kerberos-authentication/)
* [Cloudera security guide](http://www.cloudera.com/content/cloudera/en/documentation/core/latest/topics/security.html)
* [RecordService: For Fine-Grained Security Enforcement Across the Hadoop Ecosystem](http://blog.cloudera.com/blog/2015/09/recordservice-for-fine-grained-security-enforcement-across-the-hadoop-ecosystem/)
* [HDFS Data at Rest Encryption](http://www.cloudera.com/content/cloudera/en/documentation/core/latest/topics/cdh_sg_hdfs_encryption.html)

##### Cluster maintainance

* [NameNode Recovery Tools for the Hadoop Distributed File System](http://blog.cloudera.com/blog/2012/05/namenode-recovery-tools-for-the-hadoop-distributed-file-system/)
* [DFSadmin commands](http://hadoop.apache.org/docs/r0.18.1/commands_manual.html#dfsadmin)
* [The HDFS balancer](http://www.cloudera.com/content/cloudera/en/documentation/cdh4/latest/CDH4-Installation-Guide/cdh4ig_balancer.html)

### Planning a Hadoop cluster
* [The Truth About MapReduce Performance on SSDs](http://blog.cloudera.com/blog/2014/03/the-truth-about-mapreduce-performance-on-ssds/)
* [How-to: Select the Right Hardware for Your New Hadoop Cluster](http://blog.cloudera.com/blog/2013/08/how-to-select-the-right-hardware-for-your-new-hadoop-cluster/)

* [Configuring High Availability for ResourceManager (MRv2/YARN)](http://www.cloudera.com/content/cloudera/en/documentation/cdh5/v5-1-x/CDH5-High-Availability-Guide/cdh5hag_rm_ha_config.html)
* [Tuning the Cluster for MapReduce v2 (YARN)](http://www.cloudera.com/content/cloudera/en/documentation/core/latest/topics/cdh_ig_yarn_tuning.html)

### YARN

* [Managing Multiple Resources in Hadoop 2 with YARN](http://blog.cloudera.com/blog/2013/12/managing-multiple-resources-in-hadoop-2-with-yarn/)
* [How Apache Hadoop YARN HA Works](http://blog.cloudera.com/blog/2014/05/how-apache-hadoop-yarn-ha-works/)
* [Determine YARN and MapReduce Memory Configuration Settings](http://docs.hortonworks.com/HDPDocuments/HDP2/HDP-2.0.6.0/bk_installing_manually_book/content/rpm-chap1-11.html)

##### Migrating from MRv1 to MRv2
* [Migrating from MRv1 to MRv2](http://www.cloudera.com/content/cloudera/en/documentation/cdh5/latest/CDH5-Installation-Guide/cdh5ig_mapreduce_to_yarn_migrate.html)
* [Migrating to MapReduce 2 on YARN (For Operators)](http://blog.cloudera.com/blog/2013/11/migrating-to-mapreduce-2-on-yarn-for-operators/)
* [Migrating to MapReduce 2 on YARN (For Users)](http://blog.cloudera.com/blog/2013/11/migrating-to-mapreduce-2-on-yarn-for-users/)
* [Apache Hadoop YARN: Avoiding 6 Time-Consuming "Gotchas"](http://blog.cloudera.com/blog/2014/04/apache-hadoop-yarn-avoiding-6-time-consuming-gotchas/)

* [JIRA- MAPREDUCE-5785- Derive heap size or mapreduce.*.memory.mb automatically](https://issues.apache.org/jira/browse/MAPREDUCE-5785)

###### Java Heap

* [5 Tips for Proper Java Heap Size](http://architects.dzone.com/articles/5-tips-proper-java-heap-size)
* [Java (JVM) Memory Model and Garbage Collection Monitoring Tuning](http://www.journaldev.com/2856/java-jvm-memory-model-and-garbage-collection-monitoring-tuning)

### Spark
* [Can Spark Streaming survive Chaos Monkey?](http://techblog.netflix.com/2015/03/can-spark-streaming-survive-chaos-monkey.html)
* [How-to: Tune Your Apache Spark Jobs (Part 1)](http://blog.cloudera.com/blog/2015/03/how-to-tune-your-apache-spark-jobs-part-1/)

### Cloudera Manager
* [How does Cloudera Manager work?](http://blog.cloudera.com/blog/2013/07/how-does-cloudera-manager-work/)
* [Cloudera Manager Primer - understanding terminology](http://www.cloudera.com/content/cloudera/en/documentation/cloudera-manager/v5-latest/Cloudera-Manager-Introduction/cm5i_primer.html?scroll=concept_wfj_tny_jk_unique_1)
* [Understanding the Parcel Binary Distribution Format](http://blog.cloudera.com/blog/2013/05/faq-understanding-the-parcel-binary-distribution-format/)
* [Dynamic Resource Pools](http://www.cloudera.com/content/cloudera/en/documentation/cloudera-manager/v5-latest/Cloudera-Manager-Managing-Clusters/cm5mc_resource_pools.html)
* [Static Service Pools](http://www.cloudera.com/content/cloudera/en/documentation/cloudera-manager/v5-latest/Cloudera-Manager-Managing-Clusters/cm5mc_service_pools.html)
* [Safety valve](http://www.cloudera.com/content/cloudera/en/documentation/cloudera-manager/v4-8-1/Cloudera-Manager-Managing-Clusters/cmmc_safety_valve.html)
* [Charts](http://www.notesmine.org/faq/#Hadoop_Examples)
* [Backing up CM databases](http://www.cloudera.com/content/cloudera/en/documentation/cloudera-manager/v5-latest/Cloudera-Manager-Administration-Guide/cm5ag_backup_dbs.html)
* [How-to: Automate Your Cluster with Cloudera Manager API](http://blog.cloudera.com/blog/2012/09/automating-your-cluster-with-cloudera-manager-api/)
* [Cloudera Manager REST API](http://cloudera.github.io/cm_api/)
* [Cloudera API](http://cloudera.github.io/cm_api/epydoc/5.0.0/index.html)

### Fair scheduler
* [Enabling fair scheduler resource pools](http://extremehadoop.wordpress.com/tag/multitenant/)

### Flume

* [Flume user guide](https://flume.apache.org/FlumeUserGuide.html)
* [How-to: Do Apache Flume Performance Tuning](http://blog.cloudera.com/blog/2013/01/how-to-do-apache-flume-performance-tuning-part-1/)
* [Apache Flume – Architecture of Flume NG](http://blog.cloudera.com/blog/2011/12/apache-flume-architecture-of-flume-ng-2/)

### Kafka

* [Apache Kafka for beginners](http://blog.cloudera.com/blog/2014/09/apache-kafka-for-beginners/)


###Sqoop
* [Sqoop User Guide](https://sqoop.apache.org/docs/1.4.0-incubating/SqoopUserGuide.html#id1762844)
* [Sqoop vs. Sqoop2 differences](http://www.cloudera.com/content/www/en-us/documentation/enterprise/latest/topics/cdh_ig_sqoop_vs_sqoop2.html)

### Thrift
* [Introduction to Thrift](http://thrift-tutorial.readthedocs.org/en/latest/intro.html)


### Hue
* [Hive Language Manual](https://cwiki.apache.org/confluence/display/Hive/LanguageManual)
* [How-to: Make Hadoop Accessible via LDAP](http://blog.cloudera.com/blog/2014/02/how-to-make-hadoop-accessible-via-ldap/)

### Hive

* [Configuring the Hive metastore](http://www.cloudera.com/content/cloudera/en/documentation/core/latest/topics/cdh_ig_hive_metastore_configure.html)
* [Language Manual](https://cwiki.apache.org/confluence/display/Hive/LanguageManual)
* [Schema tool](https://cwiki.apache.org/confluence/display/Hive/Hive+Schema+Tool)
* [Hive locking](https://cwiki.apache.org/confluence/display/Hive/Locking)
* [Parallel ORDER BY - Hive](https://issues.apache.org/jira/browse/HIVE-1402)
* [How-to: Use a SerDe in Apache Hive](http://blog.cloudera.com/blog/2012/12/how-to-use-a-serde-in-apache-hive/)
* [Writing UDFs for Hive](http://www.cloudera.com/content/cloudera/en/resources/library/training/writing-udfs-for-hive.html)
* [User Defined functions in Hive](https://blogs.oracle.com/datawarehousing/entry/user_defined_functions_in_hive)
* [Hive UDFs](https://github.com/dataiku/dataiku-hive-udf)
* [ACID and transactions in Hive](https://cwiki.apache.org/confluence/display/Hive/Hive+Transactions)

### Sentry
* [With Sentry, Cloudera Fills Hadoop’s Enterprise Security Gap](http://blog.cloudera.com/blog/2013/07/with-sentry-cloudera-fills-hadoops-enterprise-security-gap/)
* [Apache Sentry](https://blogs.apache.org/sentry/entry/apache_sentry_architecture_overview)
* [Getting started with Sentry](https://blogs.apache.org/sentry/entry/getting_started)

###  Impala

* [Impala vs Hive SQL differences](http://www.cloudera.com/content/cloudera/en/documentation/cloudera-impala/v2-0-x/topics/impala_langref_unsupported.html)
* [Impala Performance Update: Now Reaching DBMS-Class Speed](http://blog.cloudera.com/blog/2014/01/impala-performance-dbms-class-speed/)


* [Setting up a Multi-tenant Cluster for Impala and MapReduce](http://www.cloudera.com/content/cloudera/en/documentation/cloudera-manager/v4-latest/Cloudera-Manager-Installation-Guide/cmig_impala_res_mgmt.html)
* [Configuring Impala and MapReduce for Multi-tenant Performance](http://blog.cloudera.com/blog/2013/06/configuring-impala-and-mapreduce-for-multi-tenant-performance/)

* [Using YARN Resource Management with Impala -- CDH 5 Only](http://www.cloudera.com/content/cloudera/en/documentation/cdh5/v5-1-x/Impala/Installing-and-Using-Impala/ciiu_resource_management.html)


* [Impala security](http://www.cloudera.com/content/cloudera/en/documentation/cloudera-impala/v1/latest/Installing-and-Using-Impala/ciiu_security.html)

* [Inside Cloudera Impala: Runtime Code Generation](http://blog.cloudera.com/blog/2013/02/inside-cloudera-impala-runtime-code-generation/)

* [User Defined functions in Impala](http://www.cloudera.com/content/cloudera/en/documentation/cloudera-impala/v1/latest/Installing-and-Using-Impala/ciiu_udf.html)

### Oozie
* [How-To: Schedule Recurring Hadoop Jobs with Apache Oozie](http://blog.cloudera.com/blog/2013/01/how-to-schedule-recurring-hadoop-jobs-with-apache-oozie/)

### Compression
* [Compression options in Hadoop - A tale of tradeoffs](http://www.slideshare.net/Hadoop_Summit/kamat-singh-june27425pmroom210cv2)

### Parquet & Avro
* [Understanding how Parquet integrates with Avro, Thrift and Protocol Buffers](http://grepalex.com/2014/05/13/parquet-file-format-and-object-model/)
* [Parquet Schema Evolution](https://github.com/Parquet/parquet-format/issues/91)
* [Reading and Writing Avro Files From the Command Line](http://www.michael-noll.com/blog/2013/03/17/reading-and-writing-avro-files-from-the-command-line/)


### Monitoring
* [HADOOP-6728-MetricsV2](http://wiki.apache.org/hadoop/HADOOP-6728-MetricsV2)
* [What is Hadoop Metrics2?](http://blog.cloudera.com/blog/2012/10/what-is-hadoop-metrics2/)

### Troubleshooting

* [strace](http://timetobleed.com/hello-world/)
* [Deceived by xciever](http://ccgtech.blogspot.fr/2010/02/hadoop-hdfs-deceived-by-xciever.html)

### Maven & Cloudera
* [Using the CDH 5 Maven Repository](http://cloudera.com/content/cloudera/en/documentation/core/latest/topics/cdh_vd_cdh5_maven_repo.html)

### AWS & Cloudera
* [Reference architecture](http://www.cloudera.com/content/dam/cloudera/Resources/PDF/whitepaper/AWS_Reference_Architecture_Whitepaper.pdf)
* [Best Practices for Deploying Cloudera Enterprise on Amazon Web Services](http://blog.cloudera.com/blog/2014/02/best-practices-for-deploying-cloudera-enterprise-on-amazon-web-services/)




### Google Whitepapers

* [GFS](http://research.google.com/archive/gfs-sosp2003.pdf)
* [Mapreduce](http://research.google.com/archive/mapreduce-osdi04.pdf)
* [BigTable](http://research.google.com/archive/bigtable-osdi06.pdf)
