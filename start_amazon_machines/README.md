Used to start amazon machines for a CDH cluster
==============================================

I use Ansible to start up a couple of Amazon machines. I also created a security group to associate the machines with it.

Make sure that you have two environmental variables set: AWS_ACCESS_KEY and AWS_SECRET_KEY. The value of these variable should be taken from Amazon (Your Security Credentials -> Access Keys)

	# export AWS_ACCESS_KEY=myAccessKey
	# export AWS_SECRET_KEY=mySecretKey

Generate a keypair on your machine
	
	# ssh-keygen -t rsa
	Generating public/private rsa key pair.
	Enter file in which to save the key (/Users/admin/.ssh/id_rsa): hadoop_env    
	Enter passphrase (empty for no passphrase): 

Upload the public key to Amazon (E2 Management Console -> Key pairs -> Import Key)


To start up we need to do the following:

- create a virtual environment:

		# mkvirtualenv hadoop_env

- install requirement

		# pip install -r requirements.txt
		
Make sure that the correct AMI instances are specified in start_amazon_machines/var/machine_specs.yml
Here you can also specify how many instances you want to start and what type of instances you want to start (m1.small, etc.)

To start the instances run:

	#  ansible-playbook -i hosts --private-key=~/.ssh/hadoop_env  -u root -f20 start_instances.yml 

If you want to start ec2 machines with a keypair use the start_instances_withKeys.yml and make sure that you specified the key which the machines should use in var/machine_specs.yml

Now let's get the IPs and combine them so we get 2 master and 5 workers per user. First we need to set up boto, so we need to create a file:

	#vi ~/.boto
Add the following to the file:
	
	[Credentials]
	aws_access_key_id = <your access key>
	aws_secret_access_key = <your secret key>
	
In the getNames.py adjust the number of clients, worker and master nodes and then run to get a grouped list of machines:

	#python getNames.py