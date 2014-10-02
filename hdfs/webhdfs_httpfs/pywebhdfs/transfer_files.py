from pywebhdfs.webhdfs import PyWebHdfsClient

import sys, getopt, os, json, re

DEFAULT_SERVER='HTTPFS.server'
DEFAULT_PORT=14000

DEFAULT_LOCAL_PATH='/tmp/'
DEFAULT_HDFS_PATH='tmp/'
DEFAULT_HDFS_USERNAME='myUser'

def help():
	print 'transfer_files.py -s <httpfs_server:port> -i <infile> -o <outfile> [-f] [--status] [-r] [-l]'
	print "f - transfer file to HDFS"
	print "r - read file from HDFS -- we only need -o specified"
	print "status - get the status of the file/directory specified in -o (queries HDFS)"
	print "l - list directory on HDFS"

def get_webHDFSclient(server, port, user):
	return PyWebHdfsClient(host=server, port=port, user_name=user)  

def put_file_to_hdfs(client, infile, outfile):
	with open(infile) as file_data:
		client.create_file(outfile, file_data)

def query_hdfs(client, path):
	print json.dumps(client.get_file_dir_status(path), sort_keys=True,indent=4, separators=(',', ': '))


def read_file(client, path):
	print client.read_file(path)	

def list_hdfs(client, path):
	print json.dumps(client.list_dir(path), sort_keys=True,indent=4, separators=(',', ': '))

def put_dir_to_hdfs(client, inDir, outDir):
	# for each file in inDir, check that the file name is in the format YYYY-MM-dd.txt
	for file in os.listdir(inDir):
		fromTransfer=inDir+"/"+file
		toTransfer=outDir+"/"+file
		print "Transferring %s to %s" % (fromTransfer, toTransfer)
		put_file_to_hdfs(client, fromTransfer, toTransfer)

def main(argv):
   try:
      opts, args = getopt.getopt(argv,"hs:i:o:rlfd",["server","ifile","ofile","file","read","status","list","dir"])
   except getopt.GetoptError:
      help()
      sys.exit(2)
   host=DEFAULT_SERVER
   port=DEFAULT_PORT
   oper=None
   inputfile=None
   outputfile=None
   for opt, arg in opts:
      if opt == '-h':
        help() 
	sys.exit()
      elif opt in ("-s", "--server"):
	 if ':' in arg:
        	host, port = arg.split(':')
    	 else:
        	host, port = arg, DEFAULT_PORT
      elif opt in ("-i", "--ifile"):
	 inputfile = os.path.abspath(arg)
      elif opt in ("-o", "--ofile"):
     	 if arg.startswith('/'):
                outputfile = arg[1:]
         else:
                outputfile = DEFAULT_HDFS_PATH+arg
      elif opt in ("-f", "--file"):
	 oper="file"
      elif opt in ("-r", "--read"):
	 oper="read"
      elif opt in ("-l", "--list"):
	 oper="list"
      elif opt in ("-d", "--dir"):
	 oper="dir"
      elif opt in ("--status"):
	 oper="status"
   print 'Server is ', host, ":", port
   if inputfile is None and oper not in ("read", "status","list"):
	print "No local file specified"
	help()
	exit(1)
   elif inputfile is not None:
	if not os.path.isfile(inputfile) and oper is "file": 
		print "Local file does not exist ", inputfile
		help()
		exit(1)
	elif not os.path.isdir(inputfile) and oper is "dir":
		print "Local dir does not exist ", inputfile
		help()
		exit(1)
	print "To transfer ", inputfile 
   if outputfile is None:
        print "No HDFS location specified"
	help()
	exit(1)
   else:
        print "HDFS location ", outputfile
   if oper is None:
	print "No operation specified"
	help()
	exit(1)
   else:
	print "Operation:", oper
   
   client = get_webHDFSclient(host, port, DEFAULT_HDFS_USERNAME)
   if oper is "status":
	query_hdfs(client, outputfile)
   elif oper is "file":
	put_file_to_hdfs(client,inputfile, outputfile)
   elif oper is "read":
	read_file(client, outputfile)
   elif oper is "list":
	list_hdfs(client, outputfile)
   elif oper is "dir":
	put_dir_to_hdfs(client,inputfile, outputfile)
   else:
	print "Unknows operation"

if __name__ == "__main__":
   main(sys.argv[1:])
