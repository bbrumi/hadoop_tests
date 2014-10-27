# In your virtual environment do:
# 	pip install cm-api
import sys
from cm_api.api_client import ApiResource

cm_host = "localhost"
api = ApiResource(cm_host, username="cloudera", password="cloudera")

print "*** CLUSTERS ***"

clusters = None
# List clusters
for c in api.get_all_clusters():
    print "Cluster \"%s\" is version %s" % (c.name, c.version)
    clusters = c

print "*** HOSTS ***"

for host_ref in c.list_hosts():
    host = api.get_host(host_ref.hostId)
    print host.hostname

print "*** SERVICES ***"

hdfs = None
# List services & health info
for s in clusters.get_all_services():
  print "Service \"%s\" -- state \"%s\" -- health \"%s\"" %(s.name, s.serviceState, s.healthSummary)
  # Get HDFS service
  if 'hdfs' in s.type.lower():
    hdfs = s

print "*** HDFS Service checks (" + hdfs.serviceUrl + ") ***"

print "*** ROLES FOR HDFS ***"

for r in hdfs.get_all_roles():
        print "Role name: %s -- State: %s -- Health: %s -- Host: %s" % (r.name, r.roleState, r.healthSummary, r.hostRef.hostId)

print "*** DATANODE CONFIGS ***"

nn_groups=[]
# Print config for NameNodes
for group in hdfs.get_all_role_config_groups():
    if group.roleType == 'NAMENODE':
             nn_groups.append(group)

for cg in nn_groups:
       print "Found config group:  " + cg.name

nn_config = nn_groups[0].get_config(view='full')

for nn in nn_config:
        print "%s = %s" %(nn,nn_config[nn].value)


print "*** Changing trash interval ***"
# Change Trash interval
nn_groups[0].update_config({'fs_trash_interval': 360})

# Restart and redeploy files
print "*** Restart service and redeploy configs ***"

hdfs.restart()



