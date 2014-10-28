#!/bin/bash

python generate_data.py 
hive -f partitioning_ex.hql
hive -f get_partition_info.hql
