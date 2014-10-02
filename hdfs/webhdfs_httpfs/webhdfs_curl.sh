#!/bin/bash

# default HttpFS port 14000
# WehHDFS port - NN port - default: 50070

USE="WebHDFS: $0 <Active Namenode:Port> [status|put|get|mkdir|deleteFir|deleteDir] \n
     HttpFS: $0 <HTTPServer:Port> [status|put|get|mkdir|deleteFir|deleteDir] \n"

if [ $# -ne 2 ]; 
    then 
	echo "illegal number of parameters"
	echo $USE
	exit 0
fi


SERVER_AND_PORT=$1
CMD=$2
QUERY="http://$SERVER_AND_PORT/webhdfs/v1"

USER=training

DIR=testWebHDFS
FILE=testWebHDFS.txt


case $CMD in
	status)
		echo "Get $TESTDIR directory status"
		curl -i "$QUERY/$DIR?op=LISTSTATUS&user.name=$USER"
	;;
        mkdir)
                echo "Create $TESTDIR directory"
                curl -i -X PUT "$QUERY/$TESTDIR/?op=MKDIRS&user.name=$USER"
        ;;
        put)
                # Some options:
                # curl -i -X PUT "http://<HOST>:<PORT>/webhdfs/v1/<PATH>?op=CREATE
                #                [&overwrite=<true|false>][&blocksize=<LONG>][&replication=<SHORT>]
                #                [&permission=<OCTAL>][&buffersize=<INT>]"
                # TODO: Test that the TestDir already exists
		# test if directory exists
		exists=`curl -i  "http://$QUERY/webhdfs/v1/$TESTDIR?op=GETFILESTATUS" | grep 'FileNotFoundException'`
		echo $exists
                echo "Will now PUT ./testdata.txt into directory $TESTDIR"
                curl -i -L -X PUT "$QUERY/$TESTDIR/$FILE?op=CREATE&user.name=$USER" -T ./$FILE
        ;;
        get)
                echo "GET $TESTDIR/$FILE"
                curl -i "$QUERY/$TESTDIR/$FILE?op=OPEN&user.name=$USER"
        ;;
        deleteFile)
                echo "Delete $TESTDIR/$FILE"
                curl -i -X DELETE "$QUERY/$TESTDIR/$FILE?op=DELETE&user.name=$USER"
        ;;
        deleteDir)
                echo "Delete directory $TESTDIR"
                curl -i -X DELETE "$QUERY/$TESTDIR?op=DELETE&user.name=$USER"
                # Try &recursive=true if directory non-empty
                # curl -i -X DELETE "$PREFIX/$TESTDIR?op=DELETE&user.name=$USER&recursive=true"
        ;;
        *)
                echo "Command not understood: $CMD"
                echo $USE
                exit 1
        ;;
esac
