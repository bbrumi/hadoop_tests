# Running impyla on a cluster which has Kerberos enabled

First in your virtual environment you need to install the following:

    pip install sasl
    pip install impyla
    
Make sure that the kerberos configuration is on the machine where your virtual environment is:

    scp username@<some_host_in_cluster>:/etc/krb5.conf ~/.krb5.conf 
    export KRB5_CONFIG=~/.krb5.conf

Now edit, with sudo privileges, the file /etc/hosts in your Mac and add the IP and hostname of the machine where your impala daemon runs. Also, you should add the IP and hostname of the server where your kerberos server is installed.
Then

	kinit username@YOUR_DOMAIN
	klist  # will confirm you have the ticket

The Python code to connect is then

	import pandas as pd
	from impala.dbapi import connect
	import os

	os.environ['KRB5_CONFIG'] = '~/.krb5.conf'

	conn = connect(host='host_where_impalad_runs', port=21050, use_kerberos=True, kerberos_service_name='impala')
	cursor = conn.cursor()
	cursor.execute('SELECT * FROM your_table')
	print cursor.description # prints the result set's schema
	results = cursor.fetchall()
	
If you want to save stuff in a pandas dataframe you can use

	from impala.util import as_pandas
	df = as_pandas(cur)