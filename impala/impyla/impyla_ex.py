# First install impyla:
#	pip install impyla
# Also you would need pandas installed: pip install pandas

import pandas as pd
from impala.dbapi import connect
import os

impalad = 'localhost'

conn = connect(host=impalad, port=21050)
cursor = conn.cursor()
#Show tables
cursor.execute('SHOW TABLES')
tables = cursor.fetchall()
print "Tables: "
print tables

cursor.execute('SELECT * FROM people')
print cursor.description # prints the result set's schema
results = cursor.fetchall()
for res in results:
	print res
