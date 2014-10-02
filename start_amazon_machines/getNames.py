import boto.ec2
import sys

nr_workers=5
nr_masters=2

worker_type='m1.small'
master_type='m1.medium'

my_masters_list=[]
my_workers_list=[]

nr_clients=2

conn=boto.ec2.connect_to_region("eu-west-1")
reservations = conn.get_all_instances()
for res in reservations:
    for inst in res.instances:
	if 'running' in inst.state:
		if worker_type in inst.instance_type:
			my_workers_list.append(inst)
		elif master_type in inst.instance_type:
			my_masters_list.append(inst)

worker_cnt=0
master_cnt=0
for i in range(nr_clients):
	print 'Client %s' % i
	print 'Masters:'	
	for j in range(nr_masters):
		if (master_cnt >= len(my_masters_list)):
			print 'Not enough master instances'
			sys.exit(1) 
		master = my_masters_list[master_cnt] 
		master_cnt+=1
		print "%s %s %s %s" % (master.id, master.public_dns_name, master.private_dns_name, master.instance_type)
  	print 'Workers:'
	for j in range(nr_workers):      
                if (worker_cnt >= len(my_workers_list)):
                        print 'Not enough worker instances'
                        sys.exit(1)
                worker = my_workers_list[worker_cnt] 
                worker_cnt+=1
                print "%s %s %s %s" % (worker.id, worker.public_dns_name, worker.private_dns_name, worker.instance_type)
